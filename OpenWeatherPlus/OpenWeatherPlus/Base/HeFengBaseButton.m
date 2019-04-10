//
//  HeFengBaseButton.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseButton.h"

@implementation HeFengBaseButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[HeFengNotificationCenter rac_addObserverForName:KNotificationChangeTextSetting object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            [self changeTextSetting];
        }];
    }
    return self;
}
- (void)setHefengFontSize:(CGFloat)hefengFontSize{
    _hefengFontSize = hefengFontSize;
    [self changeTextSetting];
}

-(void)changeTextSetting{
    self.titleLabel.font = [HeFengWeatherTool getFontWithFontSize:self.hefengFontSize];
}
@end
