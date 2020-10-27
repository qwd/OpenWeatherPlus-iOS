//
//  QWeatherTool.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface QWeatherTool : NSObject

/**
 初始化日志，
 */
+(void)initLog;

/**
 定位权限是否被拒绝

 @return yes/no
 */
+(BOOL)isLocationAuthorizationStatusDenied;

/**
 获取温度字符串 返回带单位的
 
 */
+(NSString *)getTempStringWithString:(NSString *)string isHaveUnit:(BOOL)isHaveUnit;

/**
 获取周几

 @param string 日期字符串
 @param dateformat dateformat
 @param isShowToday 是否显示今天
 @return 周几
 */
+(NSString *)getTimeStringWithSting:(NSString *)string dateformat:(NSString *)dateformat isShowToday:(BOOL)isShowToday;

/**
 获取天气图标

 @param weatherCode 天气代码code
 @param date 日期
 @param formatString 拼接字符串
 @return image
 */
+(UIImage *)getWeatherImageWithWeatherCode:(NSString *)weatherCode date:(NSString *)date formatString:(NSString *)formatString;


/**
 获取天气图标
 
 @param weatherCode 天气代码code
 @param isDay 是否是白天
 @param formatString 拼接字符串
 @return image
 */
+(UIImage *)getWeatherImageWithWeatherCode:(NSString *)weatherCode isDay:(BOOL)isDay formatString:(NSString *)formatString;

/**
 是否是白天

 @param str 时间字符串
 @returny yes/no
 */
+(BOOL)isDayWithStr:(NSString*)str;
/**
 获取当前字体大小

 @param FontSize 标准字体大小
 @return 对应大中小UIFont
 */
+(UIFont *)getFontWithFontSize:(CGFloat)FontSize;

/**
 获取aqi背景颜色

 @param string aqi数值
 @return 背景色
 */
+(UIColor *)getAqiColorWithString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
