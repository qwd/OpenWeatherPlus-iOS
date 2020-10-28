//
//  QWeatherBaseLabel.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/28.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseLabel.h"

@implementation QWeatherBaseLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[QWeatherNotificationCenter rac_addObserverForName:KNotificationChangeTextSetting object:nil] subscribeNext:^(NSNotification * _Nullable x) {
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
    self.font = [QWeatherTool getFontWithFontSize:self.hefengFontSize];
    if (self.hefengLocalString) {
        self.text = QWeatherLocal(self.hefengLocalString);
    }
    if (self.hefengTempString) {
        self.text = [QWeatherTool getTempStringWithString:self.hefengTempString isHaveUnit:YES];
    }
}
@end
