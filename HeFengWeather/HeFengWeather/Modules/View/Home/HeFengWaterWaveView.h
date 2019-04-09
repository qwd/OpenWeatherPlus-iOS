//
//  HeFengWaterWaveView.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeFengWaterWaveView : UIImageView
/**
 *  浪弯曲度
 */
@property (nonatomic, assign) CGFloat waveCurvature;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  浪色
 */
@property (nonatomic, strong) UIColor *wavecolor;


- (void)stopWaveAnimation;

- (void)startWaveAnimation;
@end

NS_ASSUME_NONNULL_END
