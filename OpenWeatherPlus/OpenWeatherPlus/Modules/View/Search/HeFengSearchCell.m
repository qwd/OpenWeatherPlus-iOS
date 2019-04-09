//
//  HeFengSearchCell.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengSearchCell.h"

@implementation HeFengSearchCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
        self.backgroundColor = KClearColor;
    }
    return self;
}
-(void)configUI{
    self.titleLabel = [HeFengBaseLabel new];
    self.titleLabel.hefengFontSize = HeFengFontSize_14;
    self.titleLabel.textColor = HeFengColor_A4A4A4;
    
    self.line = [UIView new];
    self.line.backgroundColor = HeFengColor_DCDDE3;
    
    
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.titleLabel];
}
-(void)layoutSubviews{
    [super layoutSubviews];
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.top.bottom.right.equalTo(0);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.right.equalTo(self.contentView);
        make.height.equalTo(1);
        make.left.equalTo(self.titleLabel);
    }];
}

@end
