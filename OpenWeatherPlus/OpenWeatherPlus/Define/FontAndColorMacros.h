//
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区

#define Space_32  32.f
#define Space_24  24.f
#define Space_16  16.f

#pragma mark -  颜色区
#define kQWeatherColor(R)  [UIColor qmui_colorWithHexString:R]
#define kRandomColor  [UIColor qmui_randomColor]
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]

#define QWeatherColor_333333  [UIColor qmui_colorWithHexString:@"#333333"]
#define QWeatherColor_F7F8FA  [UIColor qmui_colorWithHexString:@"#F7F8FA"]
#define QWeatherColor_F5F5F5  [UIColor qmui_colorWithHexString:@"#F5F5F5"]
#define QWeatherColor_F0F0F0  [UIColor qmui_colorWithHexString:@"#F0F0F0"]
#define QWeatherColor_212121  [UIColor qmui_colorWithHexString:@"#212121"]
#define QWeatherColor_7A7A7A  [UIColor qmui_colorWithHexString:@"#7A7A7A"]
#define QWeatherColor_FFFFFF  [UIColor qmui_colorWithHexString:@"#FFFFFF"]
#define QWeatherColor_FAFAFA  [UIColor qmui_colorWithHexString:@"#FAFAFA"]
#define QWeatherColor_CCCCCC  [UIColor qmui_colorWithHexString:@"#CCCCCC"]
#define QWeatherColor_ABABAB  [UIColor qmui_colorWithHexString:@"#ABABAB"]
#define QWeatherColor_A4A4A4  [UIColor qmui_colorWithHexString:@"#A4A4A4"]
#define QWeatherColor_4A4A4A  [UIColor qmui_colorWithHexString:@"#4A4A4A"]
#define QWeatherColor_EDEEF0  [UIColor qmui_colorWithHexString:@"#EDEEF0"]
#define QWeatherColor_919191  [UIColor qmui_colorWithHexString:@"#919191"]
#define QWeatherColor_4CB055  [UIColor qmui_colorWithHexString:@"#4CB055"]
#define QWeatherColor_ECECEC  [UIColor qmui_colorWithHexString:@"#ECECEC"]
#define QWeatherColor_6EAC5D  [UIColor qmui_colorWithHexString:@"#6EAC5D"]
#define QWeatherColor_ED802D  [UIColor qmui_colorWithHexString:@"#ED802D"]
#define QWeatherColor_DCDDE3  [UIColor qmui_colorWithHexString:@"#DCDDE3"]
#define QWeatherColor_EE8F46  [UIColor qmui_colorWithHexString:@"#EE8F46"]


#define QWeatherColor_318BF8  [UIColor qmui_colorWithHexString:@"#318BF8"]//蓝
#define QWeatherColor_D1CA13  [UIColor qmui_colorWithHexString:@"#D1CA13"]//黄
#define QWeatherColor_D76801  [UIColor qmui_colorWithHexString:@"#D76801"]//橙
#define QWeatherColor_C01B09  [UIColor qmui_colorWithHexString:@"#C01B09"]//红







#pragma mark -  字体区
#define QWeatherSystemFontOfSize(R)     [UIFont systemFontOfSize:R]
#define QWeatherAdaptedSmallFontSize(R)     QWeatherSystemFontOfSize(R-2)
#define QWeatherAdaptedMediumFontSize(R)    QWeatherSystemFontOfSize(R)
#define QWeatherAdaptedLargeFontSize(R)     QWeatherSystemFontOfSize(R+2)
#define QWeatherFontSize_60 60.f
#define QWeatherFontSize_17 17.f
#define QWeatherFontSize_16 16.f
#define QWeatherFontSize_14 14.f
#define QWeatherFontSize_12 12.f
#define QWeatherFontSize_10 10.f
#endif /* FontAndColorMacros_h */
