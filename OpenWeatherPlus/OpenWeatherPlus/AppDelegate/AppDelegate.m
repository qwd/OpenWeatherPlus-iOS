//
//  AppDelegate.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "AppDelegate.h"
#import "QWeatherAuthorityViewController.h"

@interface AppDelegate ()
@property (nonatomic,strong) NSMutableArray *idArray;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWindow];
    return YES;
}
#pragma mark 初始化rootVC
-(void)initWindow{
    [QWeatherTool initLog];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:QWeatherManager.isFirstOpenApp?[QWeatherAuthorityViewController new]:[[QWeatherBaseNavigationViewController alloc]initWithRootViewController:[QWeatherHomeViewController new]]];
}
@end
