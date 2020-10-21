//
//  QWeatherRequest.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#import "QWeatherRequest.h"

@implementation QWeatherRequest
-(instancetype)init{
    if (self=[super init]) {
        
        [self getCommands];
    }
    return self;
}

-(void)getCommands{
    _citySearchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            QWeatherConfigInstance.location = [input objectForKey:@"location"];
            QWeatherConfigInstance.mode= SERCHMODE_TYPE_EXACT;
            QWeatherConfigInstance.languageType= [QWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            [QWeatherConfigInstance weatherWithInquireType:INQUIRE_TYPE_GEO_CITY_LOOKUP WithSuccess:^(GeoBaseClass  *responseObject) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } faileureForError:^(NSError *error) {
                [subscriber sendError:error];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    
    _homeDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            __block AirBaseClass *AirBaseDataModel;
            __block AirBaseClass *locationAirBaseDataModel;
            __block WarningBaseClass *alarmBaseClass;
            __block Now *now;
            __block NSArray *hourly;
            __block NSArray *daily;
            __block NSString *updateTime;
            __block NSString *code;

            __block NSError *error;
            QWeatherConfigInstance.languageType= [QWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            QWeatherConfigInstance.location = [input objectForKey:@"cityId"];
            [QWeatherConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_NOW WithSuccess:^(WeatherBaseClass  *responseObject) {
                now = responseObject.now;
                updateTime = responseObject.updateTime;
                code = responseObject.code;
                dispatch_group_leave(group);
            } faileureForError:^(NSError *error) {
                error = error;
                dispatch_group_leave(group);
            }];
            dispatch_group_enter(group);
            [QWeatherConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_24H WithSuccess:^(WeatherBaseClass  *responseObject) {
                hourly = responseObject.hourly;
                           dispatch_group_leave(group);
                       } faileureForError:^(NSError *error) {
                           error = error;
                           dispatch_group_leave(group);
                       }];
            dispatch_group_enter(group);
            [QWeatherConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_3D WithSuccess:^(WeatherBaseClass  *responseObject) {
                daily = responseObject.daily;
                           dispatch_group_leave(group);
                       } faileureForError:^(NSError *error) {
                           error = error;
                           dispatch_group_leave(group);
                       }];
            
            if (QWeatherStrValid([input objectForKey:@"parent_city"])) {
                dispatch_group_enter(group);
                QWeatherConfigInstance.location = [input objectForKey:@"parent_city"];
                QWeatherConfigInstance.languageType= [QWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
                [QWeatherConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_AIR_NOW WithSuccess:^(AirBaseClass  *responseObject) {
                    AirBaseDataModel = responseObject;
                    dispatch_group_leave(group);
                } faileureForError:^(NSError *error) {
                    error = error;
                    dispatch_group_leave(group);
                }];
            }
            dispatch_group_enter(group);
            QWeatherConfigInstance.location = [input objectForKey:@"location"];
            QWeatherConfigInstance.languageType= [QWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            [QWeatherConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_AIR_NOW WithSuccess:^(AirBaseClass  *responseObject) {
                locationAirBaseDataModel = responseObject;
                dispatch_group_leave(group);
            } faileureForError:^(NSError *error) {
                error = error;
                dispatch_group_leave(group);
            }];
            //预警
            dispatch_group_enter(group);
            QWeatherConfigInstance.location = [input objectForKey:@"cityId"];
            QWeatherConfigInstance.languageType= [QWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            [QWeatherConfigInstance weatherWithInquireType:INQUIRE_TYPE_WARNING WithSuccess:^(WarningBaseClass  *responseObject) {
                alarmBaseClass = responseObject;
                dispatch_group_leave(group);
            } faileureForError:^(NSError *error) {
                dispatch_group_leave(group);
            }];
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                if (error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }else{
                  
                    QWeatherHomeTabelViewDataModel *model = [QWeatherHomeTabelViewDataModel new];
                    if (QWeatherStrValid(locationAirBaseDataModel.now.pm2p5)) {
                        model.airDataModel = locationAirBaseDataModel;
                    }else if (QWeatherStrValid(AirBaseDataModel.now.pm2p5)){
                        model.airDataModel = AirBaseDataModel;
                    }
                    model.daily = daily;
                    model.hourly = hourly;
                    model.now = now;
                    model.updateTime = updateTime;
                    model.AlarmDataModel = alarmBaseClass;
                    model.code = code;
                    [subscriber sendNext:model];
                    [subscriber sendCompleted];
                }
            });
            return nil;
        }];
    }];
    _upDateHomeDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            dispatch_group_t group = dispatch_group_create();
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            __block NSError *hefengError;
            [QWeatherManager.collectionDataArray enumerateObjectsUsingBlock:^(QWeatherHomeTabelViewDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_group_enter(group);
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                param[@"cityId"] = obj.basic.cid;
                param[@"location"] = obj.basic.name;
                param[@"parent_city"] = obj.basic.adm2?obj.basic.adm2:@"";
                [[[QWeatherRequest new].homeDataCommand execute:param] subscribeNext:^(QWeatherHomeTabelViewDataModel * x) {
                    if (QWeatherStrEqual(x.code, @"200")) {
                        [dic setObject:x forKey:@(idx)];
                    }else{
                        hefengError = [NSError errorWithDomain:NSURLErrorDomain code:121 userInfo:@{NSLocalizedDescriptionKey:@"x.dataModel.status"}];
                    }
                    dispatch_group_leave(group);
                } error:^(NSError * _Nullable error) {
                    hefengError = error;
                    dispatch_group_leave(group);
                }];
            }];
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                if (hefengError) {
                    [subscriber sendError:hefengError];
                    [subscriber sendCompleted];
                }else{
                    NSMutableArray *array = [NSMutableArray array];
                    [QWeatherManager.collectionDataArray enumerateObjectsUsingBlock:^(QWeatherHomeTabelViewDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [array addObject:[dic objectForKey:@(idx)]];
                    }];
                    [QWeatherManager updateCollectionDataArrayWithArray:array];
                    [subscriber sendNext:array];
                    [subscriber sendCompleted];
                }
            });
            return nil;
        }];
    }];
    
    
}
@end
