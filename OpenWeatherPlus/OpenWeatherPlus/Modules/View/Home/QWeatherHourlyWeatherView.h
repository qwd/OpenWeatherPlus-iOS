//
//  QWeatherHourlyWeatherView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"
#import "QWeatherHourlyLineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherHourlyWeatherView : QWeatherBaseView
@property (nonatomic,strong) QWeatherBaseLabel *titleLabel;
@property (nonatomic,strong) QWeatherBaseLabel *maxTempLabel;
@property (nonatomic,strong) QWeatherBaseLabel *minTempLabel;
@property (nonatomic,strong) QWeatherHourlyLineView *weatherLineView;
@end

NS_ASSUME_NONNULL_END
