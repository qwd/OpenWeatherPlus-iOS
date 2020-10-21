//
//  QWeatherTodayWeatherMoonRiseView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"
#import "QWeatherTodayWeatherMoonRiseCurveView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherTodayWeatherMoonRiseView : QWeatherBaseView

@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) QWeatherBaseLabel *titleLabel;
@property (nonatomic,strong) QWeatherBaseLabel *monthlyLabel;
@property (nonatomic,strong) QWeatherBaseLabel *moonfallLabel;
@property (nonatomic,strong) QWeatherBaseLabel *sunriseLabel;
@property (nonatomic,strong) QWeatherBaseLabel *sunsetLabel;
@property (nonatomic,strong) QWeatherBaseLabel *monthlyTitleLabel;
@property (nonatomic,strong) QWeatherBaseLabel *moonfallTitleLabel;
@property (nonatomic,strong) QWeatherBaseLabel *sunriseTitleLabel;
@property (nonatomic,strong) QWeatherBaseLabel *sunsetTitleLabel;
@property (nonatomic,strong) QWeatherTodayWeatherMoonRiseCurveView *sunCurveView;
@property (nonatomic,strong) QWeatherTodayWeatherMoonRiseCurveView *moonCurveView;
@end

NS_ASSUME_NONNULL_END
