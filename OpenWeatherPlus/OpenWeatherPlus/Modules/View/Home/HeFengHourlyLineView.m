//
//  HeFengHourlyLineView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengHourlyLineView.h"
#import "UIBezierPath+HeFengPath.h"

@implementation HeFengHourlyLineView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self scrollTempLabel];
    }
    return self;
}
-(void)configUI{
    self.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.contentView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(self);
    }];
    [self.xLabelsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:0 tailSpacing:0];
    [self.xLabelsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-Space_16);
        make.width.greaterThanOrEqualTo(60);
    }];
}
-(void)scrollTempLabel{
    @weakify(self)
    [RACObserve(self, contentOffset) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSInteger expenseindex = floorf(([x CGPointValue].x)/((self.contentSize.width-self.qmui_width)/24));
        HeFengPostNotification(KNotificationScrollImages,@(expenseindex));
        if (self.hourlyArray.count==25&&expenseindex<=24&&expenseindex>=0) {
            if (expenseindex==8) {
                self.tempLabel.text = [HeFengWeatherTool getTempStringWithString:self.hourlyArray.lastObject.temp isHaveUnit:YES];
            }else{
                self.tempLabel.text = [HeFengWeatherTool getTempStringWithString:self.hourlyArray[expenseindex].temp isHaveUnit:YES];
            }
            [UIView animateWithDuration:0.5 animations:^{
                self.tempLabel.frame = CGRectMake(self.xLineView.qmui_left+self.qmui_left+(self.qmui_width-self.xLineView.qmui_left-60)/24.0*expenseindex, self.qmui_top-20, 30,20);
            }];
        }
    }];
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    if (model.hourly.count!=8&&model.hourly.count!=24) {
        return;
    }
    NSMutableArray<Hourly*> *dataArray = [NSMutableArray array];
    [model.hourly enumerateObjectsUsingBlock:^(Hourly * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.hourly.count==8) {
            for (int i = 0; i<3; i++) {
                Hourly *model = [Hourly new];
                model.icon = obj.icon;
                model.fxTime = [[[NSDate dateWithString:obj.fxTime formatString:HeFengFormatString1] dateBySubtractingHours:2-i] formattedDateWithFormat:HeFengFormatString1];
                model.temp = obj.temp;
                [dataArray addObject:model];
            }
        }else{
            [dataArray addObject:obj];
        }
    }];
    [dataArray addObject:dataArray.lastObject];
    self.hourlyArray  = dataArray;
    if (self.hourlyArray.count==24) {
        [self.imagesView removeFromSuperview];
        [self.lineLayer removeFromSuperlayer];
        [self.xLabelsArray enumerateObjectsUsingBlock:^(HeFengBaseLabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx>0) {
                if (self.viewType==HeFengHourlyLineViewTypeFree) {
                    obj.text = [[NSDate dateWithString:self.hourlyArray[(idx-1)*3+1].fxTime formatString:HeFengFormatString1] formattedDateWithFormat:HeFengFormatString2];
                }else{
                    obj.text = [[NSDate dateWithString:self.hourlyArray[(idx-1)*2+1].fxTime formatString:HeFengFormatString1] formattedDateWithFormat:HeFengFormatString2];
                }
            }
        }];
        self.imagesView = [HeFengHourlyLineImagesView new];
        [self.contentView addSubview:self.imagesView];
        kDISPATCH_MAIN_THREAD(^{
            self.imagesView.frame = CGRectMake(self.xLineView.qmui_left, 0, self.xLineView.qmui_width, self.xLineView.qmui_top);
            [self.imagesView reloadViewWithModelArray:self.hourlyArray];
            //计算最高温最低温
            NSMutableArray *NumberArray = [NSMutableArray array];
            [self.hourlyArray enumerateObjectsUsingBlock:^(Hourly * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [NumberArray addObject:obj.temp];
            }];
            CGFloat  max = [[NumberArray valueForKeyPath:@"@max.floatValue"] qmui_CGFloatValue];
            CGFloat  min = [[NumberArray valueForKeyPath:@"@min.floatValue"] qmui_CGFloatValue];
            //温度占比
            NSMutableArray *tempPercentArray = [NSMutableArray array];
            [self.hourlyArray enumerateObjectsUsingBlock:^(Hourly * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tempPercentArray addObject:@((obj.temp.floatValue-min)*1.0/(max-min+1))];
            }];
            [self addLineWithArray:tempPercentArray];
        })
    }
}

