//
//  QWeatherHourlyLineImagesView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/4/1.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"
#import "QWeatherHourlyImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherHourlyLineImagesView : QWeatherBaseView
@property (nonatomic,strong) NSMutableArray<QWeatherHourlyImageView *> *imageViewArray;
-(void)reloadViewWithModelArray:(NSArray<Hourly*> *)array;

@end

NS_ASSUME_NONNULL_END
