//
//  ImagesDownloadManager.m
//  OpenWeatherPlus
//
//  Created by he on 2019/10/30.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "ImagesDownloadManager.h"
#import "SDWebImagePrefetcher.h"
#import "SDImageCache.h"
@implementation ImagesDownloadManager


/*
 *  批量下载图片资源
 *  imageURLs 图片地址数组 成员为String类型
 */
+ (void)downloadImagesWithURLs:(NSArray <NSString *> *)imageURLs {
    NSMutableArray *prefetchURLs = [NSMutableArray new];
    
    for (NSString *urlStr in imageURLs) {
        NSURL *url = [NSURL URLWithString:urlStr];
        if (url) {
            [prefetchURLs addObject:url];
        }
    }
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:prefetchURLs progress:^(NSUInteger noOfFinishedUrls, NSUInteger noOfTotalUrls) {
        
    } completed:^(NSUInteger noOfFinishedUrls, NSUInteger noOfSkippedUrls) {
        [imageURLs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ImagesDownloadManager imageForURL:obj];
        }];
        NSLog(@"安装成功");
    }];
}

//必要实现的协议方法, 不然会崩溃
+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
   
}
/*
 *  根据图片地址获取图片
 *  imageURL 单个图片地址
 */
+ (UIImage *)imageForURL:(NSString *)imageURL {
    NSURL *url = [NSURL URLWithString:imageURL];
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    return image;
}
@end
