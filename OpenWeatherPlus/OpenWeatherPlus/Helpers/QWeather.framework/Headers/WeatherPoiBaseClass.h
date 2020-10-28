//
//Created by QWeather on 18/07/28.
//景点天气预报

#import "QWeatherBaseModel.h"
@class ScenicDaily,ScenicNow,Refer;
@interface WeatherPoiBaseClass : QWeatherBaseModel
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * fxLink;
@property (nonatomic , strong) NSArray<ScenicDaily *>              * daily;
@property (nonatomic , strong) ScenicNow              * now;
@property (nonatomic , strong) Refer *refer;

@end
@interface ScenicDaily :QWeatherBaseModel
@property (nonatomic , copy) NSString              * fxDate;
@property (nonatomic , copy) NSString              * tempMax;
@property (nonatomic , copy) NSString              * tempMin;
@property (nonatomic , copy) NSString              * iconDay;
@property (nonatomic , copy) NSString              * textDay;
@property (nonatomic , copy) NSString              * iconNight;
@property (nonatomic , copy) NSString              * textNight;
@property (nonatomic , copy) NSString              * windDirDay;
@property (nonatomic , copy) NSString              * windScaleDay;
@property (nonatomic , copy) NSString              * windDirNight;
@property (nonatomic , copy) NSString              * windScaleNight;
@end

@interface ScenicNow :QWeatherBaseModel
@property (nonatomic , copy) NSString              * obsTime;
@property (nonatomic , copy) NSString              * temp;
@property (nonatomic , copy) NSString              * feelsLike;
@property (nonatomic , copy) NSString              * icon;
@property (nonatomic , copy) NSString              * text;
@property (nonatomic , copy) NSString              * windDir;
@property (nonatomic , copy) NSString              * windScale;
@property (nonatomic , copy) NSString              * humidity;
@property (nonatomic , copy) NSString              * precip;
@property (nonatomic , copy) NSString              * pressure;
@end


