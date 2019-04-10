//
//  HeFengBaseTextField.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseTextField.h"

@implementation HeFengBaseTextField
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
    self.font = [HeFengWeatherTool getFontWithFontSize:self.hefengFontSize];
}
@end
