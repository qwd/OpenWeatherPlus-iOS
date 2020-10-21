//
//  QWeatherNowWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherNowWeatherView.h"

@implementation QWeatherNowWeatherView
{
    NSArray *titleArray;
    NSArray *colorArray;
    UIView  *backView;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    
    self.backImageView = [UIImageView new];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backImageView];
    
    self.waterWaveView = [QWeatherWaterWaveView new];
    self.waterWaveView.image = UIImageMake(@"hefeng_wave");
    self.waterWaveView.contentMode =  UIViewContentModeScaleAspectFill;
    [self addSubview:self.waterWaveView];
    
    self.tempLabel = [QWeatherBaseLabel new];
    self.tempLabel.hefengFontSize = QWeatherFontSize_60;
    self.tempLabel.textColor = QWeatherColor_FFFFFF;
    self.tempLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tempLabel];
    
    self.weatherStateLabel = [QWeatherBaseLabel new];
    self.weatherStateLabel.hefengFontSize = QWeatherFontSize_16;
    self.weatherStateLabel.textColor = QWeatherColor_FFFFFF;
    self.weatherStateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.weatherStateLabel];
    
    
    colorArray = @[QWeatherColor_FFFFFF,QWeatherColor_318BF8,QWeatherColor_D1CA13,QWeatherColor_D76801,QWeatherColor_C01B09];
    
    backView = [UIView new];
    kViewRadius(backView, 10);
    [self addSubview:backView];
    
    self.alarmLabel = [QWeatherBaseLabel new];
    self.alarmLabel.hefengFontSize = QWeatherFontSize_12;
    self.alarmLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.alarmLabel];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    [self.waterWaveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(0);
        make.height.equalTo(45);
    }];
    [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(10);
        make.top.equalTo(QWeatherAdaptedHeight(125));
        
    }];
    [self.weatherStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.tempLabel.mas_bottom).offset(14);
    }];
    [self.alarmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
    }];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weatherStateLabel.mas_bottom).offset(14);
        make.edges.equalTo(self.alarmLabel).offset(UIEdgeInsetsMake(-4, -14, -4, -14));
    }];
    
}
-(void)reloadViewWithModel:(QWeatherHomeTabelViewDataModel *)model{
    titleArray =[QWeatherManager isEnglish]? @[@"White",@"Blue",@"Yellow",@"Orange",@"Red"]: @[@"白色",@"蓝色",@"黄色",@"橙色",@"红色"];
    self.tempLabel.hefengTempString = model.now.temp;
    self.weatherStateLabel.text = model.now.text;
    self.backImageView.image = [[QWeatherWeatherTool getWeatherImageWithWeatherCode:model.now.icon date:model.updateTime formatString:QWeatherBgImageFormatString] qmui_imageResizedInLimitedSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-160-NavigationContentTop) resizingMode:QMUIImageResizingModeScaleAspectFill scale:ScreenScale];
    
    if (model.AlarmDataModel.warning.count>0) {
        //文字
        if ([QWeatherManager isEnglish]) {
            self.alarmLabel.text  = model.AlarmDataModel.warning.firstObject.type;
        }else{
            self.alarmLabel.text = QWeatherStringFormat(@"%@%@",model.AlarmDataModel.warning.firstObject.type,@"预警");
        }
        //文字颜色
        if (QWeatherStrEqual(model.AlarmDataModel.warning.firstObject.level, @"白色")||QWeatherStrEqual(model.AlarmDataModel.warning.firstObject.level, @"White")) {
            self.alarmLabel.textColor = QWeatherColor_333333;
        }else{
            self.alarmLabel.textColor = QWeatherColor_FFFFFF;
        }
        //背景颜色
        if ([titleArray containsObject:model.AlarmDataModel.warning.firstObject.level]) {
            backView.backgroundColor = [colorArray objectAtIndex:[titleArray indexOfObject:model.AlarmDataModel.warning.firstObject.level]];
        }else{
            backView.backgroundColor = KClearColor;
        }
    }else{
        self.alarmLabel.text = @"";
        backView.backgroundColor = KClearColor;
    }
}

@end
