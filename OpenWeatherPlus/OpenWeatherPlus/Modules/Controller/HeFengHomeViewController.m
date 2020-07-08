//
//  HeFengHomeViewController.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengHomeViewController.h"
#import "HeFengSettingViewController.h"
#import "HeFengSearchViewController.h"
#import "HeFengHomeCollectionViewCell.h"
#import "HeFengHomeNavView.h"
#import "HeFengWeatherRequest.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface HeFengHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AMapLocationManagerDelegate>
@property (nonatomic,strong) UICollectionView *weatherCollectionView;
@property (nonatomic,strong) HeFengHomeNavView *homeNavView;
@property (nonatomic,strong) HeFengWeatherRequest *weatherRequest;
@property (nonatomic,strong) AMapLocationManager *locationManager;
@end

@implementation HeFengHomeViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self configUI];
    [self configLayout];
    [self addNotice];
}

-(void)addNotice{
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationOpenSafari object:nil ]subscribeNext:^(NSNotification * _Nullable x) {
        [kApplication openURL:[NSURL URLWithString:@"https://www.heweather.com"]];
    }];
    
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationRefreshCity object:nil ]subscribeNext:^(NSNotification * _Nullable x) {
        [self getDataWithLocation:x.object isLoaction:NO];
    }];
    @weakify(self)
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationRefreshHomeData object:nil ]subscribeNext:^(NSNotification * _Nullable x) {
        [[self.weatherRequest.upDateHomeDataCommand execute:nil] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self reloadHomeData];
            HeFengPostNotification(KNotificationRefreshEnd, nil);
        } error:^(NSError * _Nullable error) {
            HeFengPostNotification(KNotificationRefreshEnd, nil);
        }];
    }];
    [[self.homeNavView.locationAddButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[HeFengSearchViewController new] animated:YES];
    }];
    
    [[self.homeNavView.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController pushViewController:[[HeFengSettingViewController alloc]initWithStyle:UITableViewStyleGrouped] animated:YES];
    }];
    
    if (HeFengWeatherManager.selectLocation) {
        [self getDataWithLocation:HeFengWeatherManager.selectLocation isLoaction:YES];
    }else{
        HeFengPostNotification(KNotificationRefreshHomeData, nil);
        if (![HeFengWeatherTool isLocationAuthorizationStatusDenied]) {
            [self.locationManager startUpdatingLocation];
        }
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    [self.locationManager stopUpdatingLocation];
    HeFengLogError(@"%@",error);
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    [self.locationManager stopUpdatingLocation];
    [self getDataWithLocation:HeFengStringFormat(@"%.2f,%.2f",location.coordinate.longitude,location.coordinate.latitude) isLoaction:YES];
}
-(void)getDataWithLocation:(NSString *)location isLoaction:(BOOL)isLoaction{
    NSDictionary *param = @{@"location":location};
    @weakify(self)
    [[self.weatherRequest.citySearchCommand execute:param] subscribeNext:^(GeoBaseClass * Geox) {
        @strongify(self)
        if (Geox.location.count>0) {
            [self.homeNavView.locationTitleButton setTitle:Geox.location.firstObject.name forState:UIControlStateNormal];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"cityId"] = Geox.location.firstObject.cid;
            param[@"location"] = Geox.location.firstObject.name;
            param[@"parent_city"] = Geox.location.firstObject.adm2?Geox.location.firstObject.adm2:@"";
            [[self.weatherRequest.homeDataCommand execute:param] subscribeNext:^(HeFengHomeTabelViewDataModel  * x) {
                x.basic = Geox.location.firstObject;
                @strongify(self)
                if (HeFengStrEqual(x.dataModel.code,@"200")) {
                    [HeFengWeatherManager addCollectionDataArrayWithModel:x isLoaction:isLoaction];
                }
                else{
                    HeFengLogError(@"%@",x.dataModel.code);
                }
                if (isLoaction) {
                    self.homeNavView.pageControl.currentPage = 0;
                    [self.weatherCollectionView qmui_scrollToTop];
                }
                [self reloadHomeData];
            }];
        }
    }];
}
-(void)reloadHomeData{
    if (HeFengWeatherManager.collectionDataArray.count==0) {
        return;
    }
    [self.homeNavView setPage:self.homeNavView.pageControl.currentPage];
    [self.weatherCollectionView reloadData];
}
-(void)configUI{
    [self.view addSubview:self.weatherCollectionView];
    [self.view addSubview:self.homeNavView];
    [self.homeNavView setPage:self.homeNavView.pageControl.currentPage];
    self.weatherCollectionView.backgroundColor = [self.homeNavView.image qmui_averageColor];
}
-(void)configLayout{
    [self.homeNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(NavigationContentTop);
    }];
    [self.weatherCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.homeNavView.mas_bottom);
    }];
}
#pragma mark - 代理方法 Delegate Methods
// 设置分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return HeFengWeatherManager.collectionDataArray.count;
}
// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeFengHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeFengHomeCollectionViewCell class]) forIndexPath:indexPath];
    cell.scrollView.dataModel = HeFengWeatherManager.collectionDataArray[indexPath.row];
    return cell;
}

// 设置cell大小 itemSize：可以给每一个cell指定不同的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.qmui_width, collectionView.qmui_height);
}
// 设置UIcollectionView整体的内边距（这样item不贴边显示）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
// 设置minimumLineSpacing：cell上下之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
// 设置minimumInteritemSpacing：cell左右之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point=scrollView.contentOffset;
    if (scrollView==self.weatherCollectionView) {
        [self.homeNavView setPage:[@(point.x/scrollView.qmui_width) integerValue]];
        self.weatherCollectionView.backgroundColor = [self.homeNavView.image qmui_averageColor];
    }
}

-(UICollectionView *)weatherCollectionView{
    if (!_weatherCollectionView) {
        QMUICollectionViewPagingLayout *flowLayout = [[QMUICollectionViewPagingLayout alloc]initWithStyle:QMUICollectionViewPagingLayoutStyleScale];
        flowLayout.minimumScale = 0.85;
        _weatherCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _weatherCollectionView.dataSource = self;
        _weatherCollectionView.delegate = self;
        _weatherCollectionView.pagingEnabled = YES;
        _weatherCollectionView.showsHorizontalScrollIndicator = NO;
        [_weatherCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeFengHomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HeFengHomeCollectionViewCell class])];
        if (@available(iOS 11.0, *)) {
            _weatherCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _weatherCollectionView;
}
-(HeFengHomeNavView *)homeNavView{
    if (!_homeNavView) {
        _homeNavView = [HeFengHomeNavView new];
    }
    return _homeNavView;
}
-(HeFengWeatherRequest *)weatherRequest{
    if (!_weatherRequest) {
        _weatherRequest = [HeFengWeatherRequest new];
    }
    return _weatherRequest;
}
-(AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
    }
    return _locationManager;
}

@end
