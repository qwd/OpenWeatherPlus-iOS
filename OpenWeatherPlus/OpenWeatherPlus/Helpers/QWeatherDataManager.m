//
//  QWeatherDataManager.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#define QWeatherWeatherDataCacheKey @"QWeatherWeatherDataCacheKey"
#define QWeatherWeatherDataCache [YYCache cacheWithName:QWeatherWeatherDataCacheKey]

#import "QWeatherDataManager.h"

static NSString * kcollectionDataArray = @"kcollectionDataArray";
static NSString * ksettingModel = @"ksettingModel";
static NSString * const kCH          = @"zh-Hans";
static NSString * const kCHCN         = @"zh-Hans-CN";
static NSString * const kEN          = @"en";
static NSString * const kProj        = @"lproj";

@implementation QWeatherDataManager
SINGLETON_FOR_CLASS(QWeatherDataManager);
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setManager];
    }
    return self;
}
-(void)setManager{
    if ([QWeatherWeatherDataCache objectForKey:kcollectionDataArray]) {
        self.collectionDataArray = [NSMutableArray arrayWithArray:(NSArray *)[QWeatherWeatherDataCache objectForKey:kcollectionDataArray]];
    }else{
        self.collectionDataArray = [NSMutableArray array];
        [QWeatherWeatherDataCache setObject:self.collectionDataArray forKey:kcollectionDataArray];
    }
    if ([QWeatherWeatherDataCache objectForKey:ksettingModel]) {
        self.settingModel = (QWeatherSettingModel *)[QWeatherWeatherDataCache objectForKey:ksettingModel];
    }else{
        QWeatherSettingModel *model = [QWeatherSettingModel new];
        model.fontType = 1;
        model.languageType = 0;
        model.unitType = 1;
        model.isFirstOpenApp = YES;
        self.settingModel = model;
        [QWeatherWeatherDataCache setObject:model forKey:ksettingModel];
    }
    [self resetBundle];
    
}
-(BOOL)isFirstOpenApp{
    return self.settingModel.isFirstOpenApp;
}
-(void)setIsFirstOpenApp:(BOOL)isFirstOpenApp{
    self.settingModel.isFirstOpenApp = isFirstOpenApp;
    [QWeatherWeatherDataCache setObject:self.settingModel forKey:ksettingModel];
}
-(void)addCollectionDataArrayWithModel:(QWeatherHomeTabelViewDataModel *)model isLoaction:(BOOL)isLoaction{
    if (isLoaction) {
        if (self.collectionDataArray.firstObject) {
            [self.collectionDataArray replaceObjectAtIndex:0 withObject:model];
        }else{
            [self.collectionDataArray addObject:model];
        }
    }else{
        __block BOOL isEqual = NO;
        [self.collectionDataArray enumerateObjectsUsingBlock:^(QWeatherHomeTabelViewDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (QWeatherStrEqual(obj.basic.cid, model.basic.cid)&&idx!=0) {
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
    [QWeatherWeatherDataCache setObject:self.collectionDataArray forKey:kcollectionDataArray];
}

-(void)delCollectionDataArrayWithIndex:(NSInteger)index{
    [self.collectionDataArray removeObjectAtIndex:index];
    [QWeatherWeatherDataCache setObject:self.collectionDataArray forKey:kcollectionDataArray];
}
-(void)updateCollectionDataArrayWithArray:(NSArray *)array{
    self.collectionDataArray = [NSMutableArray arrayWithArray:array];
    [QWeatherWeatherDataCache setObject:array forKey:kcollectionDataArray];
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
    
    [QWeatherWeatherDataCache setObject:self.settingModel forKey:ksettingModel];
    if (index==1||index==2||index==3) {
        [self resetBundle];
        QWeatherPostNotification(KNotificationRefreshHomeData, nil);
    }
    QWeatherPostNotification(KNotificationChangeTextSetting, nil);
}
- (void)resetBundle{
    if (self.settingModel.languageType==0) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if (QWeatherStrEqual(currentLanguage, kCHCN)||QWeatherStrEqual(currentLanguage, kCH)) {
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
        if (QWeatherStrEqual(currentLanguage, kCHCN)||QWeatherStrEqual(currentLanguage, kCH)) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

@end
