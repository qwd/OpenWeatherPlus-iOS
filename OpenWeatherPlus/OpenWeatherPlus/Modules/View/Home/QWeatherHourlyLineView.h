//
//  QWeatherHourlyLineView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWeatherHourlyLineImagesView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, QWeatherHourlyLineViewType) {
    QWeatherHourlyLineViewTypeExpense,//付费
    QWeatherHourlyLineViewTypeFree,//免费
};
@interface QWeatherHourlyLineView : UIScrollView

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSMutableArray<QWeatherBaseLabel *> *xLabelsArray;
@property (nonatomic,strong) NSMutableArray<UIView *> *vLineArray;
@property (nonatomic,strong) UIView *xLineView;
@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) QWeatherBaseLabel *tempLabel;
@property (nonatomic,strong) NSArray <Hourly *>* hourlyArray;
@property (nonatomic,strong) QWeatherHourlyLineImagesView *imagesView;
@property (nonatomic,assign) QWeatherHourlyLineViewType viewType;

-(void)reloadViewWithModel:(QWeatherHomeTabelViewDataModel *)model;
@end

NS_ASSUME_NONNULL_END
