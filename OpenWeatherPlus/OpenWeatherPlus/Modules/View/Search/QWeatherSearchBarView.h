//
//  QWeatherSearchBarView.h
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherBaseView.h"
#import "QWeatherBaseTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface QWeatherSearchBarView : QWeatherBaseView
@property (nonatomic,strong) QWeatherBaseTextField *searchTextField;
@end

NS_ASSUME_NONNULL_END
