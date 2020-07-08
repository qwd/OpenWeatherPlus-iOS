//
//  HeFengHourlyWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengHourlyWeatherView.h"

@implementation HeFengHourlyWeatherView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
       
    }
    return self;
}
-(void)configUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.maxTempLabel];
    [self addSubview:self.minTempLabel];
    [self addSubview:self.weatherLineView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(Space_16);
    }];
    [self.maxTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(35);
    }];
    [self.minTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.top.equalTo(self.maxTempLabel.mas_bottom).offset(30);
        make.bottom.equalTo(-20);
        make.width.equalTo(self.maxTempLabel);
    }];
    [self.weatherLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.maxTempLabel.mas_right);
        make.top.equalTo(self.maxTempLabel);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    self.maxTempLabel.hefengTempString = model.dataModel.daily.firstObject.tempMax;
    self.minTempLabel.hefengTempString = model.dataModel.daily.firstObject.tempMin;
    [self.weatherLineView reloadViewWithModel:model];
}
-(HeFengBaseLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [HeFengBaseLabel new];
        _titleLabel.hefengFontSize = HeFengFontSize_16;
        _titleLabel.hefengLocalString = @"hengfengLocalString_28";
        _titleLabel.textColor = HeFengColor_212121;
    }
    return _titleLabel;
}
-(HeFengBaseLabel *)maxTempLabel{
    if (!_maxTempLabel) {
        _maxTempLabel = [HeFengBaseLabel new];
        _maxTempLabel.hefengFontSize = HeFengFontSize_14;
        _maxTempLabel.textColor = HeFengColor_ABABAB;
        _maxTempLabel.text = @"";
        
    }
    return _maxTempLabel;
}
-(HeFengBaseLabel *)minTempLabel{
    if (!_minTempLabel) {
        _minTempLabel = [HeFengBaseLabel new];
        _minTempLabel.hefengFontSize = HeFengFontSize_14;
        _minTempLabel.textColor = HeFengColor_ABABAB;
        _minTempLabel.text = @"";
    }
    return _minTempLabel;
}
-(HeFengHourlyLineView *)weatherLineView{
    if (!_weatherLineView) {
        _weatherLineView = [HeFengHourlyLineView new];
        _weatherLineView.viewType =HeFengHourlyLineViewTypeFree;
    }
    return _weatherLineView;
}
@end
