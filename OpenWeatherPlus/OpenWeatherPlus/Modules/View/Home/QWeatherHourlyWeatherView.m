//
//  QWeatherHourlyWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherHourlyWeatherView.h"

@implementation QWeatherHourlyWeatherView

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
-(void)reloadViewWithModel:(QWeatherHomeTabelViewDataModel *)model{
    self.maxTempLabel.hefengTempString = model.daily.firstObject.tempMax;
    self.minTempLabel.hefengTempString = model.daily.firstObject.tempMin;
    [self.weatherLineView reloadViewWithModel:model];
}
-(QWeatherBaseLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QWeatherBaseLabel new];
        _titleLabel.hefengFontSize = QWeatherFontSize_16;
        _titleLabel.hefengLocalString = @"hengfengLocalString_28";
        _titleLabel.textColor = QWeatherColor_212121;
    }
    return _titleLabel;
}
-(QWeatherBaseLabel *)maxTempLabel{
    if (!_maxTempLabel) {
        _maxTempLabel = [QWeatherBaseLabel new];
        _maxTempLabel.hefengFontSize = QWeatherFontSize_14;
        _maxTempLabel.textColor = QWeatherColor_ABABAB;
        _maxTempLabel.text = @"";
        
    }
    return _maxTempLabel;
}
-(QWeatherBaseLabel *)minTempLabel{
    if (!_minTempLabel) {
        _minTempLabel = [QWeatherBaseLabel new];
        _minTempLabel.hefengFontSize = QWeatherFontSize_14;
        _minTempLabel.textColor = QWeatherColor_ABABAB;
        _minTempLabel.text = @"";
    }
    return _minTempLabel;
}
-(QWeatherHourlyLineView *)weatherLineView{
    if (!_weatherLineView) {
        _weatherLineView = [QWeatherHourlyLineView new];
        _weatherLineView.viewType =QWeatherHourlyLineViewTypeFree;
    }
    return _weatherLineView;
}
@end
