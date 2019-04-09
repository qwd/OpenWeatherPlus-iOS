//
//  HeFengInstructionView.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengInstructionView.h"
#import "HeFengBaseView.h"

@interface HeFengInstructionView()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) HeFengBaseLabel *rightLabel;
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) HeFengBaseView *bottomeView;
@end

@implementation HeFengInstructionView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
//        self.backgroundColor = HeFengColor_F5F5F5;
    }
    return self;
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    self.imageView.image = UIImageMake(@"hefeng_logo");
   
}
-(void)configUI{
//    self.imageView = [UIImageView new];
//    [self addSubview: self.imageView];
//
//    self.titleLabel = [HeFengBaseLabel new];
//    self.titleLabel.hefengFontSize = HeFengFontSize_12;
//    self.titleLabel.textColor = HeFengColor_212121;
//    self.titleLabel.hefengLocalString = @"hengfengLocalString_29";
//    [self addSubview:self.titleLabel];
    
    self.rightLabel = [HeFengBaseLabel new];
    self.rightLabel.hefengFontSize = HeFengFontSize_10;
    self.rightLabel.textColor = HeFengColor_7A7A7A;
    self.rightLabel.hefengLocalString = @"hengfengLocalString_30";
    [self addSubview:self.rightLabel];
    
    self.bottomeView = [HeFengBaseView new];
    self.backgroundColor = HeFengColor_F7F8FA;
    [self addSubview:self.bottomeView];

}
-(void)layoutSubviews{
    [super layoutSubviews];
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(Space_16);
//        make.top.equalTo(8);
//        make.height.width.equalTo(32);
//    }];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imageView.mas_right).offset(Space_16);
//        make.centerY.equalTo(self.imageView);
//    }];
//    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-Space_16);
        make.top.equalTo(8);
        make.height.equalTo(32);
    }];
    
    [self.bottomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightLabel.mas_bottom).offset(8);
        make.left.bottom.right.equalTo(0);
        if (IS_NOTCHED_SCREEN) {
            make.height.equalTo(20);
        }else{
            make.height.equalTo(0);
        }
    }];
}
@end
