//
//  HeFengWeatherTool.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//
//  When I wrote this, only God and I understood what I was doing
//  Now, God only knows

#import "HeFengWeatherTool.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation HeFengWeatherTool

+(void)initLog{
    
    [QMUIConfiguration sharedInstance].shouldPrintDefaultLog = NO;
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //保存日志
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc]initWithLogsDirectory:kPathCache]];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger withLevel:DDLogLevelWarning];
    
    if (HeFengStrValid(KAMapLocationAPPKey)) {
        [AMapServices sharedServices].apiKey = KAMapLocationAPPKey;
    }else{
        HeFengLogWarn(@"请添加高德定位key👉🏻👉🏻👉🏻（替换KAMapLocationAPPKey的值）");
    }
    
    if (HeFengStrValid(HeWeatherSDK_USERNameKey)||HeFengStrValid(HeWeatherSDK_USERKey)) {
        HeConfigInstance.publicID = HeWeatherSDK_USERNameKey;
        HeConfigInstance.appKey = HeWeatherSDK_USERKey;
        HeConfigInstance.appType = APP_TYPE_BIZ;
    }else{
        HeFengLogWarn(@"请添加和风天气的key👉🏻👉🏻👉🏻（替换HeWeatherSDK_USERNameKey和HeWeatherSDK_USERKey的值）");
    }
}

+(BOOL)isLocationAuthorizationStatusDenied{
    //用户没有选择是否要使用定位服务（弹框没选择，或者根本没有弹框）
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        return NO;
        //用户在设置中关闭定位功能，或者用户明确的在弹框之后选择禁止定位
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:HeFengLocal(@"hengfengLocalString_46") message:nil preferredStyle:QMUIAlertControllerStyleAlert];
        //        UIView *view = [UIView new];
        //        view.backgroundColor = kRandomColor;
        //        view.qmui_width = 100;
        //        view.qmui_height = 100;
        //        [alertController addCustomView:view];
        [alertController addAction:[QMUIAlertAction actionWithTitle:HeFengLocal(@"hengfengLocalString_51") style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            if (@available(iOS 8.0, *)) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([kApplication canOpenURL:url]) {
                    [kApplication openURL:url];
                }
            } else {
                [kApplication openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
            }
        }]];
        [alertController addAction:[QMUIAlertAction actionWithTitle:HeFengLocal(@"hengfengLocalString_49") style:QMUIAlertActionStyleDefault handler:nil]];
        [alertController showWithAnimated:YES];
        return YES;
    }else{
        return NO;
    }
}

+(NSString *)getTempStringWithString:(NSString *)string isHaveUnit:(BOOL)isHaveUnit{
    CGFloat temp = string.floatValue;
    if (HeFengWeatherManager.settingModel.unitType==1) {
        return  HeFengStringFormat(@"%ld%@",(long)[@(temp) integerValue],isHaveUnit?@"°":@"");
    }else{
        return  HeFengStringFormat(@"%ld%@",(long)[@(temp*1.8) integerValue]+32,isHaveUnit?@"°":@"");
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
    return   UIImageMake(HeFengStringFormat(@"%@%@%@",formatString,weatherCode,isDay?@"d":@"n"));
}
+(BOOL)isDayWithStr:(NSString*)str{
    NSInteger  hour = [NSDate dateWithString:str formatString:HeFengFormatString1].hour;
    if (hour>19||hour<07) {
        return NO;
    }
    else{
        return YES;
    }
}
+(UIFont *)getFontWithFontSize:(CGFloat)FontSize{
    switch (HeFengWeatherManager.settingModel.fontType) {
        case 0:
            return HeFengAdaptedSmallFontSize(FontSize);
            break;
        case 1:
            return HeFengAdaptedMediumFontSize(FontSize);
            break;
        case 2:
            return HeFengAdaptedLargeFontSize(FontSize);
            break;
        default:
            return HeFengAdaptedMediumFontSize(FontSize);;
            break;
    }
}

+(UIColor *)getAqiColorWithString:(NSString *)string{
    NSInteger aqi = string.integerValue;
    if (aqi<=50) {
        return kHeFengColor(@"#95B359");
    }else if (aqi<=100){
        return kHeFengColor(@"#D9D459");
    }
    else if (aqi<=150){
        return kHeFengColor(@"#E0991D");
    }
    else if (aqi<=200){
        return kHeFengColor(@"#D96161");
    }
    else if (aqi<=300){
        return kHeFengColor(@"#CB91F0");
    }
    else{
        return kHeFengColor(@"#D9416F");
    }
}

@end
