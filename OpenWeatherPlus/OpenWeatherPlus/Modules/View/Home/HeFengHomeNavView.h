//
//  HeFengHomeNavView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeFengBaseButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeFengHomeNavView : UIImageView
@property (nonatomic,strong) UIButton *menuButton;
@property (nonatomic,strong) HeFengBaseButton *locationTitleButton;
@property (nonatomic,strong) UIButton *locationButton;
@property (nonatomic,strong) UIButton *locationAddButton;
@property (nonatomic,strong) UIPageControl *pageControl;
-(void)setPage:(NSInteger)page;
@end
NS_ASSUME_NONNULL_END
