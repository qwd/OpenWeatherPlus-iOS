//
//  HeFengSearchViewController.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengSearchViewController.h"
#import "HeFengSearchBarView.h"
#import "HeFengSearchCell.h"
#import "HeFengCollectionCityCell.h"
#import "HeFengWeatherRequest.h"

@interface HeFengSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) HeFengSearchBarView *searchView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) HeFengWeatherRequest *weatherRequest;
@property (nonatomic,strong) NSArray<SearchBaseClassBasic *> *searchCityArray;
@property (nonatomic,copy) NSString *searchText;
@property (nonatomic,strong) NSArray *citysArray;
@end

@implementation HeFengSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = HeFengLocal(@"hengfengLocalString_36");
    [self configUI];
    [self configLayout];
}
-(void)configUI{
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    [[[self.searchView.searchTextField rac_textSignal]skip:1] subscribeNext:^(NSString * _Nullable x) {
        self.searchText = x;
        if (HeFengStrValid(x)) {
            [[self.weatherRequest.citySearchCommand execute:@{@"location":[x qmui_trimAllWhiteSpace]}] subscribeNext:^(SearchBaseClass  * x) {
                if (x.basic.count>0) {
                    self.searchCityArray = x.basic;
                }else{
                    self.searchCityArray = @[];
                }
                if (self.isSelectLocatin) {
                    self.collectionView.hidden = self.searchCityArray.count>0;
                }
                [self reload];
            } error:^(NSError * _Nullable error) {
                if (self.isSelectLocatin) {
                    self.collectionView.hidden = NO;
                }
                self.searchCityArray = @[];
                [self reload];
            }];
        }else{
            if (self.isSelectLocatin) {
                self.collectionView.hidden = NO;
            }
            self.searchCityArray = @[];
            [self reload];
        }
    }];
}
-(void)reload{
    self.tableView.backgroundColor = self.searchCityArray.count==0?HeFengColor_ECECEC:HeFengColor_FAFAFA;
    [self.tableView reloadData];
    [self updateLayout];
}
-(void)updateLayout{
    if (self.searchCityArray.count>0) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }else{
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
        }];
    }
    [self.view layoutIfNeeded];
}
-(void)configLayout{
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(0);
        make.height.equalTo(56);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom);
        make.left.equalTo(Space_16);
        make.height.equalTo(50);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView);
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchCityArray.count>0) {
        return self.searchCityArray.count;
    }else{
        return HeFengWeatherManager.collectionDataArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeFengSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeFengSearchCell class])];
    if (self.searchCityArray.count>0) {
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[self cityTitleWithSearchModel:self.searchCityArray[indexPath.row]]];
        text.yy_color = HeFengColor_7A7A7A;
        [text yy_setColor:HeFengColor_ED802D range:[[self cityTitleWithSearchModel:self.searchCityArray[indexPath.row]] rangeOfString:self.searchText]];
        cell.titleLabel.attributedText = text;
    }else{
        cell.titleLabel.text = [self cityTitleWithModel:HeFengWeatherManager.collectionDataArray[indexPath.row].dataModel.basic];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSelectLocatin) {
        HeFengWeatherManager.selectLocation = self.searchCityArray[indexPath.row].cid;
        HeFengPostNotification(KNotificationRestRootVC, nil);
    }else{
        if (self.searchCityArray.count>0) {
            HeFengPostNotification(KNotificationRefreshCity,self.searchCityArray[indexPath.row].cid);
        }else{
            HeFengPostNotification(KNotificationRefreshCity,HeFengWeatherManager.collectionDataArray[indexPath.row].dataModel.basic.cid);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(NSString *)cityTitleWithSearchModel:(SearchBaseClassBasic *)model{
    NSMutableArray *array = [NSMutableArray array];
    if (HeFengStrValid(model.location)) {
        [array addObject:model.location];
    }
    if (HeFengStrValid(model.parent_city)) {
        [array addObject:model.parent_city];
    }
    if (HeFengStrValid(model.admin_area)) {
        [array addObject:model.admin_area];
    }
    if (HeFengStrValid(model.cnty)) {
        [array addObject:model.cnty];
    }
    NSMutableArray *titleArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArray addObject:[obj capitalizedString]];
    }];
    return [titleArray componentsJoinedByString:@","];
}
-(NSString *)cityTitleWithModel:(WeatherBaseClassBasic *)model{
    NSMutableArray *array = [NSMutableArray array];
    if (HeFengStrValid(model.location)) {
        [array addObject:model.location];
    }
    if (HeFengStrValid(model.parent_city)) {
        [array addObject:model.parent_city];
    }
    if (HeFengStrValid(model.admin_area)) {
        [array addObject:model.admin_area];
    }
    if (HeFengStrValid(model.cnty)) {
        [array addObject:model.cnty];
    }
    NSMutableArray *titleArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArray addObject:[obj capitalizedString]];
    }];
    return [titleArray componentsJoinedByString:@","];
}
#pragma mark ---- UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.citysArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeFengCollectionCityCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeFengCollectionCityCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.citysArray[indexPath.row];
    return cell;
}


#pragma mark ---- UICollectionViewDelegateFlowLayout

//动态设置每个Item的尺寸大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){(collectionView.qmui_width-Space_16*4)/3,40};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Space_16, Space_16, 0, Space_16);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Space_16;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeFengWeatherManager.selectLocation = self.citysArray[indexPath.row];
    HeFengPostNotification(KNotificationRestRootVC, nil);
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        [_collectionView registerClass:[HeFengCollectionCityCell class] forCellWithReuseIdentifier:NSStringFromClass([HeFengCollectionCityCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = HeFengColor_ECECEC;
        _collectionView.hidden = !self.isSelectLocatin;
    }
    return _collectionView;
}
-(HeFengSearchBarView *)searchView{
    if (!_searchView) {
        _searchView = [HeFengSearchBarView new];
    }
    return _searchView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = HeFengColor_ECECEC;
        [_tableView registerClass:[HeFengSearchCell class] forCellReuseIdentifier:NSStringFromClass([HeFengSearchCell class])];
    }
    return _tableView;
}
-(HeFengWeatherRequest *)weatherRequest{
    if (!_weatherRequest) {
        _weatherRequest = [HeFengWeatherRequest new];
    }
    return _weatherRequest;
}
-(NSArray *)citysArray{
    if (!_citysArray) {
        _citysArray =   @[
                          @"洛杉矶",
                          @"北京",
                          @"上海",
                          @"深圳",
                          @"伦敦",
                          @"杭州",
                          @"重庆",
                          @"武汉",
                          @"西安",
                          @"纽约",
                          @"巴黎",
                          @"莫斯科",
                          ];
    }
    return _citysArray;
}
-(HeFengBaseLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [HeFengBaseLabel new];
        _titleLabel.hefengFontSize = 12;
        _titleLabel.textColor = HeFengColor_7A7A7A;
        _titleLabel.hefengLocalString = self.isSelectLocatin? @"hengfengLocalString_50":@"hengfengLocalString_45";
    }
    return _titleLabel;
}

@end
