//
//  HeFengWeatherDataManager.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#define HeFengWeatherDataCacheKey @"HeFengWeatherDataCacheKey"
#define HeFengWeatherDataCache [YYCache cacheWithName:HeFengWeatherDataCacheKey]

#import "HeFengWeatherDataManager.h"

static NSString * kcollectionDataArray = @"kcollectionDataArray";
static NSString * ksettingModel = @"ksettingModel";
static NSString * const kCH          = @"zh-Hans";
static NSString * const kCHCN         = @"zh-Hans-CN";
static NSString * const kEN          = @"en";
static NSString * const kProj        = @"lproj";

@implementation HeFengWeatherDataManager
SINGLETON_FOR_CLASS(HeFengWeatherDataManager);
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setManager];
    }
    return self;
}
-(void)setManager{
    if ([HeFengWeatherDataCache objectForKey:kcollectionDataArray]) {
        self.collectionDataArray = [NSMutableArray arrayWithArray:(NSArray *)[HeFengWeatherDataCache objectForKey:kcollectionDataArray]];
    }else{
        self.collectionDataArray = [NSMutableArray array];
        [HeFengWeatherDataCache setObject:self.collectionDataArray forKey:kcollectionDataArray];
    }
    if ([HeFengWeatherDataCache objectForKey:ksettingModel]) {
        self.settingModel = (HeFengSettingModel *)[HeFengWeatherDataCache objectForKey:ksettingModel];
    }else{
        HeFengSettingModel *model = [HeFengSettingModel new];
        model.fontType = 1;
        model.languageType = 0;
        model.unitType = 1;
        model.isFirstOpenApp = YES;
        self.settingModel = model;
        [HeFengWeatherDataCache setObject:model forKey:ksettingModel];
    }
    [self resetBundle];
    
}
-(BOOL)isFirstOpenApp{
    return self.settingModel.isFirstOpenApp;
}
-(void)setIsFirstOpenApp:(BOOL)isFirstOpenApp{
    self.settingModel.isFirstOpenApp = isFirstOpenApp;
    [HeFengWeatherDataCache setObject:self.settingModel forKey:ksettingModel];
}
-(void)addCollectionDataArrayWithModel:(HeFengHomeTabelViewDataModel *)model isLoaction:(BOOL)isLoaction{
    if (isLoaction) {
        if (self.collectionDataArray.firstObject) {
            [self.collectionDataArray replaceObjectAtIndex:0 withObject:model];
        }else{
            [self.collectionDataArray addObject:model];
        }
    }else{
        __block BOOL isEqual = NO;
        [self.collectionDataArray enumerateObjectsUsingBlock:^(HeFengHomeTabelViewDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (HeFengStrEqual(obj.basic.cid, model.basic.cid)&&idx!=0) {
                [self.collectionDataArray removeObjectAtIndex:idx];
                isEqual = YES;
            }
        }];
        if (self.collectionDataArray.count==10&&isEqual==NO) {
            [self.collectionDataArray removeLastObject];
        }
        if (self.collectionDataArray.count==0) {
            [self.collectionDataArray addObject:model];
        }else{
            [self.collectionDataArray insertObject:model atIndex:1];
        }
    }
    [HeFengWeatherDataCache setObject:self.collectionDataArray forKey:kcollectionDataArray];
}

-(void)delCollectionDataArrayWithIndex:(NSInteger)index{
    [self.collectionDataArray removeObjectAtIndex:index];
    [HeFengWeatherDataCache setObject:self.collectionDataArray forKey:kcollectionDataArray];
}
-(void)updateCollectionDataArrayWithArray:(NSArray *)array{
    self.collectionDataArray = [NSMutableArray arrayWithArray:array];
    [HeFengWeatherDataCache setObject:array forKey:kcollectionDataArray];
}
-(void)updateSettingWithIndex:(NSInteger)index{
    switch (index) {
        case 1:
            self.settingModel.languageType = 0;
            break;
        case 2:
            self.settingModel.languageType = 1;
            break;
        case 3:
            self.settingModel.languageType = 2;
            break;
        case 4:
            self.settingModel.unitType = 0;
            break;
        case 5:
            self.settingModel.unitType = 1;
            break;
        case 6:
            self.settingModel.fontType = 0;
            break;
        case 7:
            self.settingModel.fontType = 1;
            break;
        case 8:
            self.settingModel.fontType = 2;
            break;
        default:
            break;
    }
    
    [HeFengWeatherDataCache setObject:self.settingModel forKey:ksettingModel];
    if (index==1||index==2||index==3) {
        [self resetBundle];
        HeFengPostNotification(KNotificationRefreshHomeData, nil);
    }
    HeFengPostNotification(KNotificationChangeTextSetting, nil);
}
- (void)resetBundle{
    if (self.settingModel.languageType==0) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if (HeFengStrEqual(currentLanguage, kCHCN)||HeFengStrEqual(currentLanguage, kCH)) {
            NSString *path = [[NSBundle mainBundle] pathForResource:kCH ofType:kProj];
            self.bundle = [NSBundle bundleWithPath:path];
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:kEN ofType:kProj];
            self.bundle = [NSBundle bundleWithPath:path];
        }
    }else if (self.settingModel.languageType==1) {
        NSString *path = [[NSBundle mainBundle] pathForResource:kCH ofType:kProj];
        self.bundle = [NSBundle bundleWithPath:path];
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:kEN ofType:kProj];
        self.bundle = [NSBundle bundleWithPath:path];
    }
}
- (NSString *)stringWithKey:(NSString *)key table:(NSString *)table
{
    if (_bundle) {
        return  NSLocalizedStringFromTableInBundle(key, table, _bundle, nil);
    }
    return NSLocalizedStringFromTable(key, table, nil);
}

-(BOOL)isEnglish{
    if (self.settingModel.languageType==1) {
        return NO;
    }else if (self.settingModel.languageType==0){
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if (HeFengStrEqual(currentLanguage, kCHCN)||HeFengStrEqual(currentLanguage, kCH)) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

@end
