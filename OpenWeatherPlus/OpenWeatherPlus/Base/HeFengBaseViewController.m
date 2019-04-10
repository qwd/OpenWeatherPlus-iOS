//
//  HeFengBaseViewController.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseViewController.h"

@interface HeFengBaseViewController ()

@end

@implementation HeFengBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HeFengColor_ECECEC;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self changeTextSetting];
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationChangeTextSetting object:nil] subscribeNext:^(NSNotification * _Nullable x) {
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
    self.titleView.titleLabel.font = [HeFengWeatherTool getFontWithFontSize:17];
}

- (nullable UIImage *)navigationBarBackgroundImage{
    return [UIImage qmui_imageWithColor:HeFengColor_FAFAFA];
}
- (nullable UIImage *)navigationBarShadowImage{
    return [UIImage qmui_imageWithColor:HeFengColor_FAFAFA];
}
- (nullable UIColor *)navigationBarTintColor{
    return HeFengColor_A4A4A4;
}
- (nullable UIColor *)titleViewTintColor{
    return HeFengColor_212121;
}

@end
