//
//  AppDelegate.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "AppDelegate.h"
#import "HeFengAuthorityViewController.h"
#import "ImagesDownloadManager.h"

@interface AppDelegate ()
@property (nonatomic,strong) NSMutableArray *idArray;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWindow];
//    [self readFile];
    return YES;
}
- (void)readFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"中国地级市id" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [content componentsSeparatedByString:@"\n"]; //字符串按照【分隔成数组
    [array enumerateObjectsUsingBlock:^(NSString *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.idArray addObject:[NSString stringWithFormat:@"http://www.weather.com.cn/m/i/climate/chn/%@.jpg",[obj stringByReplacingOccurrencesOfString:@"CN" withString:@""]]];
    }];
    [ImagesDownloadManager downloadImagesWithURLs:self.idArray];
}
#pragma mark 初始化rootVC
-(void)initWindow{
    [HeFengWeatherTool initLog];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:HeFengWeatherManager.isFirstOpenApp?[HeFengAuthorityViewController new]:[[HeFengBaseNavigationViewController alloc]initWithRootViewController:[HeFengHomeViewController new]]];
}
-(NSMutableArray *)idArray{
    if (!_idArray) {
        _idArray = [NSMutableArray array];
    }
    return _idArray;
}

@end
