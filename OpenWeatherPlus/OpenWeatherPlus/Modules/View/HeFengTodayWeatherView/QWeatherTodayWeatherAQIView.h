//
//  QWeatherTodayWeatherAQIView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherTodayWeatherAQIView : QWeatherBaseView
@property (nonatomic,strong) QWeatherBaseLabel *titleLabel;
@property (nonatomic,strong) QWeatherBaseLabel *aqiLabel;
@property (nonatomic,strong) UIView *aqiBackView;
@property (nonatomic,strong) NSMutableArray<QWeatherBaseLabel*> *itemViewArray;
@property (nonatomic,strong) UIView *line;
@end

NS_ASSUME_NONNULL_END
