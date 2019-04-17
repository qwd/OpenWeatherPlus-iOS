//
//  HeFengNowWeatherView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"
#import "HeFengWaterWaveView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengNowWeatherView : HeFengBaseView
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) HeFengWaterWaveView *waterWaveView;
@property (strong, nonatomic) HeFengBaseLabel *tempLabel;
@property (strong, nonatomic) HeFengBaseLabel *weatherStateLabel;
@property (strong, nonatomic) HeFengBaseLabel *alarmLabel;

@end

NS_ASSUME_NONNULL_END
