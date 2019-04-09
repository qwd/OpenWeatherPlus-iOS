//
//  HeFengCityManagerCell.h
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeFengCityManagerCell : UITableViewCell
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) HeFengBaseLabel *titleLabel;
@property (nonatomic,strong) UIButton *delButton;
@end

NS_ASSUME_NONNULL_END
