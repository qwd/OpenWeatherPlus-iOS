//
//  HeFengHomeCollectionViewCell.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengHomeCollectionViewCell.h"
#import "HeFengRefreshHeader.h"

@implementation HeFengHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = HeFengColor_F7F8FA;
    [self.contentView addSubview:self.scrollView];
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationRefreshEnd object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self.scrollView.mj_header endRefreshing];
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
-(HeFengHomeScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [HeFengHomeScrollView new];
        _scrollView.mj_header =  [HeFengRefreshHeader headerWithRefreshingBlock:^{
            HeFengPostNotification(KNotificationRefreshHomeData, nil);
        }];
    }
    return _scrollView;
}
@end
