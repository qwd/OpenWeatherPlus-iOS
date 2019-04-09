//
//  HeFengAuthorityViewController.m
//  HeFengWeather
//
//  Created by he on 2019/4/1.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengAuthorityViewController.h"
#import "HeFengSearchViewController.h"

@implementation HeFengAuthorityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    UIImageView *imageView = [UIImageView new];
    imageView.image =UIImageMake(@"hefeng_location_alert");
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = HeFengLocal(@"hengfengLocalString_46");
    titleLabel.font= HeFengSystemFontOfSize(16);
    titleLabel.textColor = kHeFengColor(@"#030303");
    [self.view addSubview:titleLabel];
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.numberOfLines = 0;
    NSMutableAttributedString *mutbaletitle = [[NSMutableAttributedString alloc]initWithString:HeFengLocal(@"hengfengLocalString_47")];
    mutbaletitle.yy_font = HeFengSystemFontOfSize(12);
    mutbaletitle.yy_color = kHeFengColor(@"#A4A4A4");
    mutbaletitle.yy_alignment = NSTextAlignmentLeft;
    mutbaletitle.yy_lineSpacing = 1.5;
    contentLabel.attributedText = mutbaletitle;
    [self.view addSubview:contentLabel];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.titleLabel.font = HeFengSystemFontOfSize(14);
    sureButton.titleLabel.textColor = kHeFengColor(@"#F7F8FA");
    [sureButton setBackgroundColor:kHeFengColor(@"#446FF2")];
    [sureButton setTitle:HeFengLocal(@"hengfengLocalString_48") forState:UIControlStateNormal];
    kViewRadius(sureButton, 25);
    [self.view addSubview:sureButton];
    [[sureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self resetRootVC];
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = HeFengSystemFontOfSize(14);
    cancelButton.titleLabel.textColor = kHeFengColor(@"#A4A4A4");
    [cancelButton setBackgroundColor:kHeFengColor(@"#979797")];
    [cancelButton setTitle:HeFengLocal(@"hengfengLocalString_49") forState:UIControlStateNormal];
    kViewRadius(cancelButton, 25);
    [self.view addSubview:cancelButton];
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        HeFengSearchViewController *searchVc = [HeFengSearchViewController new];
        searchVc.isSelectLocatin = YES;
        [self presentViewController:[[HeFengBaseNavigationViewController alloc] initWithRootViewController:searchVc]animated:YES completion:nil];
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(120);
        make.height.width.equalTo(80);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(32);
        make.centerX.equalTo(0);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(61);
        make.right.equalTo(-61);
        make.top.equalTo(titleLabel.mas_bottom).offset(34);
    }];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(52);
        make.centerX.equalTo(0);
        make.width.equalTo(170);
        make.height.equalTo(50);
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sureButton.mas_bottom).offset(16);
        make.centerX.equalTo(0);
        make.width.equalTo(170);
        make.height.equalTo(50);
    }];
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationRestRootVC object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self resetRootVC];
    }];
}
-(void)resetRootVC{
    [kAppWindow setRootViewController:[[HeFengBaseNavigationViewController alloc]initWithRootViewController:[HeFengHomeViewController new]]];
    HeFengWeatherManager.isFirstOpenApp = NO;
}
@end
