//
//  HeFengNowWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengNowWeatherView.h"

@implementation HeFengNowWeatherView

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
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    self.tempLabel.hefengTempString = model.dataModel.now.tmp;
    self.weatherStateLabel.text = model.dataModel.now.cond_txt;
    self.backImageView.image = [[HeFengWeatherTool getWeatherImageWithWeatherCode:model.dataModel.now.cond_code date:model.dataModel.update.loc formatString:HeFengBgImageFormatString] qmui_imageResizedInLimitedSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-160-NavigationContentTop) resizingMode:QMUIImageResizingModeScaleAspectFill scale:ScreenScale];
}

@end
