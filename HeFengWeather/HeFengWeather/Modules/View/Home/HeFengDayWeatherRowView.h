//
//  HeFengDayWeatherRowView.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengDayWeatherRowView : HeFengBaseView
@property (nonatomic,strong) HeFengBaseLabel *dayLabel;
@property (nonatomic,strong) UIImageView *dayWeatherImageView;
@property (nonatomic,strong) UIImageView *nightWeatherImageView;
@property (nonatomic,strong) HeFengBaseLabel *maxTempLabel;
@property (nonatomic,strong) HeFengBaseLabel *minTempLabel;
@end

NS_ASSUME_NONNULL_END
