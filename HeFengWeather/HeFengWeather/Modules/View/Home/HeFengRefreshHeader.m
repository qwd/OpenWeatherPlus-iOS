//
//  HeFengRefreshHeader.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengRefreshHeader.h"
#import <ImageIO/ImageIO.h>

@implementation HeFengRefreshHeader
#pragma mark - 重写父类的方法
//- (void)prepare{
//    [super prepare];
//
//    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
//
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//
//    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
//    self.lastUpdatedTimeLabel.textColor = HeFengColor_FFFFFF;
//    self.stateLabel.textColor = HeFengColor_FFFFFF;
//    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = YES;
//}
- (void)prepare{
    [super prepare];
    
    NSMutableArray *idleImages = [NSMutableArray array];
    [[self imagesWithGif:@"hefeng_refresh"] enumerateObjectsUsingBlock:^(UIImage  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [idleImages addObject:[[UIImage qmui_imageWithColor:[UIColor whiteColor] size:CGSizeMake(48, 48) cornerRadius:25] qmui_imageWithImageAbove:[obj qmui_imageResizedInLimitedSize:CGSizeMake(32, 32) resizingMode:QMUIImageResizingModeScaleAspectFit scale:ScreenScale] atPoint:CGPointMake(8, 8)]];
    }];
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    [self setImages:idleImages duration:1.5 forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}
- (NSArray *)imagesWithGif:(NSString *)gifNameInBoundle {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifNameInBoundle withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (size_t i = 0; i< gifCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [images addObject:image];
        CGImageRelease(imageRef);
    }
    return images;
}


@end
