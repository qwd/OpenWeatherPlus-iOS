//
//  HeFengHourlyWeatherView.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"
#import "HeFengHourlyLineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengHourlyWeatherView : HeFengBaseView
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) HeFengBaseLabel *maxTempLabel;
@property (nonatomic,strong) HeFengBaseLabel *minTempLabel;
@property (nonatomic,strong) HeFengHourlyLineView *weatherLineView;
@end

NS_ASSUME_NONNULL_END
