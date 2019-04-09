//
//  HeFengTodayWeatherMoonRiseView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"
#import "HeFengTodayWeatherMoonRiseCurveView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengTodayWeatherMoonRiseView : HeFengBaseView

@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) HeFengBaseLabel *monthlyLabel;
@property (nonatomic,strong) HeFengBaseLabel *moonfallLabel;
@property (nonatomic,strong) HeFengBaseLabel *sunriseLabel;
@property (nonatomic,strong) HeFengBaseLabel *sunsetLabel;
@property (nonatomic,strong) HeFengBaseLabel *monthlyTitleLabel;
@property (nonatomic,strong) HeFengBaseLabel *moonfallTitleLabel;
@property (nonatomic,strong) HeFengBaseLabel *sunriseTitleLabel;
@property (nonatomic,strong) HeFengBaseLabel *sunsetTitleLabel;
@property (nonatomic,strong) HeFengTodayWeatherMoonRiseCurveView *sunCurveView;
@property (nonatomic,strong) HeFengTodayWeatherMoonRiseCurveView *moonCurveView;
@end

NS_ASSUME_NONNULL_END
