//
//  HeFengHomeTabelViewDataModel.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#import "HeFengBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class AirBaseClass;
@class Location;
@class Now;
@class Hourly;
@class Daily;

@interface HeFengHomeTabelViewDataModel : HeFengBaseModel
/**
 实况天气
 */
@property (nonatomic,strong) Now *now;
/**
逐小时天气
*/
@property (nonatomic,strong) NSArray< Hourly *> *hourly;
/**
逐天天气
*/
@property (nonatomic,strong) NSArray< Daily*> *daily;

/**
 空气数据模型
 */
@property (nonatomic,strong) AirBaseClass *airDataModel;
/**
 预警数据模型
 */
@property (nonatomic,strong) WarningBaseClass *AlarmDataModel;
/**
 Location数据模型
*/
@property (nonatomic,strong) Location *basic;

@property (nonatomic,copy) NSString *updateTime;

@property (nonatomic,copy) NSString *code;

@end

NS_ASSUME_NONNULL_END
