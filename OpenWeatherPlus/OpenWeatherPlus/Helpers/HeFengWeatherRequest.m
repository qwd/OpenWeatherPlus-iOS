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
            HeConfigInstance.mode= @"match";
            HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_SEARCH WithSuccess:^(SearchBaseClass  *responseObject) {
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
            __block WeatherBaseClass *WeatherBaseDataModel;
            __block NSError *error;
            HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
            dispatch_group_t group = dispatch_group_create();
            dispatch_group_enter(group);
            HeConfigInstance.location = [input objectForKey:@"cityId"];
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_WEATHER WithSuccess:^(WeatherBaseClass  *responseObject) {
                WeatherBaseDataModel = responseObject;
                dispatch_group_leave(group);
            } faileureForError:^(NSError *error) {
                error = error;
                dispatch_group_leave(group);
            }];
            
            if (HeFengStrValid([input objectForKey:@"parent_city"])) {
                dispatch_group_enter(group);
                HeConfigInstance.location = [input objectForKey:@"parent_city"];
                HeConfigInstance.languageType= [HeFengWeatherManager isEnglish]?LANGUAGE_TYPE_EN:LANGUAGE_TYPE_ZH;
                [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_AIR WithSuccess:^(AirBaseClass  *responseObject) {
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
            [HeConfigInstance weatherWithInquireType:INQUIRE_TYPE_AIR WithSuccess:^(AirBaseClass  *responseObject) {
                locationAirBaseDataModel = responseObject;
                dispatch_group_leave(group);
            } faileureForError:^(NSError *error) {
                error = error;
                dispatch_group_leave(group);
            }];
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                if (error) {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }else{
                  
                    
                    HeFengHomeTabelViewDataModel *model = [HeFengHomeTabelViewDataModel new];
                    if (HeFengStrValid(locationAirBaseDataModel.air_now_city.pm25)) {
                        model.airDataModel = locationAirBaseDataModel;
                    }else if (HeFengStrValid(AirBaseDataModel.air_now_city.pm25)){
                        model.airDataModel = AirBaseDataModel;
                    }
                    model.dataModel = WeatherBaseDataModel;
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
                param[@"cityId"] = obj.dataModel.basic.cid;
                param[@"location"] = obj.dataModel.basic.location;
                param[@"parent_city"] = obj.dataModel.basic.parent_city?obj.dataModel.basic.parent_city:@"";
                [[[HeFengWeatherRequest new].homeDataCommand execute:param] subscribeNext:^(HeFengHomeTabelViewDataModel * x) {
                    if (HeFengStrEqual(x.dataModel.status, @"ok")) {
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
