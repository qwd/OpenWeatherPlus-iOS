//
//  SunMoonBaseModel.h
//  QWeather
//
//  Created by he on 2020/6/8.
//  Copyright © 2020 Song. All rights reserved.
//

#import "QWeatherBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class  MoonPhase,Refer;
@interface SunMoonBaseModel : QWeatherBaseModel
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * fxLink;
@property (nonatomic , copy) NSString              * sunrise;
@property (nonatomic , copy) NSString              * sunset;
@property (nonatomic , copy) NSString              * moonrise;
@property (nonatomic , copy) NSString              * moonset;
@property (nonatomic,strong) NSArray<MoonPhase *> *moonPhases;
@property (nonatomic , strong) Refer *refer;
@end
@interface MoonPhase : QWeatherBaseModel
@property (nonatomic,copy) NSString *fxTime;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *illumination;
@end
NS_ASSUME_NONNULL_END
