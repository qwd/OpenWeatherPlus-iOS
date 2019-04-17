//
//  HeFengNowWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengNowWeatherView.h"

@implementation HeFengNowWeatherView
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
    
    self.waterWaveView = [HeFengWaterWaveView new];
    self.waterWaveView.image = UIImageMake(@"hefeng_wave");
    self.waterWaveView.contentMode =  UIViewContentModeScaleAspectFill;
    [self addSubview:self.waterWaveView];
    
    self.tempLabel = [HeFengBaseLabel new];
    self.tempLabel.hefengFontSize = HeFengFontSize_60;
    self.tempLabel.textColor = HeFengColor_FFFFFF;
    self.tempLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tempLabel];
    
    self.weatherStateLabel = [HeFengBaseLabel new];
    self.weatherStateLabel.hefengFontSize = HeFengFontSize_16;
    self.weatherStateLabel.textColor = HeFengColor_FFFFFF;
    self.weatherStateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.weatherStateLabel];
    
    
    colorArray = @[HeFengColor_FFFFFF,HeFengColor_318BF8,HeFengColor_D1CA13,HeFengColor_D76801,HeFengColor_C01B09];
    
    backView = [UIView new];
    kViewRadius(backView, 10);
    [self addSubview:backView];
    
    self.alarmLabel = [HeFengBaseLabel new];
    self.alarmLabel.hefengFontSize = HeFengFontSize_12;
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
        make.top.equalTo(HeFengAdaptedHeight(125));
        
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
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    titleArray =[HeFengWeatherManager isEnglish]? @[@"White",@"Blue",@"Yellow",@"Orange",@"Red"]: @[@"白色",@"蓝色",@"黄色",@"橙色",@"红色"];
    self.tempLabel.hefengTempString = model.dataModel.now.tmp;
    self.weatherStateLabel.text = model.dataModel.now.cond_txt;
    self.backImageView.image = [[HeFengWeatherTool getWeatherImageWithWeatherCode:model.dataModel.now.cond_code date:model.dataModel.update.loc formatString:HeFengBgImageFormatString] qmui_imageResizedInLimitedSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-160-NavigationContentTop) resizingMode:QMUIImageResizingModeScaleAspectFill scale:ScreenScale];
    
    if (model.AlarmDataModel.alarm.count>0) {
        //文字
        if ([HeFengWeatherManager isEnglish]) {
            self.alarmLabel.text  = model.AlarmDataModel.alarm.firstObject.type;
        }else{
            self.alarmLabel.text = HeFengStringFormat(@"%@%@",model.AlarmDataModel.alarm.firstObject.type,@"预警");
        }
        //文字颜色
        if (HeFengStrEqual(model.AlarmDataModel.alarm.firstObject.level, @"白色")||HeFengStrEqual(model.AlarmDataModel.alarm.firstObject.level, @"White")) {
            self.alarmLabel.textColor = HeFengColor_333333;
        }else{
            self.alarmLabel.textColor = HeFengColor_FFFFFF;
        }
        //背景颜色
        if ([titleArray containsObject:model.AlarmDataModel.alarm.firstObject.level]) {
            backView.backgroundColor = [colorArray objectAtIndex:[titleArray indexOfObject:model.AlarmDataModel.alarm.firstObject.level]];
        }else{
            backView.backgroundColor = KClearColor;
        }
    }else{
        self.alarmLabel.text = @"";
        backView.backgroundColor = KClearColor;
    }
}

@end
