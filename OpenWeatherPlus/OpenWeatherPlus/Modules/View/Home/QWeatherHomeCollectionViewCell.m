//
//  QWeatherHomeCollectionViewCell.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherHomeCollectionViewCell.h"
#import "QWeatherRefreshHeader.h"

@implementation QWeatherHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = QWeatherColor_F7F8FA;
    [self.contentView addSubview:self.scrollView];
    [[QWeatherNotificationCenter rac_addObserverForName:KNotificationRefreshEnd object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self.scrollView.mj_header endRefreshing];
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
-(QWeatherHomeScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [QWeatherHomeScrollView new];
        _scrollView.mj_header =  [QWeatherRefreshHeader headerWithRefreshingBlock:^{
            QWeatherPostNotification(KNotificationRefreshHomeData, nil);
        }];
    }
    return _scrollView;
}
@end
