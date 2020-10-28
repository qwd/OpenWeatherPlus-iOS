//
//  QWeatherCollectionCityCell.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherCollectionCityCell.h"

@implementation QWeatherCollectionCityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [QWeatherBaseLabel new];
        self.titleLabel.hefengFontSize = QWeatherFontSize_14;
        self.titleLabel.textColor = QWeatherColor_4A4A4A;
        self.backgroundColor = QWeatherColor_FAFAFA;
        [self addSubview:self.titleLabel];
        kViewRadius(self, 5);
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

@end
