//
//  HeFengBaseView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"

@implementation HeFengBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HeFengColor_F7F8FA;
    }
    return self;
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    
}
@end
