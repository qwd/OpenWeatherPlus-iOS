//
//Created by HEWEATHER on 18/07/28.
//天气灾害预警

#import "HeWeatherBaseModel.h"

@class Warning,Refer;
@interface WarningBaseClass : HeWeatherBaseModel
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * fxLink;
@property (nonatomic, strong) NSArray<Warning *> *warning;
@property (nonatomic , strong) Refer *refer;

@end
@interface Warning : HeWeatherBaseModel
@property (nonatomic, copy) NSString *warningId;
@property (nonatomic, copy) NSString *pubTime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *txt;
@end
