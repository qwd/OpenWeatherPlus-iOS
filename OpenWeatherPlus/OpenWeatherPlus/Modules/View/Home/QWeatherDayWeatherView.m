//
//  QWeatherDayWeatherView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherDayWeatherView.h"
#import "QWeatherDayWeatherRowView.h"
@interface QWeatherDayWeatherView()
@property (nonatomic,strong) NSMutableArray<QWeatherDayWeatherRowView*> *rowViewArray;
@end
@implementation QWeatherDayWeatherView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.backgroundColor = QWeatherColor_F0F0F0;
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
-(void)reloadViewWithModel:(QWeatherHomeTabelViewDataModel *)model{
    [self.rowViewArray enumerateObjectsUsingBlock:^(QWeatherDayWeatherRowView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.rowViewArray removeAllObjects];
    
    [model.daily enumerateObjectsUsingBlock:^(Daily * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QWeatherDayWeatherRowView *view = [QWeatherDayWeatherRowView new];
        view.dayLabel.hefengFontSize = QWeatherFontSize_14;
        view.dayLabel.textColor = idx==0?QWeatherColor_212121:QWeatherColor_A4A4A4;
        view.maxTempLabel.hefengFontSize = QWeatherFontSize_14;
        view.maxTempLabel.textColor = QWeatherColor_4A4A4A;
        view.minTempLabel.hefengFontSize = QWeatherFontSize_14;
        view.minTempLabel.textColor = QWeatherColor_7A7A7A;
        [self addSubview:view];
        [self.rowViewArray addObject:view];
    }];
    [self.rowViewArray enumerateObjectsUsingBlock:^(QWeatherDayWeatherRowView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.dayLabel.text = QWeatherLocal([QWeatherWeatherTool getTimeStringWithSting:model.daily[idx].fxDate dateformat:QWeatherFormatString3 isShowToday:YES]);
        obj.maxTempLabel.hefengTempString = model.daily[idx].tempMax;
        obj.minTempLabel.hefengTempString = model.daily[idx].tempMin;
        obj.dayWeatherImageView.image = [QWeatherWeatherTool getWeatherImageWithWeatherCode:model.daily[idx].iconDay isDay:YES formatString:QWeatherWeatherImageFormatString];
        obj.nightWeatherImageView.image = [QWeatherWeatherTool getWeatherImageWithWeatherCode:model.daily[idx].iconNight isDay:NO formatString:QWeatherWeatherImageFormatString];
    }];
}
@end
