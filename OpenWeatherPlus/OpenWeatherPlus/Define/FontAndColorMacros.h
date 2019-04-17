//
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区

#define Space_32  32.f
#define Space_24  24.f
#define Space_16  16.f

#pragma mark -  颜色区
#define kHeFengColor(R)  [UIColor qmui_colorWithHexString:R]
#define kRandomColor  [UIColor qmui_randomColor]
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]

#define HeFengColor_333333  [UIColor qmui_colorWithHexString:@"#333333"]
#define HeFengColor_F7F8FA  [UIColor qmui_colorWithHexString:@"#F7F8FA"]
#define HeFengColor_F5F5F5  [UIColor qmui_colorWithHexString:@"#F5F5F5"]
#define HeFengColor_F0F0F0  [UIColor qmui_colorWithHexString:@"#F0F0F0"]
#define HeFengColor_212121  [UIColor qmui_colorWithHexString:@"#212121"]
#define HeFengColor_7A7A7A  [UIColor qmui_colorWithHexString:@"#7A7A7A"]
#define HeFengColor_FFFFFF  [UIColor qmui_colorWithHexString:@"#FFFFFF"]
#define HeFengColor_FAFAFA  [UIColor qmui_colorWithHexString:@"#FAFAFA"]
#define HeFengColor_CCCCCC  [UIColor qmui_colorWithHexString:@"#CCCCCC"]
#define HeFengColor_ABABAB  [UIColor qmui_colorWithHexString:@"#ABABAB"]
#define HeFengColor_A4A4A4  [UIColor qmui_colorWithHexString:@"#A4A4A4"]
#define HeFengColor_4A4A4A  [UIColor qmui_colorWithHexString:@"#4A4A4A"]
#define HeFengColor_EDEEF0  [UIColor qmui_colorWithHexString:@"#EDEEF0"]
#define HeFengColor_919191  [UIColor qmui_colorWithHexString:@"#919191"]
#define HeFengColor_4CB055  [UIColor qmui_colorWithHexString:@"#4CB055"]
#define HeFengColor_ECECEC  [UIColor qmui_colorWithHexString:@"#ECECEC"]
#define HeFengColor_6EAC5D  [UIColor qmui_colorWithHexString:@"#6EAC5D"]
#define HeFengColor_ED802D  [UIColor qmui_colorWithHexString:@"#ED802D"]
#define HeFengColor_DCDDE3  [UIColor qmui_colorWithHexString:@"#DCDDE3"]
#define HeFengColor_EE8F46  [UIColor qmui_colorWithHexString:@"#EE8F46"]


#define HeFengColor_318BF8  [UIColor qmui_colorWithHexString:@"#318BF8"]//蓝
#define HeFengColor_D1CA13  [UIColor qmui_colorWithHexString:@"#D1CA13"]//黄
#define HeFengColor_D76801  [UIColor qmui_colorWithHexString:@"#D76801"]//橙
#define HeFengColor_C01B09  [UIColor qmui_colorWithHexString:@"#C01B09"]//红







#pragma mark -  字体区
#define HeFengSystemFontOfSize(R)     [UIFont systemFontOfSize:R]
#define HeFengAdaptedSmallFontSize(R)     HeFengSystemFontOfSize(R-2)
#define HeFengAdaptedMediumFontSize(R)    HeFengSystemFontOfSize(R)
#define HeFengAdaptedLargeFontSize(R)     HeFengSystemFontOfSize(R+2)
#define HeFengFontSize_60 60.f
#define HeFengFontSize_17 17.f
#define HeFengFontSize_16 16.f
#define HeFengFontSize_14 14.f
#define HeFengFontSize_12 12.f
#define HeFengFontSize_10 10.f
#endif /* FontAndColorMacros_h */
