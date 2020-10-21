//
//  QWeatherBaseTextField.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseTextField.h"

@implementation QWeatherBaseTextField
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[QWeatherNotificationCenter rac_addObserverForName:KNotificationChangeTextSetting object:nil] subscribeNext:^(NSNotification * _Nullable x) {
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
    self.font = [QWeatherWeatherTool getFontWithFontSize:self.hefengFontSize];
}
@end
