//
//  HeFengHourlyImageView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengHourlyImageView.h"

@implementation HeFengHourlyImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self scrollImage];
    }
    return self;
}
-(void)scrollImage{
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationScrollImages object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        if ([x.object floatValue]<=24&&[x.object floatValue]>=0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.imageView.frame = CGRectMake((self.qmui_width-16)/24.0*[x.object floatValue], self.imageView.qmui_top, 16,16);
            }];
        }
    }];
}
-(void)configUI{
    //修改背景渐变颜色
//     self.backLayer.colors = @[(__bridge id)kRandomColor.CGColor,(__bridge id)HeFengColor_ECECEC.CGColor];
    [self.layer addSublayer:self.backLayer];
    
    self.vlineLayer = [CAShapeLayer qmui_separatorDashLayerWithLineLength:2 lineSpacing:2 lineWidth:1 lineColor:HeFengColor_A4A4A4.CGColor isHorizontal:NO];
    [self.layer addSublayer:self.vlineLayer];
    
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    
}
-(CAGradientLayer *)backLayer{
    if (!_backLayer) {
        _backLayer = [CAGradientLayer layer];
        _backLayer.startPoint = CGPointMake(0, 0);
        _backLayer.endPoint = CGPointMake(0, 1);
        _backLayer.locations = @[@0,@1];
        _backLayer.contentsScale = ScreenScale;

    }
    return _backLayer;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backLayer.frame = self.bounds;
    self.vlineLayer.frame = CGRectMake(self.qmui_width-1, 0, 1, self.qmui_height);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(-4);
        make.size.equalTo(CGSizeMake(16, 16));
    }];
}


@end
