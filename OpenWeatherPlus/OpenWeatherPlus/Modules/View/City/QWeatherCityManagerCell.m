//
//  QWeatherCityManagerCell.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherCityManagerCell.h"

@implementation QWeatherCityManagerCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self configUI];
      
    }
    return self;
}
-(void)configUI{
    self.titleLabel = [QWeatherBaseLabel new];
    self.titleLabel.hefengFontSize = QWeatherFontSize_14;
    self.titleLabel.textColor = QWeatherColor_4A4A4A;
    
    self.line = [UIView new];
    self.line.backgroundColor = QWeatherColor_ECECEC;
    
    self.delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.delButton setImage:UIImageMake(@"hefeng_cityDel") forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.delButton];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.titleLabel];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.delButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.height.equalTo(self.delButton.mas_width);
        make.centerY.equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.delButton.mas_right).offset(8);
        make.top.bottom.right.equalTo(0);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.right.equalTo(self);
        make.height.equalTo(1);
        make.left.equalTo(self.titleLabel);
    }];
}

@end
