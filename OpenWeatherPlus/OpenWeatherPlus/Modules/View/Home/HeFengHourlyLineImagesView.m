//
//  HeFengHourlyLineImagesView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/4/1.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengHourlyLineImagesView.h"

@implementation HeFengHourlyLineImagesView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(void)reloadViewWithModelArray:(NSArray<WeatherBaseClassHourly*> *)array{
    NSMutableArray<NSMutableArray<WeatherBaseClassHourly*>*> *viewDataArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(WeatherBaseClassHourly * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!HeFengStrEqual(viewDataArray.lastObject.lastObject.cond_code, obj.cond_code)||[self isDaySpaceWithStr:obj.time]!=0) {
            NSMutableArray *modelArray = [NSMutableArray array];
            [modelArray addObject:obj];
            [viewDataArray addObject:modelArray];
        }else{
            [viewDataArray.lastObject addObject:obj];
        }
    }];
    [viewDataArray enumerateObjectsUsingBlock:^(NSMutableArray<WeatherBaseClassHourly *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HeFengHourlyImageView *imageView = [HeFengHourlyImageView new];
        if ([self isDaySpaceWithStr:obj.firstObject.time]==1) {
            imageView.imageView.image = [HeFengWeatherTool getWeatherImageWithWeatherCode: obj.firstObject.cond_code isDay:NO formatString:HeFengWeatherImageFormatString];
        }else if ([self isDaySpaceWithStr:obj.firstObject.time]==2)
        {
            imageView.imageView.image = [HeFengWeatherTool getWeatherImageWithWeatherCode: obj.firstObject.cond_code isDay:YES formatString:HeFengWeatherImageFormatString];
        }else{
            imageView.imageView.image = [HeFengWeatherTool getWeatherImageWithWeatherCode: obj.firstObject.cond_code date:obj.firstObject.time formatString:HeFengWeatherImageFormatString];
            
        }
        if (idx==viewDataArray.count-1) {
            imageView.progress = obj.count-1;
        }else{
            imageView.progress = obj.count;
        }
        [self addSubview:imageView];
        [self.imageViewArray addObject:imageView];
    }];
    [self.imageViewArray enumerateObjectsUsingBlock:^(HeFengHourlyImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            obj.frame = CGRectMake(0,0,self.qmui_width/24.0*obj.progress,self.qmui_height);
        }else
        {
            obj.frame = CGRectMake(self.imageViewArray[idx-1].qmui_right, 0,self.qmui_width/24.0*obj.progress,self.qmui_height);
        }
        self.imageViewArray.lastObject.vlineLayer.hidden = YES;
    }];
}
-(NSInteger)isDaySpaceWithStr:(NSString*)str{
    NSInteger  hour = [NSDate dateWithString:str formatString:HeFengFormatString1].hour;
    if (hour==20) {
        return 1;
    }
    if (hour==8) {
        return 2;
    }
    else{
        return 0;
    }
}
-(NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}
@end
