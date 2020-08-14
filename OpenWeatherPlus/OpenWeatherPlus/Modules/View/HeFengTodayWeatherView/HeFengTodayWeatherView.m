//
//  HeFengTodayWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengTodayWeatherView.h"
#import "HeFengTodayWeatherItemView.h"
#import "HeFengTodayWeatherAQIView.h"
#import "HeFengTodayWeatherMoonRiseView.h"

@interface HeFengTodayWeatherView()
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) NSMutableArray<HeFengTodayWeatherItemView*> *itemViewArray;
@property (nonatomic,strong) HeFengTodayWeatherAQIView *aqiView;
@property (nonatomic,strong) HeFengTodayWeatherMoonRiseView *moonRiseView;
@property (nonatomic,strong) UIStackView *aqiBackView;
@end
@implementation HeFengTodayWeatherView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    [self addSubview:self.titleLabel];
    [self itemViewArray];
    [self addSubview:self.aqiBackView];
    [self addSubview:self.moonRiseView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.top.equalTo(Space_16);
    }];
#pragma mark item
    [self.itemViewArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_32);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Space_16);
        make.right.equalTo(self.mas_centerX);
        make.height.equalTo(40);
    }];
    [self.itemViewArray[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(Space_32);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Space_16);
        make.height.width.equalTo(self.itemViewArray[0]);
        
    }];
    [self.itemViewArray[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_32);
        make.top.equalTo(self.itemViewArray[0].mas_bottom).offset(Space_16);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(Space_32);
        make.top.equalTo(self.itemViewArray[0].mas_bottom).offset(Space_16);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_32);
        make.top.equalTo(self.itemViewArray[2].mas_bottom).offset(Space_16);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[5] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(Space_32);
        make.top.equalTo(self.itemViewArray[2].mas_bottom).offset(Space_16);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[6] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_32);
        make.top.equalTo(self.itemViewArray[4].mas_bottom).offset(Space_16);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
#pragma mark aqi
    [self.aqiBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemViewArray[6].mas_bottom).offset(Space_16);
        make.left.right.equalTo(0);
    }];
#pragma mark moonrise
    [self.moonRiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aqiBackView.mas_bottom);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    [self.aqiView reloadViewWithModel:model];
    [self.moonRiseView reloadViewWithModel:model];
    [self.itemViewArray enumerateObjectsUsingBlock:^(HeFengTodayWeatherItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj reloadViewWithModel:model];
    }];
    self.aqiView.hidden = !model.airDataModel.now.pm2p5;
}
-(HeFengBaseLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [HeFengBaseLabel new];
        _titleLabel.hefengLocalString = @"hengfengLocalString_1";
        _titleLabel.hefengFontSize = HeFengFontSize_16;
        _titleLabel.textColor = HeFengColor_212121;
    }
    return _titleLabel;
}
-(NSMutableArray<HeFengTodayWeatherItemView *> *)itemViewArray{
    if (!_itemViewArray) {
        _itemViewArray = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            HeFengTodayWeatherItemView *view = [HeFengTodayWeatherItemView new];
            view.idx = i;
            [self addSubview:view];
            [_itemViewArray addObject:view];
        }
    }
    return _itemViewArray;
}

-(HeFengTodayWeatherAQIView *)aqiView{
    if (!_aqiView) {
        _aqiView = [HeFengTodayWeatherAQIView new];
    }
    return _aqiView;
}
-(HeFengTodayWeatherMoonRiseView *)moonRiseView{
    if (!_moonRiseView) {
        _moonRiseView = [HeFengTodayWeatherMoonRiseView new];
    }
    return _moonRiseView;
}
-(UIStackView *)aqiBackView{
    if (!_aqiBackView) {
        _aqiBackView = [UIStackView new];
        _aqiBackView.alignment = UIStackViewAlignmentFill;
        [_aqiBackView addArrangedSubview:self.aqiView];
    }
    return _aqiBackView;
}
@end