-(void)addLineWithArray:(NSArray *)array{
    CGFloat xSpace = self.xLineView.qmui_width/24.0;
    NSMutableArray *pointArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = CGPointMake(xSpace*idx+self.xLineView.qmui_left, 15*(1-[obj floatValue])+5);
        [pointArray addObject:NSStringFromCGPoint(point)];
    }];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointFromString(pointArray.firstObject)];
    [path addBezierThroughPoints:pointArray];
    
    self.lineLayer = [self getLineLayerWithColor:HeFengColor_919191 LineWidth:2 Path:path];
    [self.contentView.layer addSublayer:self.lineLayer];
    
    NSMutableArray *pointMaskArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = CGPointMake(xSpace*idx+self.xLineView.qmui_left, 15*(1-[obj floatValue])+4);
        [pointMaskArray addObject:NSStringFromCGPoint(point)];
        
    }];
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [maskPath moveToPoint:CGPointFromString(pointMaskArray.firstObject)];
    [maskPath addBezierThroughPoints:pointMaskArray];
    [maskPath addLineToPoint:CGPointMake(self.contentView.qmui_width, self.contentView.qmui_height)];
    [maskPath addLineToPoint:CGPointMake(0, self.contentView.qmui_height)];
    [maskPath closePath];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = maskPath.CGPath;
    [self.contentView.layer setMask:mask];
}
-(CAShapeLayer*)getLineLayerWithColor:(UIColor*)color
                            LineWidth:(CGFloat)lineWidth
                                 Path:(UIBezierPath*)path{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.strokeColor = color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = lineWidth;
    layer.path = path.CGPath;
    layer.allowsEdgeAntialiasing = YES;
    layer.contentsScale = ScreenScale;
    return layer;
}
-(NSMutableArray<HeFengBaseLabel *> *)xLabelsArray{
    if (!_xLabelsArray) {
        _xLabelsArray = [NSMutableArray array];
        _vLineArray = [NSMutableArray array];
        NSInteger cout = self.viewType==HeFengHourlyLineViewTypeFree?9:13;
        for (int i=0; i<cout; i++) {
            HeFengBaseLabel *label = [HeFengBaseLabel new];
            label.hefengLocalString = @"hengfengLocalString_33";
            label.hefengFontSize = HeFengFontSize_10;
            label.textColor = HeFengColor_7A7A7A;
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [_xLabelsArray addObject:label];
            UIView *vline = [UIView new];
            vline.backgroundColor = HeFengColor_ECECEC;
            [self.contentView addSubview:vline];
            [_vLineArray addObject:vline];
            [vline mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(label.mas_top).offset(-5);
                make.centerX.equalTo(label);
                make.width.equalTo(1);
                make.height.equalTo(5);
            }];
        }
        _xLineView = [UIView new];
        _xLineView.backgroundColor = HeFengColor_ECECEC;;
        [self.contentView addSubview:_xLineView];
        [_xLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.vLineArray.firstObject.mas_top);
            make.height.equalTo(1);
            make.left.equalTo(self.vLineArray.firstObject);
            make.right.equalTo(self.vLineArray.lastObject);
        }];
    }
    return _xLabelsArray;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}
-(HeFengBaseLabel *)tempLabel{
    if (!_tempLabel) {
        _tempLabel = [HeFengBaseLabel new];
        _tempLabel.hefengFontSize = HeFengFontSize_10;
        _tempLabel.textColor = HeFengColor_FFFFFF;
        _tempLabel.textAlignment = NSTextAlignmentCenter;
        _tempLabel.backgroundColor = HeFengColor_EE8F46;
        _tempLabel.layer.cornerRadius = 5;
        _tempLabel.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner|QMUILayerMaxXMinYCorner|QMUILayerMaxXMaxYCorner;
        _tempLabel.layer.masksToBounds = YES;
        [self.superview addSubview:_tempLabel];
    }
    return _tempLabel;
}

@end
