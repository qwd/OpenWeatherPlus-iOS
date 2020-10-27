//
//  QWeatherTool.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#import "QWeatherTool.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation QWeatherTool

+(void)initLog{
    
    [QMUIConfiguration sharedInstance].shouldPrintDefaultLog = NO;
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //保存日志
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc]initWithLogsDirectory:kPathCache]];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger withLevel:DDLogLevelWarning];
    
    if (QWeatherStrValid(KAMapLocationAPPKey)) {
        [AMapServices sharedServices].apiKey = KAMapLocationAPPKey;
    }else{
        QWeatherLogWarn(@"请添加高德定位key👉🏻👉🏻👉🏻（替换KAMapLocationAPPKey的值）");
    }
    
    if (QWeatherStrValid(HeWeatherSDK_USERNameKey)||QWeatherStrValid(HeWeatherSDK_USERKey)) {
        QWeatherConfigInstance.publicID = HeWeatherSDK_USERNameKey;
        QWeatherConfigInstance.appKey = HeWeatherSDK_USERKey;
        QWeatherConfigInstance.appType = APP_TYPE_BIZ;
    }else{
        QWeatherLogWarn(@"请添加和风天气的key👉🏻👉🏻👉🏻（替换HeWeatherSDK_USERNameKey和HeWeatherSDK_USERKey的值）");
    }
}

+(BOOL)isLocationAuthorizationStatusDenied{
    //用户没有选择是否要使用定位服务（弹框没选择，或者根本没有弹框）
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        return NO;
        //用户在设置中关闭定位功能，或者用户明确的在弹框之后选择禁止定位
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:QWeatherLocal(@"hengfengLocalString_46") message:nil preferredStyle:QMUIAlertControllerStyleAlert];
        //        UIView *view = [UIView new];
        //        view.backgroundColor = kRandomColor;
        //        view.qmui_width = 100;
        //        view.qmui_height = 100;
        //        [alertController addCustomView:view];
        [alertController addAction:[QMUIAlertAction actionWithTitle:QWeatherLocal(@"hengfengLocalString_51") style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            if (@available(iOS 8.0, *)) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([kApplication canOpenURL:url]) {
                    [kApplication openURL:url];
                }
            } else {
                [kApplication openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
            }
        }]];
        [alertController addAction:[QMUIAlertAction actionWithTitle:QWeatherLocal(@"hengfengLocalString_49") style:QMUIAlertActionStyleDefault handler:nil]];
        [alertController showWithAnimated:YES];
        return YES;
    }else{
        return NO;
    }
}

+(NSString *)getTempStringWithString:(NSString *)string isHaveUnit:(BOOL)isHaveUnit{
    CGFloat temp = string.floatValue;
    if (QWeatherManager.settingModel.unitType==1) {
        return  QWeatherStringFormat(@"%ld%@",(long)[@(temp) integerValue],isHaveUnit?@"°":@"");
    }else{
        return  QWeatherStringFormat(@"%ld%@",(long)[@(temp*1.8) integerValue]+32,isHaveUnit?@"°":@"");
    }
}

+(NSString *)getTimeStringWithSting:(NSString *)string dateformat:(NSString *)dateformat isShowToday:(BOOL)isShowToday{
    NSDate *date = [NSDate dateWithString:string formatString:dateformat];
    NSArray *titlesArray = [NSArray arrayWithObjects: @"", @"hengfengLocalString_43", @"hengfengLocalString_37", @"hengfengLocalString_38", @"hengfengLocalString_39", @"hengfengLocalString_40", @"hengfengLocalString_41", @"hengfengLocalString_42", nil];
    if (isShowToday&&[date isToday]) {
        return  @"hengfengLocalString_44";
    }else{
        return  titlesArray[[date weekday]];
    }
}

+(UIImage *)getWeatherImageWithWeatherCode:(NSString *)weatherCode date:(NSString *)date formatString:(nonnull NSString *)formatString{
    return  [self getWeatherImageWithWeatherCode:weatherCode isDay:[self isDayWithStr:date] formatString:formatString];
}

+(UIImage *)getWeatherImageWithWeatherCode:(NSString *)weatherCode isDay:(BOOL)isDay formatString:(nonnull NSString *)formatString{
    return   UIImageMake(QWeatherStringFormat(@"%@%@%@",formatString,weatherCode,isDay?@"d":@"n"));
}
+(BOOL)isDayWithStr:(NSString*)str{
    NSInteger  hour = [NSDate dateWithString:str formatString:QWeatherFormatString1].hour;
    if (hour>19||hour<07) {
        return NO;
    }
    else{
        return YES;
    }
}
+(UIFont *)getFontWithFontSize:(CGFloat)FontSize{
    switch (QWeatherManager.settingModel.fontType) {
        case 0:
            return QWeatherAdaptedSmallFontSize(FontSize);
            break;
        case 1:
            return QWeatherAdaptedMediumFontSize(FontSize);
            break;
        case 2:
            return QWeatherAdaptedLargeFontSize(FontSize);
            break;
        default:
            return QWeatherAdaptedMediumFontSize(FontSize);;
            break;
    }
}

+(UIColor *)getAqiColorWithString:(NSString *)string{
    NSInteger aqi = string.integerValue;
    if (aqi<=50) {
        return kQWeatherColor(@"#95B359");
    }else if (aqi<=100){
        return kQWeatherColor(@"#D9D459");
    }
    else if (aqi<=150){
        return kQWeatherColor(@"#E0991D");
    }
    else if (aqi<=200){
        return kQWeatherColor(@"#D96161");
    }
    else if (aqi<=300){
        return kQWeatherColor(@"#CB91F0");
    }
    else{
        return kQWeatherColor(@"#D9416F");
    }
}

@end
