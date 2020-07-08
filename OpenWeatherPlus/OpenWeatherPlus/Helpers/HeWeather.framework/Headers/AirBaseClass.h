//
//Created by HEWEATHER on 18/07/27.
//空气质量数据集合
#import "HeWeatherBaseModel.h"

@class AirDaily,AirHourly,AirNow,AirStation,Refer;
@interface AirBaseClass : HeWeatherBaseModel
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * fxLink;
@property (nonatomic , strong) NSArray<AirDaily *>              * daily;
@property (nonatomic , strong) NSArray<AirHourly *>              * hourly;
@property (nonatomic , strong) AirNow              * now;
@property (nonatomic , strong) NSArray<AirStation *>              * airStation;
@property (nonatomic , strong) Refer *refer;
@end
@interface AirDaily :HeWeatherBaseModel
@property (nonatomic , copy) NSString              * fxDate;
@property (nonatomic , copy) NSString              * aqi;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * primary;

@end

@interface AirHourly :HeWeatherBaseModel
@property (nonatomic , copy) NSString              * fxTime;
@property (nonatomic , copy) NSString              * aqi;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * primary;
@end

@interface AirNow :HeWeatherBaseModel
@property (nonatomic , copy) NSString              * primary;
@property (nonatomic , copy) NSString              * pm2p5;
@property (nonatomic , copy) NSString              * aqi;
@property (nonatomic , copy) NSString              * no2;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * pm10;
@property (nonatomic , copy) NSString              * so2;
@property (nonatomic , copy) NSString              * pubTime;
@property (nonatomic , copy) NSString              * co;
@property (nonatomic , copy) NSString              * o3;

@end

@interface AirStation :HeWeatherBaseModel
@property (nonatomic , copy) NSString              * no2;
@property (nonatomic , copy) NSString              * co;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * aqi;
@property (nonatomic , copy) NSString              * so2;
@property (nonatomic , copy) NSString              * pubTime;
@property (nonatomic , copy) NSString              * pm2p5;
@property (nonatomic , copy) NSString              * level;
@property (nonatomic , copy) NSString              * category;
@property (nonatomic , copy) NSString              * cid;
@property (nonatomic , copy) NSString              * o3;
@property (nonatomic , copy) NSString              * primary;
@property (nonatomic , copy) NSString              * pm10;

@end
