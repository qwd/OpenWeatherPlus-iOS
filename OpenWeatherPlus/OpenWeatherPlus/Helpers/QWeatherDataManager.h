//
//  QWeatherDataManager.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#define QWeatherManager [QWeatherDataManager sharedQWeatherDataManager]


#define QWeatherLocal(x, ...) \
QWeatherLocalizedString(x, nil)
#define QWeatherLocalizedString(key, comment)               QWeatherLocalizedStringFromTable(key, @"Localizable", nil)
#define QWeatherLocalizedStringFromTable(key, tbl, comment) [QWeatherManager stringWithKey:key table:tbl]


#import <Foundation/Foundation.h>
#import "QWeatherSettingModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface QWeatherDataManager : NSObject
SINGLETON_FOR_HEADER(QWeatherDataManager)
@property (nonatomic,strong) NSBundle *bundle;
@property (nonatomic,strong) QWeatherSettingModel *settingModel;
@property (nonatomic,strong) NSMutableArray<QWeatherHomeTabelViewDataModel*> *collectionDataArray;
@property (nonatomic,assign) BOOL isFirstOpenApp;
@property (nonatomic,copy) NSString *selectLocation;



/**
 添加城市数据

 @param model 数据模型
 @param isLoaction 是否是定位城市

 */
-(void)addCollectionDataArrayWithModel:(QWeatherHomeTabelViewDataModel *)model isLoaction:(BOOL)isLoaction;

/**
 删除城市数据
 
 @param index 索引
 */
-(void)delCollectionDataArrayWithIndex:(NSInteger)index;

/**
 更新城市数据

 @param array 城市数据数组
 */
-(void)updateCollectionDataArrayWithArray:(NSArray *)array;
/**
 修改设置

 @param index 修改索引
 */
-(void)updateSettingWithIndex:(NSInteger)index;
/**
 当前语言是否是英文
 
 @return YES->当前城市
 */
-(BOOL)isEnglish;

/**
 获取多语言对应字符串
 */
- (NSString *)stringWithKey:(NSString *)key table:(NSString *)table;


@end

NS_ASSUME_NONNULL_END
