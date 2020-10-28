//
//  QWeatherCityManagerViewController.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherCityManagerViewController.h"
#import "QWeatherCityManagerCell.h"

@interface QWeatherCityManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation QWeatherCityManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = QWeatherLocal(@"hengfengLocalString_14");
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
    return QWeatherManager.collectionDataArray.count-1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QWeatherCityManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QWeatherCityManagerCell class])];
    cell.titleLabel.text = QWeatherManager.collectionDataArray[indexPath.row+1].basic.name;
    [[[cell.delButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [QWeatherManager delCollectionDataArrayWithIndex:indexPath.row+1];
        [tableView reloadData];
        QWeatherPostNotification(KNotificationRefreshHomeData, nil);
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
        [_tableView registerClass:[QWeatherCityManagerCell class] forCellReuseIdentifier:NSStringFromClass([QWeatherCityManagerCell class])];
    }
    return _tableView;
}
@end
