//
//  HeFengTodayWeatherAQIView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengTodayWeatherAQIView : HeFengBaseView
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) HeFengBaseLabel *aqiLabel;
@property (nonatomic,strong) UIView *aqiBackView;
@property (nonatomic,strong) NSMutableArray<HeFengBaseLabel*> *itemViewArray;
@property (nonatomic,strong) UIView *line;
@end

NS_ASSUME_NONNULL_END
