//
//  HeFengTodayWeatherMoonRiseView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengTodayWeatherMoonRiseView.h"

@implementation HeFengTodayWeatherMoonRiseView

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
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    self.sunriseLabel.text = model.dataModel.daily.firstObject.sunrise;
    self.sunsetLabel.text = model.dataModel.daily.firstObject.sunset;
    self.monthlyLabel.text =model.dataModel.daily.firstObject.moonrise;
    self.moonfallLabel.text = model.dataModel.daily.firstObject.moonset;
    [self.sunCurveView setStartTime:HeFengStringFormat(@"%@ %@",model.dataModel.daily.firstObject.fxDate,model.dataModel.daily.firstObject.sunrise) endTime:HeFengStringFormat(@"%@ %@",model.dataModel.daily.firstObject.fxDate,model.dataModel.daily.firstObject.sunset) tz:model.basic.tz];
    [self.moonCurveView setStartTime:HeFengStringFormat(@"%@ %@",model.dataModel.daily.firstObject.fxDate,model.dataModel.daily.firstObject.moonrise) endTime:HeFengStringFormat(@"%@ %@",model.dataModel.daily.firstObject.fxDate,model.dataModel.daily.firstObject.moonset) tz:model.basic.tz];
   
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
        _topLine.backgroundColor = HeFengColor_ECECEC;
    }
    return _topLine;
}
-(HeFengBaseLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [HeFengBaseLabel new];
        _titleLabel.hefengFontSize = HeFengFontSize_12;
        _titleLabel.hefengLocalString = @"hengfengLocalString_8";
        _titleLabel.textColor = HeFengColor_4A4A4A;
    }
    return _titleLabel;
}
-(HeFengBaseLabel *)monthlyLabel{
    if (!_monthlyLabel) {
        _monthlyLabel = [HeFengBaseLabel new];
        _monthlyLabel.hefengFontSize = HeFengFontSize_14;
        _monthlyLabel.textAlignment = NSTextAlignmentCenter;
        _monthlyLabel.textColor = HeFengColor_212121;
    }
    return _monthlyLabel;
}
-(HeFengBaseLabel *)monthlyTitleLabel{
    if (!_monthlyTitleLabel) {
        _monthlyTitleLabel = [HeFengBaseLabel new];
        _monthlyTitleLabel.hefengFontSize = HeFengFontSize_14;
        _monthlyTitleLabel.textColor = HeFengColor_A4A4A4;
        _monthlyTitleLabel.hefengLocalString = @"hengfengLocalString_11";
        _monthlyTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthlyTitleLabel;
}
-(HeFengBaseLabel *)moonfallLabel{
    if (!_moonfallLabel) {
        _moonfallLabel = [HeFengBaseLabel new];
        _moonfallLabel.hefengFontSize = HeFengFontSize_14;
        _moonfallLabel.textAlignment = NSTextAlignmentCenter;
        _moonfallLabel.textColor = HeFengColor_212121;
    }
    return _moonfallLabel;
}
-(HeFengBaseLabel *)moonfallTitleLabel{
    if (!_moonfallTitleLabel) {
        _moonfallTitleLabel = [HeFengBaseLabel new];
        _moonfallTitleLabel.hefengFontSize = HeFengFontSize_14;
        _moonfallTitleLabel.hefengLocalString = @"hengfengLocalString_12";
        _moonfallTitleLabel.textAlignment = NSTextAlignmentCenter;
        _moonfallTitleLabel.textColor = HeFengColor_A4A4A4;
    }
    return _moonfallTitleLabel;
}
-(HeFengBaseLabel *)sunriseLabel{
    if (!_sunriseLabel) {
        _sunriseLabel = [HeFengBaseLabel new];
        _sunriseLabel.hefengFontSize = HeFengFontSize_14;
        _sunriseLabel.textAlignment = NSTextAlignmentCenter;
        _sunriseLabel.textColor = HeFengColor_212121;
    }
    return _sunriseLabel;
}
-(HeFengBaseLabel *)sunriseTitleLabel{
    if (!_sunriseTitleLabel) {
        _sunriseTitleLabel = [HeFengBaseLabel new];
        _sunriseTitleLabel.hefengFontSize = HeFengFontSize_14;
        _sunriseTitleLabel.hefengLocalString = @"hengfengLocalString_9";
        _sunriseTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sunriseTitleLabel.textColor = HeFengColor_A4A4A4;
    }
    return _sunriseTitleLabel;
}
-(HeFengBaseLabel *)sunsetLabel{
    if (!_sunsetLabel) {
        _sunsetLabel = [HeFengBaseLabel new];
        _sunsetLabel.hefengFontSize = HeFengFontSize_14;
        _sunsetLabel.textAlignment = NSTextAlignmentCenter;
        _sunsetLabel.textColor = HeFengColor_212121;
    }
    return _sunsetLabel;
}
-(HeFengBaseLabel *)sunsetTitleLabel{
    if (!_sunsetTitleLabel) {
        _sunsetTitleLabel = [HeFengBaseLabel new];
        _sunsetTitleLabel.hefengFontSize = HeFengFontSize_14;
        _sunsetTitleLabel.hefengLocalString = @"hengfengLocalString_10";
        _sunsetTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sunsetTitleLabel.textColor = HeFengColor_A4A4A4;
    }
    return _sunsetTitleLabel;
}
- (HeFengTodayWeatherMoonRiseCurveView *)sunCurveView{
    if (!_sunCurveView) {
        _sunCurveView = [HeFengTodayWeatherMoonRiseCurveView new];
        _sunCurveView.imageView.image = UIImageMake(@"hefeng_sun");
    }
    return _sunCurveView;
}
-(HeFengTodayWeatherMoonRiseCurveView *)moonCurveView{
    if (!_moonCurveView) {
        _moonCurveView = [HeFengTodayWeatherMoonRiseCurveView new];
        _moonCurveView.imageView.image = UIImageMake(@"hefeng_moon");
    }
    return _moonCurveView;
}

@end
