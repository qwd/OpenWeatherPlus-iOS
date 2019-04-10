//
//  HeFengDayWeatherRowView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengDayWeatherRowView.h"

@implementation HeFengDayWeatherRowView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.backgroundColor = HeFengColor_F0F0F0;
    }
    return self;
}
-(void)configUI{
    self.dayLabel = [HeFengBaseLabel new];
    [self addSubview:self.dayLabel];
    
    self.dayWeatherImageView = [UIImageView new];
    self.dayWeatherImageView.image = UIImageMake(HeFengStringFormat(@"todayItem_%d",0));
    [self addSubview:self.dayWeatherImageView];

    self.nightWeatherImageView = [UIImageView new];
    self.nightWeatherImageView.image = UIImageMake(HeFengStringFormat(@"todayItem_%d",1));
    [self addSubview:self.nightWeatherImageView];
    
    self.maxTempLabel = [HeFengBaseLabel new];
    [self addSubview:self.maxTempLabel];
    
    self.minTempLabel = [HeFengBaseLabel new];
    self.minTempLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.minTempLabel];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(Space_16);
    }];
    [self.dayWeatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.right.equalTo(self.mas_centerX).offset(-Space_16);
        make.height.width.equalTo(20);
    }];
    [self.nightWeatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(self.mas_centerX).offset(Space_16);
        make.height.width.equalTo(20);
    }];
    [self.minTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(-Space_16);
    }];
    [self.maxTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.minTempLabel.mas_left).offset(-Space_16);
    }];
}
@end
