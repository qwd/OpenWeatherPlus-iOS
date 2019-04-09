//
//  HeFengWeatherDataManager.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#define HeFengWeatherManager [HeFengWeatherDataManager sharedHeFengWeatherDataManager]


#define HeFengLocal(x, ...) \
HeFengLocalizedString(x, nil)
#define HeFengLocalizedString(key, comment)               HeFengLocalizedStringFromTable(key, @"Localizable", nil)
#define HeFengLocalizedStringFromTable(key, tbl, comment) [HeFengWeatherManager stringWithKey:key table:tbl]


#import <Foundation/Foundation.h>
#import "HeFengSettingModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface HeFengWeatherDataManager : NSObject
SINGLETON_FOR_HEADER(HeFengWeatherDataManager)
@property (nonatomic,strong) NSBundle *bundle;
@property (nonatomic,strong) HeFengSettingModel *settingModel;
@property (nonatomic,strong) NSMutableArray<HeFengHomeTabelViewDataModel*> *collectionDataArray;
@property (nonatomic,assign) BOOL isFirstOpenApp;
@property (nonatomic,copy) NSString *selectLocation;



/**
 添加城市数据

 @param model 数据模型
 @param isLoaction 是否是定位城市

 */
-(void)addCollectionDataArrayWithModel:(HeFengHomeTabelViewDataModel *)model isLoaction:(BOOL)isLoaction;

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
