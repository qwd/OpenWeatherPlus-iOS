//
//  HeFengBaseLabel.m
//  HeFengWeather
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseLabel.h"

@implementation HeFengBaseLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[HeFengNotificationCenter rac_addObserverForName:KNotificationChangeTextSetting object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            [self changeTextSetting];
        }];
    }
    return self;
}
-(void)setHefengTempString:(NSString *)hefengTempString{
    _hefengTempString = hefengTempString;
    [self changeTextSetting];
}
-(void)setHefengLocalString:(NSString *)hefengLocalString{
    _hefengLocalString = hefengLocalString;
    [self changeTextSetting];
}
- (void)setHefengFontSize:(CGFloat)hefengFontSize{
    _hefengFontSize = hefengFontSize;
    [self changeTextSetting];
}

-(void)changeTextSetting{
    self.font = [HeFengWeatherTool getFontWithFontSize:self.hefengFontSize];
    if (self.hefengLocalString) {
        self.text = HeFengLocal(self.hefengLocalString);
    }
    if (self.hefengTempString) {
        self.text = [HeFengWeatherTool getTempStringWithString:self.hefengTempString isHaveUnit:YES];
    }
}
@end
