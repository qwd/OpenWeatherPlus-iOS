//
//  QWeatherHomeCollectionViewCell.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWeatherHomeScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherHomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) QWeatherHomeScrollView *scrollView;
@end

NS_ASSUME_NONNULL_END
