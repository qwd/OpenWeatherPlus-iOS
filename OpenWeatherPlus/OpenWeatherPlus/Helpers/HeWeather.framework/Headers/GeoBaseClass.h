//
//Created by HEWEATHER on 18/07/28.
//城市查询

#import "HeWeatherBaseModel.h"

@class Refer,Location;
@interface GeoBaseClass : HeWeatherBaseModel
@property (nonatomic, strong) NSArray<Location *> *location;
@property (nonatomic, copy) NSString *code;
@property (nonatomic , strong) Refer *refer;
@end

@interface Location :HeWeatherBaseModel
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * cid;
@property (nonatomic , copy) NSString              * lat;
@property (nonatomic , copy) NSString              * lon;
@property (nonatomic , copy) NSString              * adm2;
@property (nonatomic , copy) NSString              * adm1;
@property (nonatomic , copy) NSString              * country;
@property (nonatomic , copy) NSString              * tz;
@property (nonatomic , copy) NSString              * utcOffset;
@property (nonatomic , copy) NSString              * isDst;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * rank;
@property (nonatomic , copy) NSString              * fxLink;

@end
