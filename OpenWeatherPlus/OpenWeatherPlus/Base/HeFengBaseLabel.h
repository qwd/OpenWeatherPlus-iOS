//
//  HeFengBaseLabel.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeFengBaseLabel : UILabel
/**
 字体大小
 */
@property (nonatomic,assign) CGFloat hefengFontSize;
/**
 多语言
 */
@property (nonatomic,copy) NSString *hefengLocalString;
/**
 单位
 */
@property (nonatomic,copy) NSString *hefengTempString;

@end

NS_ASSUME_NONNULL_END
