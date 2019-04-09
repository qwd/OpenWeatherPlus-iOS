//
//  HeFengSearchBarView.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengSearchBarView.h"
@interface HeFengSearchBarView()
@property (nonatomic,strong) UIView *searchBackView;
@property (nonatomic,strong) UIImageView *searchImageView;
@end
@implementation HeFengSearchBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)configUI{

    self.searchBackView = [UIView new];
    self.searchBackView.backgroundColor = HeFengColor_EDEEF0;
    kViewRadius(self.searchBackView, 8);
    [self addSubview:self.searchBackView];
    
    self.searchImageView = [UIImageView new];
    self.searchImageView.image = UIImageMake(@"hefeng_search");
    [self.searchBackView addSubview:self.searchImageView];
    
    self.searchTextField = [HeFengBaseTextField new];
    self.searchTextField.placeholder = HeFengLocal(@"hengfengLocalString_36");
    self.searchTextField.hefengFontSize = HeFengFontSize_16;
    self.searchTextField.textColor = HeFengColor_4A4A4A;
    [self.searchBackView addSubview:self.searchTextField];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.searchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(Space_16);
        make.right.equalTo(-Space_16);
        make.height.equalTo(36);
    }];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(8);
        make.width.height.equalTo(14);
    }];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(self.searchImageView.mas_right).offset(8);
        make.right.equalTo(-8);
    }];
}


@end
