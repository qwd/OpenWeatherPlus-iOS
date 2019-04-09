//
//  HeFengAboutViewController.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengAboutViewController.h"

@interface HeFengAboutViewController ()
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@end

@implementation HeFengAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = HeFengLocal(@"hengfengLocalString_25");
    [self configUI];
}
-(void)configUI{
    self.iconImageView = [UIImageView new];
    self.iconImageView.image = UIImageMake(@"hefeng_about");
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    kViewRadius(self.iconImageView, 10);
    [self.view addSubview:self.iconImageView];
    
    self.titleLabel = [HeFengBaseLabel new];
    self.titleLabel.hefengLocalString = @"hengfengLocalString_27";
    self.titleLabel.hefengFontSize = HeFengFontSize_17;
    self.titleLabel.textColor = HeFengColor_212121;
    [self.view addSubview:self.titleLabel];
    
    UIView *rowView = [UIView new];
    rowView.backgroundColor = HeFengColor_FAFAFA;
    [self.view addSubview:rowView];
    
    HeFengBaseLabel *currentVersionLabel = [HeFengBaseLabel new];
    currentVersionLabel.hefengLocalString = @"hengfengLocalString_26";
    currentVersionLabel.hefengFontSize = HeFengFontSize_14;
    currentVersionLabel.textColor = HeFengColor_4A4A4A;
    [rowView addSubview:currentVersionLabel];
    
    HeFengBaseLabel *currentVersionNmuberLabel = [HeFengBaseLabel new];
    currentVersionNmuberLabel.text =APP_VERSION;
    currentVersionNmuberLabel.hefengFontSize = HeFengFontSize_14;
    currentVersionNmuberLabel.textColor = HeFengColor_A4A4A4;
    [rowView addSubview:currentVersionNmuberLabel];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.mas_topLayoutGuide).offset(78);
        make.width.height.equalTo(88);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(17);
    }];
    
    [rowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(50);
        make.height.equalTo(50);
    }];
    [currentVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.centerY.equalTo(0);
    }];
    [currentVersionNmuberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-Space_16);
        make.centerY.equalTo(0);
    }];
}

@end
