//
//  HeFengHourlyLineView.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeFengHourlyLineImagesView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, HeFengHourlyLineViewType) {
    HeFengHourlyLineViewTypeExpense,//付费
    HeFengHourlyLineViewTypeFree,//免费
};
@interface HeFengHourlyLineView : UIScrollView

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSMutableArray<HeFengBaseLabel *> *xLabelsArray;
@property (nonatomic,strong) NSMutableArray<UIView *> *vLineArray;
@property (nonatomic,strong) UIView *xLineView;
@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) HeFengBaseLabel *tempLabel;
@property (nonatomic,strong) NSArray <WeatherBaseClassHourly *>* hourlyArray;
@property (nonatomic,strong) HeFengHourlyLineImagesView *imagesView;
@property (nonatomic,assign) HeFengHourlyLineViewType viewType;

-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model;
@end

NS_ASSUME_NONNULL_END
