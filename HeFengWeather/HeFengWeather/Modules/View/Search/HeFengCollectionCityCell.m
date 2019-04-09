//
//  HeFengCollectionCityCell.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengCollectionCityCell.h"

@implementation HeFengCollectionCityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [HeFengBaseLabel new];
        self.titleLabel.hefengFontSize = HeFengFontSize_14;
        self.titleLabel.textColor = HeFengColor_4A4A4A;
        self.backgroundColor = HeFengColor_FAFAFA;
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
