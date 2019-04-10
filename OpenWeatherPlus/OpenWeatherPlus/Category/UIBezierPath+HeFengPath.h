//
//  UIBezierPath+HeFengPath.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (HeFengPath)
/**
 *  The curve‘s bend level. The good value is about 0.6 ~ 0.8. The default and recommended value is 0.7.
 */
@property (nonatomic) CGFloat contractionFactor;

/**
 *  You must wrap CGPoint struct to NSString object.
 *
 *  @param pointArray Points you want to through. You must give at least 1 point for drawing curve.
 */
- (void)addBezierThroughPoints:(NSArray *)pointArray;
/**
 绘制单个折线
 
 @param linesArray 单个折线数组
 @return 绘制的path
 */
+ (UIBezierPath*)drawLine:(NSMutableArray*)linesArray;

/**
 绘制多个折线
 
 @param linesArray 多个折线数组
 @return 绘制的path数组
 */
+ (NSMutableArray<__kindof UIBezierPath*>*)drawLines:(NSMutableArray<NSMutableArray*>*)linesArray;
@end

NS_ASSUME_NONNULL_END
