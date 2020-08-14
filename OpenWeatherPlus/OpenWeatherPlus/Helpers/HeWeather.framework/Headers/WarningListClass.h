//
//  warningLocListClass.h
//  HeWeather
//
//  Created by he on 2020/4/26.
//  Copyright © 2020 Song. All rights reserved.
//

#import "HeWeatherBaseModel.h"
@class WarningLoc;

@interface WarningListClass : HeWeatherBaseModel
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, strong) NSArray<WarningLoc *> *warningLocList;
@end

@interface WarningLoc : HeWeatherBaseModel
@property (nonatomic,copy) NSString *locationId;
@end

