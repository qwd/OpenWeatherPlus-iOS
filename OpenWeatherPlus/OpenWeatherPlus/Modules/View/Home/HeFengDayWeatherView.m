//
//  HeFengDayWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengDayWeatherView.h"
#import "HeFengDayWeatherRowView.h"
@interface HeFengDayWeatherView()
@property (nonatomic,strong) NSMutableArray<HeFengDayWeatherRowView*> *rowViewArray;
@end
@implementation HeFengDayWeatherView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.backgroundColor = HeFengColor_F0F0F0;
    }
    return self;
}
-(void)configUI{
    self.rowViewArray = [NSMutableArray array];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.rowViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:30 leadSpacing:Space_16 tailSpacing:Space_16];
    [self.rowViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
    }];
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    [self.rowViewArray enumerateObjectsUsingBlock:^(HeFengDayWeatherRowView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.rowViewArray removeAllObjects];
    
    [model.dataModel.daily_forecast enumerateObjectsUsingBlock:^(WeatherBaseClassDaily_Forecast * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HeFengDayWeatherRowView *view = [HeFengDayWeatherRowView new];
        view.dayLabel.hefengFontSize = HeFengFontSize_14;
        view.dayLabel.textColor = idx==0?HeFengColor_212121:HeFengColor_A4A4A4;
        view.maxTempLabel.hefengFontSize = HeFengFontSize_14;
        view.maxTempLabel.textColor = HeFengColor_4A4A4A;
        view.minTempLabel.hefengFontSize = HeFengFontSize_14;
        view.minTempLabel.textColor = HeFengColor_7A7A7A;
        [self addSubview:view];
        [self.rowViewArray addObject:view];
    }];
    [self.rowViewArray enumerateObjectsUsingBlock:^(HeFengDayWeatherRowView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.dayLabel.text = HeFengLocal([HeFengWeatherTool getTimeStringWithSting:model.dataModel.daily_forecast[idx].date dateformat:HeFengFormatString3 isShowToday:YES]);
        obj.maxTempLabel.hefengTempString = model.dataModel.daily_forecast[idx].tmp_max;
        obj.minTempLabel.hefengTempString = model.dataModel.daily_forecast[idx].tmp_min;
        obj.dayWeatherImageView.image = [HeFengWeatherTool getWeatherImageWithWeatherCode:model.dataModel.daily_forecast[idx].cond_code_d isDay:YES formatString:HeFengWeatherImageFormatString];
        obj.nightWeatherImageView.image = [HeFengWeatherTool getWeatherImageWithWeatherCode:model.dataModel.daily_forecast[idx].cond_code_n isDay:NO formatString:HeFengWeatherImageFormatString];
    }];
}
@end
