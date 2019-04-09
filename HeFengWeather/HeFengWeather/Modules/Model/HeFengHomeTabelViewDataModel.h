//
//  HeFengHomeTabelViewDataModel.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#import "HeFengBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class AirBaseClass;
@class WeatherBaseClass;

@interface HeFengHomeTabelViewDataModel : HeFengBaseModel
/**
 数据模型
 */
@property (nonatomic,strong) WeatherBaseClass *dataModel;
/**
 数据模型
 */
@property (nonatomic,strong) AirBaseClass *airDataModel;

@end

NS_ASSUME_NONNULL_END
