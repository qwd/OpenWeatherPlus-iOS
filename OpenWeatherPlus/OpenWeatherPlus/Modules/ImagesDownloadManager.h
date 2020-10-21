//
//  ImagesDownloadManager.h
//  OpenWeatherPlus
//
//  Created by he on 2019/10/30.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagesDownloadManager : NSObject

/*
 *  批量下载图片资源
 *  imageURLs 图片地址数组 成员为String类型
 */
+ (void)downloadImagesWithURLs:(NSArray <NSString *> *)imageURLs;

/*
 *  根据图片地址获取图片
 *  imageURL 单个图片地址
 */
+ (UIImage *)imageForURL:(NSString *)imageURL;
@end

NS_ASSUME_NONNULL_END
