//
//  HeFengHourlyLineImagesView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/4/1.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengBaseView.h"
#import "HeFengHourlyImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengHourlyLineImagesView : HeFengBaseView
@property (nonatomic,strong) NSMutableArray<HeFengHourlyImageView *> *imageViewArray;
-(void)reloadViewWithModelArray:(NSArray<WeatherBaseClassHourly*> *)array;

@end

NS_ASSUME_NONNULL_END
