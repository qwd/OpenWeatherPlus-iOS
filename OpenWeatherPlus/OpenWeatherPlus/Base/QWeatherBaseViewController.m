//
//  QWeatherBaseViewController.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseViewController.h"

@interface QWeatherBaseViewController ()

@end

@implementation QWeatherBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = QWeatherColor_ECECEC;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self changeTextSetting];
    [[QWeatherNotificationCenter rac_addObserverForName:KNotificationChangeTextSetting object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self changeTextSetting];
    }];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)){
            [UITableView appearance].estimatedRowHeight = 0;
            [UITableView appearance].estimatedSectionHeaderHeight = 0;
            [UITableView appearance].estimatedSectionFooterHeight = 0;
        }
    });
    
}
-(void)changeTextSetting{
    self.titleView.titleLabel.font = [QWeatherWeatherTool getFontWithFontSize:17];
}

- (nullable UIImage *)navigationBarBackgroundImage{
    return [UIImage qmui_imageWithColor:QWeatherColor_FAFAFA];
}
- (nullable UIImage *)navigationBarShadowImage{
    return [UIImage qmui_imageWithColor:QWeatherColor_FAFAFA];
}
- (nullable UIColor *)navigationBarTintColor{
    return QWeatherColor_A4A4A4;
}
- (nullable UIColor *)titleViewTintColor{
    return QWeatherColor_212121;
}

@end
