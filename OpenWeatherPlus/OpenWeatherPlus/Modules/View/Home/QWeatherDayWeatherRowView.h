//
//  QWeatherDayWeatherRowView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherDayWeatherRowView : QWeatherBaseView
@property (nonatomic,strong) QWeatherBaseLabel *dayLabel;
@property (nonatomic,strong) UIImageView *dayWeatherImageView;
@property (nonatomic,strong) UIImageView *nightWeatherImageView;
@property (nonatomic,strong) QWeatherBaseLabel *maxTempLabel;
@property (nonatomic,strong) QWeatherBaseLabel *minTempLabel;
@end

NS_ASSUME_NONNULL_END
