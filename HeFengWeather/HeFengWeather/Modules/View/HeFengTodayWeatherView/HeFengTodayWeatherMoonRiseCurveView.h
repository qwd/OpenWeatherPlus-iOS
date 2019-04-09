//
//  HeFengTodayWeatherMoonRiseCurveView.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengTodayWeatherMoonRiseCurveView : HeFengBaseView
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) CGFloat progress;//0~1;
-(void)setStartTime:(NSString *)startTime endTime:(NSString *)endTime tz:(NSString *)tz;
@end

NS_ASSUME_NONNULL_END
