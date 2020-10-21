//
//  QWeatherHomeScrollView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//
#import "QWeatherHomeScrollView.h"
#import "QWeatherNowWeatherView.h"
#import "QWeatherHourlyWeatherView.h"
#import "QWeatherDayWeatherView.h"
#import "QWeatherTodayWeatherView.h"
#import "QWeatherInstructionView.h"
#import "QWeatherNowWeatherView.h"

@interface QWeatherHomeScrollView()
/**
 容器view
 */
@property (nonatomic,strong) UIView *contentView;
/**
 当前view
 */
@property (nonatomic,strong) QWeatherNowWeatherView *nowWeatherView;

/**
 24小时view
 */
@property (nonatomic,strong) QWeatherHourlyWeatherView *hourlyWeatherView;
/**
 三日天气view
 */
@property (nonatomic,strong) QWeatherDayWeatherView *threeDayWeatherView;

/**
 今日天气view
 */
@property (nonatomic,strong) QWeatherTodayWeatherView *todayWeatherView;
/**
 描述view
 */
@property (nonatomic,strong) QWeatherInstructionView *instructionView;
@end
@implementation QWeatherHomeScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.showsVerticalScrollIndicator = NO;
        [self configUI];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
    }];
    [self.nowWeatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(SCREEN_HEIGHT-160-NavigationContentTop);
    }];
    [self.hourlyWeatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.nowWeatherView.mas_bottom);
    }];
    [self.threeDayWeatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.hourlyWeatherView.mas_bottom);
    }];
    [self.todayWeatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.threeDayWeatherView.mas_bottom);
    }];
    [self.instructionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.todayWeatherView.mas_bottom);
        make.bottom.equalTo(0);
    }];
    
}
-(void)configUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.nowWeatherView];
    [self.contentView addSubview:self.hourlyWeatherView];
    [self.contentView addSubview:self.threeDayWeatherView];
    [self.contentView addSubview:self.todayWeatherView];
    [self.contentView addSubview:self.instructionView];
    
}
-(void)setDataModel:(QWeatherHomeTabelViewDataModel *)dataModel{
    _dataModel = dataModel;
    self.backgroundColor = [[[[QWeatherWeatherTool getWeatherImageWithWeatherCode:dataModel.now.icon date:dataModel.updateTime formatString:QWeatherBgImageFormatString] qmui_imageResizedInLimitedSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-160-NavigationContentTop) resizingMode:QMUIImageResizingModeScaleAspectFill scale:ScreenScale] qmui_imageResizedInLimitedSize:CGSizeMake(SCREEN_WIDTH, 1) resizingMode:QMUIImageResizingModeScaleAspectFillTop] qmui_averageColor];
    [self.nowWeatherView reloadViewWithModel:dataModel];
    [self.hourlyWeatherView reloadViewWithModel:dataModel];
    [self.threeDayWeatherView reloadViewWithModel:dataModel];
    [self.todayWeatherView reloadViewWithModel:dataModel];
    [self.instructionView reloadViewWithModel:dataModel];
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}
-(QWeatherNowWeatherView *)nowWeatherView{
    if (!_nowWeatherView) {
        _nowWeatherView = [QWeatherNowWeatherView new];
    }
    return _nowWeatherView;
}
-(QWeatherHourlyWeatherView *)hourlyWeatherView{
    if (!_hourlyWeatherView) {
        _hourlyWeatherView = [QWeatherHourlyWeatherView new];
    }
    return _hourlyWeatherView;
}
-(QWeatherDayWeatherView *)threeDayWeatherView{
    if (!_threeDayWeatherView) {
        _threeDayWeatherView = [QWeatherDayWeatherView new];
    }
    return _threeDayWeatherView;
}

-(QWeatherTodayWeatherView *)todayWeatherView{
    if (!_todayWeatherView) {
        _todayWeatherView = [QWeatherTodayWeatherView new];
    }
    return _todayWeatherView;
}
-(QWeatherInstructionView *)instructionView{
    if (!_instructionView) {
        _instructionView = [QWeatherInstructionView new];
    }
    return _instructionView;
}
@end
