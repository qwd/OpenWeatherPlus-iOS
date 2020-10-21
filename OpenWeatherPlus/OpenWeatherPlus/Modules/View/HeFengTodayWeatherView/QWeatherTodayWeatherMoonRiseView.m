//
//  QWeatherTodayWeatherMoonRiseView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherTodayWeatherMoonRiseView.h"

@implementation QWeatherTodayWeatherMoonRiseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    [self addSubview:self.topLine];
    [self addSubview:self.titleLabel];
    [self addSubview:self.monthlyLabel];
    [self addSubview:self.monthlyTitleLabel];
    [self addSubview:self.moonfallLabel];
    [self addSubview:self.moonfallTitleLabel];
    [self addSubview:self.sunriseLabel];
    [self addSubview:self.sunriseTitleLabel];
    [self addSubview:self.sunsetLabel];
    [self addSubview:self.sunsetTitleLabel];
    [self addSubview:self.sunCurveView];
    [self addSubview:self.moonCurveView];

}
-(void)reloadViewWithModel:(QWeatherHomeTabelViewDataModel *)model{
    self.sunriseLabel.text = model.daily.firstObject.sunrise;
    self.sunsetLabel.text = model.daily.firstObject.sunset;
    self.monthlyLabel.text =model.daily.firstObject.moonrise;
    self.moonfallLabel.text = model.daily.firstObject.moonset;
    [self.sunCurveView setStartTime:QWeatherStringFormat(@"%@ %@",model.daily.firstObject.fxDate,model.daily.firstObject.sunrise) endTime:QWeatherStringFormat(@"%@ %@",model.daily.firstObject.fxDate,model.daily.firstObject.sunset) tz:model.basic.tz];
    [self.moonCurveView setStartTime:QWeatherStringFormat(@"%@ %@",model.daily.firstObject.fxDate,model.daily.firstObject.moonrise) endTime:QWeatherStringFormat(@"%@ %@",model.daily.firstObject.fxDate,model.daily.firstObject.moonset) tz:model.basic.tz];
   
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(Space_16);
        make.right.equalTo(-Space_16);
        make.height.equalTo(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(Space_16);
    }];
    
    [self.sunriseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-Space_16);
        make.left.equalTo(Space_16);
        make.height.equalTo(14);
    }];
    
    [self.sunriseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sunriseLabel.mas_top).offset(-4);
        make.left.width.equalTo(self.sunriseLabel);
        make.height.equalTo(14);
        
    }];
    
    [self.sunsetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sunriseLabel);
        make.right.equalTo(self.mas_centerX).offset(-Space_16);
        make.height.equalTo(14);
    }];
    
    [self.sunsetTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sunsetLabel.mas_top).offset(-4);
        make.right.width.equalTo(self.sunsetLabel);
        make.height.equalTo(14);
    }];
    
    [self.monthlyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sunriseLabel);
        make.left.equalTo(self.mas_centerX).offset(Space_16);
        make.height.equalTo(14);
    }];
    
    [self.monthlyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.monthlyLabel.mas_top).offset(-4);
        make.left.width.equalTo(self.monthlyLabel);
        make.height.equalTo(14);
    }];
    
    [self.moonfallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sunriseLabel);
        make.right.equalTo(-Space_16);
        make.height.equalTo(14);
    }];
    
    [self.moonfallTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.moonfallLabel.mas_top).offset(-4);
        make.right.width.equalTo(self.moonfallLabel);
        make.height.equalTo(14);
    }];
  
    [self.sunCurveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sunriseLabel.mas_centerX).offset(-10);
        make.right.equalTo(self.sunsetLabel.mas_centerX).offset(10);
        make.bottom.equalTo(self.sunriseTitleLabel.mas_top).offset(-10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Space_16);
        make.height.equalTo(self.sunCurveView.mas_width).multipliedBy(0.5);
    }];
    [self.moonCurveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.bottom.equalTo(self.sunCurveView);
        make.right.equalTo(self.moonfallLabel.mas_centerX).offset(10);
    }];

}
-(UIView *)topLine{
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = QWeatherColor_ECECEC;
    }
    return _topLine;
}
-(QWeatherBaseLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QWeatherBaseLabel new];
        _titleLabel.hefengFontSize = QWeatherFontSize_12;
        _titleLabel.hefengLocalString = @"hengfengLocalString_8";
        _titleLabel.textColor = QWeatherColor_4A4A4A;
    }
    return _titleLabel;
}
-(QWeatherBaseLabel *)monthlyLabel{
    if (!_monthlyLabel) {
        _monthlyLabel = [QWeatherBaseLabel new];
        _monthlyLabel.hefengFontSize = QWeatherFontSize_14;
        _monthlyLabel.textAlignment = NSTextAlignmentCenter;
        _monthlyLabel.textColor = QWeatherColor_212121;
    }
    return _monthlyLabel;
}
-(QWeatherBaseLabel *)monthlyTitleLabel{
    if (!_monthlyTitleLabel) {
        _monthlyTitleLabel = [QWeatherBaseLabel new];
        _monthlyTitleLabel.hefengFontSize = QWeatherFontSize_14;
        _monthlyTitleLabel.textColor = QWeatherColor_A4A4A4;
        _monthlyTitleLabel.hefengLocalString = @"hengfengLocalString_11";
        _monthlyTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthlyTitleLabel;
}
-(QWeatherBaseLabel *)moonfallLabel{
    if (!_moonfallLabel) {
        _moonfallLabel = [QWeatherBaseLabel new];
        _moonfallLabel.hefengFontSize = QWeatherFontSize_14;
        _moonfallLabel.textAlignment = NSTextAlignmentCenter;
        _moonfallLabel.textColor = QWeatherColor_212121;
    }
    return _moonfallLabel;
}
-(QWeatherBaseLabel *)moonfallTitleLabel{
    if (!_moonfallTitleLabel) {
        _moonfallTitleLabel = [QWeatherBaseLabel new];
        _moonfallTitleLabel.hefengFontSize = QWeatherFontSize_14;
        _moonfallTitleLabel.hefengLocalString = @"hengfengLocalString_12";
        _moonfallTitleLabel.textAlignment = NSTextAlignmentCenter;
        _moonfallTitleLabel.textColor = QWeatherColor_A4A4A4;
    }
    return _moonfallTitleLabel;
}
-(QWeatherBaseLabel *)sunriseLabel{
    if (!_sunriseLabel) {
        _sunriseLabel = [QWeatherBaseLabel new];
        _sunriseLabel.hefengFontSize = QWeatherFontSize_14;
        _sunriseLabel.textAlignment = NSTextAlignmentCenter;
        _sunriseLabel.textColor = QWeatherColor_212121;
    }
    return _sunriseLabel;
}
-(QWeatherBaseLabel *)sunriseTitleLabel{
    if (!_sunriseTitleLabel) {
        _sunriseTitleLabel = [QWeatherBaseLabel new];
        _sunriseTitleLabel.hefengFontSize = QWeatherFontSize_14;
        _sunriseTitleLabel.hefengLocalString = @"hengfengLocalString_9";
        _sunriseTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sunriseTitleLabel.textColor = QWeatherColor_A4A4A4;
    }
    return _sunriseTitleLabel;
}
-(QWeatherBaseLabel *)sunsetLabel{
    if (!_sunsetLabel) {
        _sunsetLabel = [QWeatherBaseLabel new];
        _sunsetLabel.hefengFontSize = QWeatherFontSize_14;
        _sunsetLabel.textAlignment = NSTextAlignmentCenter;
        _sunsetLabel.textColor = QWeatherColor_212121;
    }
    return _sunsetLabel;
}
-(QWeatherBaseLabel *)sunsetTitleLabel{
    if (!_sunsetTitleLabel) {
        _sunsetTitleLabel = [QWeatherBaseLabel new];
        _sunsetTitleLabel.hefengFontSize = QWeatherFontSize_14;
        _sunsetTitleLabel.hefengLocalString = @"hengfengLocalString_10";
        _sunsetTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sunsetTitleLabel.textColor = QWeatherColor_A4A4A4;
    }
    return _sunsetTitleLabel;
}
- (QWeatherTodayWeatherMoonRiseCurveView *)sunCurveView{
    if (!_sunCurveView) {
        _sunCurveView = [QWeatherTodayWeatherMoonRiseCurveView new];
        _sunCurveView.imageView.image = UIImageMake(@"hefeng_sun");
    }
    return _sunCurveView;
}
-(QWeatherTodayWeatherMoonRiseCurveView *)moonCurveView{
    if (!_moonCurveView) {
        _moonCurveView = [QWeatherTodayWeatherMoonRiseCurveView new];
        _moonCurveView.imageView.image = UIImageMake(@"hefeng_moon");
    }
    return _moonCurveView;
}

@end
