//
//  HeFengHomeCollectionViewCell.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeFengHomeScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengHomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) HeFengHomeScrollView *scrollView;
@end

NS_ASSUME_NONNULL_END
