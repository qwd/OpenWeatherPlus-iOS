//
//  QWeatherNowWeatherView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"
#import "QWeatherWaterWaveView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherNowWeatherView : QWeatherBaseView
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) QWeatherWaterWaveView *waterWaveView;
@property (strong, nonatomic) QWeatherBaseLabel *tempLabel;
@property (strong, nonatomic) QWeatherBaseLabel *weatherStateLabel;
@property (strong, nonatomic) QWeatherBaseLabel *alarmLabel;

@end

NS_ASSUME_NONNULL_END
