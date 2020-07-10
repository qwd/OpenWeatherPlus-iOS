//
//  HeFengWeatherRequest.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#import "HeFengWeatherRequest.h"

@implementation HeFengWeatherRequest
-(instancetype)init{
    if (self=[super init]) {
        
        [self getCommands];
    }
    return self;
}

-(void)getCommands{
    _citySearchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            HeConfigInstance.location = [input objectForKey:@"location"];
            HeConfigInstance.mode= SERCHMODE_TYPE_EXACT;
            HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_GEO_CITY_LOOKUP WithSuccess:^(GeoBaseClass  *responseObject) {
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
            HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            HeConfigInstance.location = [input objectForKey:@"cityId"];
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_NOW WithSuccess:^(WeatherBaseClass  *responseObject) {
                now = responseObject.now;
                updateTime = responseObject.updateTime;
                code = responseObject.code;
                dispatch_group_leave(group);
            } faileureForError:^(NSError *error) {
                error = error;
                dispatch_group_leave(group);
            }];
            dispatch_group_enter(group);
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_24H WithSuccess:^(WeatherBaseClass  *responseObject) {
                hourly = responseObject.hourly;
                           dispatch_group_leave(group);
                       } faileureForError:^(NSError *error) {
                           error = error;
                           dispatch_group_leave(group);
                       }];
            dispatch_group_enter(group);
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_3D WithSuccess:^(WeatherBaseClass  *responseObject) {
                daily = responseObject.daily;
                           dispatch_group_leave(group);
                       } faileureForError:^(NSError *error) {
                           error = error;
                           dispatch_group_leave(group);
                       }];
            
            if (HeFengStrValid([input objectForKey:@"parent_city"])) {
                dispatch_group_enter(group);
                HeConfigInstance.location = [input objectForKey:@"parent_city"];
                HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
                [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_AIR_NOW WithSuccess:^(AirBaseClass  *responseObject) {
                    AirBaseDataModel = responseObject;
                    dispatch_group_leave(group);
                } faileureForError:^(NSError *error) {
                    error = error;
                    dispatch_group_leave(group);
                }];
            }
            dispatch_group_enter(group);
            HeConfigInstance.location = [input objectForKey:@"location"];
            HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER_AIR_NOW WithSuccess:^(AirBaseClass  *responseObject) {
                locationAirBaseDataModel = responseObject;
                dispatch_group_leave(group);
            } faileureForError:^(NSError *error) {
                error = error;
                dispatch_group_leave(group);
            }];
            //预警
            dispatch_group_enter(group);
            HeConfigInstance.location = [input objectForKey:@"cityId"];
            HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_WARNING WithSuccess:^(WarningBaseClass  *responseObject) {
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
                  
                    HeFengHomeTabelViewDataModel *model = [HeFengHomeTabelViewDataModel new];
                    if (HeFengStrValid(locationAirBaseDataModel.now.pm2p5)) {
                        model.airDataModel = locationAirBaseDataModel;
                    }else if (HeFengStrValid(AirBaseDataModel.now.pm2p5)){
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
            [HeFengWeatherManager.collectionDataArray enumerateObjectsUsingBlock:^(HeFengHomeTabelViewDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_group_enter(group);
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                param[@"cityId"] = obj.basic.cid;
                param[@"location"] = obj.basic.name;
                param[@"parent_city"] = obj.basic.adm2?obj.basic.adm2:@"";
                [[[HeFengWeatherRequest new].homeDataCommand execute:param] subscribeNext:^(HeFengHomeTabelViewDataModel * x) {
                    if (HeFengStrEqual(x.code, @"200")) {
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
                    [HeFengWeatherManager.collectionDataArray enumerateObjectsUsingBlock:^(HeFengHomeTabelViewDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [array addObject:[dic objectForKey:@(idx)]];
                    }];
                    [HeFengWeatherManager updateCollectionDataArrayWithArray:array];
                    [subscriber sendNext:array];
                    [subscriber sendCompleted];
                }
            });
            return nil;
        }];
    }];
    
    
}
@end
