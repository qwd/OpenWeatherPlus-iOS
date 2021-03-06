//
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#ifndef define_h
#define define_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]

//不同屏幕尺寸字体适配
#define SCREEN_WIDTHRatio  (SCREEN_WIDTH / 375.0)
#define SCREEN_HEIGHTRatio (SCREEN_HEIGHT / 667.0)
#define QWeatherAdaptedWidth(x)  ceilf((x) * SCREEN_WIDTHRatio)
#define QWeatherAdaptedHeight(x) ceilf((x) * SCREEN_HEIGHTRatio)

//发送通知
#define QWeatherNotificationCenter [NSNotificationCenter defaultCenter]
#define QWeatherPostNotification(name,obj) [QWeatherNotificationCenter postNotificationName:name object:obj];

//View 圆角和加边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


//-------------------打印日志-------------------------
#define LOG_LEVEL_DEF ddLogLevel
#import <CocoaLumberjack/CocoaLumberjack.h>
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif
#define QWeatherLogError(frmt, ...)      DDLogError(frmt, ##__VA_ARGS__)
#define QWeatherLogWarn(frmt, ...)       DDLogWarn(frmt, ##__VA_ARGS__)
#define QWeatherLogInfo(frmt, ...)       DDLogInfo(frmt, ##__VA_ARGS__)
#define QWeatherLogDebug(frmt, ...)      DDLogDebug(frmt, ##__VA_ARGS__)
#define QWeatherLogVerbose(frmt, ...)    DDLogVerbose(frmt, ##__VA_ARGS__)


#define QWeatherStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
#define QWeatherStrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define QWeatherStrEqual(a,b) [a isEqualToString:b]
#define QWeatherSafeStr(f) (StrValid(f) ? f:@"")
#define QWeatherHasString(str,key) ([str rangeOfString:key].location!=NSNotFound)
#define QWeatherValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define QWeatherValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define QWeatherValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define QWeatherValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define QWeatherValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

/** 获取APP名称 */
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 系统版本 */
#define APP_CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
/** 获取APP build版本 */
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])


#endif /* define_h */
