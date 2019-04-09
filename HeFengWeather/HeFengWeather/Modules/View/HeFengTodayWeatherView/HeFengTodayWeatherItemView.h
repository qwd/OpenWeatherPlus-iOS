//
//  HeFengTodayWeatherItemView.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengTodayWeatherItemView : HeFengBaseView
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) HeFengBaseLabel *contentLabel;
@property (nonatomic,assign) NSInteger idx;
@end

NS_ASSUME_NONNULL_END
