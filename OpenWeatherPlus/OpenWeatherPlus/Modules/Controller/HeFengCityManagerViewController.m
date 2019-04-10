//
//  HeFengCityManagerViewController.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengCityManagerViewController.h"
#import "HeFengCityManagerCell.h"

@interface HeFengCityManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HeFengCityManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = HeFengLocal(@"hengfengLocalString_14");
    [self configUI];
    [self configLayout];
}

-(void)configUI{
    [self.view addSubview:self.tableView];
}
-(void)configLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.mas_topLayoutGuide).offset(Space_16);
    }];
}
#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return HeFengWeatherManager.collectionDataArray.count-1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeFengCityManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeFengCityManagerCell class])];
    cell.titleLabel.text = HeFengWeatherManager.collectionDataArray[indexPath.row+1].dataModel.basic.location;
    [[[cell.delButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [HeFengWeatherManager delCollectionDataArrayWithIndex:indexPath.row+1];
        [tableView reloadData];
        HeFengPostNotification(KNotificationRefreshHomeData, nil);
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HeFengCityManagerCell class] forCellReuseIdentifier:NSStringFromClass([HeFengCityManagerCell class])];
    }
    return _tableView;
}
@end
