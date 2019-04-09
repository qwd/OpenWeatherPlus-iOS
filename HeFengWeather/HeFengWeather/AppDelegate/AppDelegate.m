//
//  AppDelegate.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "AppDelegate.h"
#import "HeFengAuthorityViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWindow];
    return YES;
}
#pragma mark 初始化rootVC
-(void)initWindow{
    [HeFengWeatherTool initLog];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:HeFengWeatherManager.isFirstOpenApp?[HeFengAuthorityViewController new]:[[HeFengBaseNavigationViewController alloc]initWithRootViewController:[HeFengHomeViewController new]]];
}

@end
