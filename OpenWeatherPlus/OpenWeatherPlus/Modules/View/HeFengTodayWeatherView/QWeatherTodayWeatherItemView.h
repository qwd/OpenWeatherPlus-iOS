//
//  QWeatherTodayWeatherItemView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherTodayWeatherItemView : QWeatherBaseView
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) QWeatherBaseLabel *titleLabel;
@property (nonatomic,strong) QWeatherBaseLabel *contentLabel;
@property (nonatomic,assign) NSInteger idx;
@end

NS_ASSUME_NONNULL_END
