//
//  HeFengTodayWeatherMoonRiseCurveView.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengTodayWeatherMoonRiseCurveView.h"

@implementation HeFengTodayWeatherMoonRiseCurveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)setStartTime:(NSString *)startTime endTime:(NSString *)endTime tz:(NSString *)tz{
    NSDate *dateNow = [[NSDate date] dateByAddingSeconds:tz.floatValue*60*60];
    NSDate *riseDete = [NSDate dateWithString:startTime formatString:HeFengFormatString1 timeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *setDete = [NSDate dateWithString:endTime formatString:HeFengFormatString1 timeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    if ([riseDete isLaterThanOrEqualTo:setDete]) {
        setDete = [setDete dateByAddingDays:1];
    }
    NSInteger secondsAll = [riseDete secondsEarlierThan:setDete];
    NSInteger secondsNow = [riseDete secondsEarlierThan:dateNow];
    
    if (secondsAll==0) {
        return;
    }
    if ([dateNow isEarlierThanOrEqualTo:riseDete]) {
        self.progress = 0;
    }else if ([dateNow isLaterThanOrEqualTo:setDete]){
        self.progress = 1;
    }else{
        self.progress = secondsNow*1.0/secondsAll>=1?1:secondsNow*1.0/secondsAll;
    }
    kDISPATCH_MAIN_THREAD(^{
        CGFloat radius = (self.qmui_width-20)/2 ;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position";
        animation.duration = 1;
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeRemoved;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius+10, self.qmui_height) radius:radius startAngle:M_PI endAngle:M_PI*(self.progress+1) clockwise:true];
        animation.path = circlePath.CGPath;
        self.imageView.frame = CGRectMake(circlePath.currentPoint.x-8, circlePath.currentPoint.y-8, 16, 16);
        [self.imageView.layer addAnimation:animation forKey:nil];
    })
}
-(void)configUI{
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = HeFengColor_ECECEC;
    [self addSubview:self.bottomLine];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.equalTo(1);
    }];
  
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat radius = (self.qmui_width-20)/2 ;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius+10, self.qmui_height) radius:radius startAngle:M_PI endAngle:M_PI*2 clockwise:YES];
    path.lineWidth = 1.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    CGFloat dashPattern[] = {3,3};
    [path setLineDash:dashPattern count:2 phase:0];
    [HeFengColor_A4A4A4 setStroke];
    [path stroke];
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
