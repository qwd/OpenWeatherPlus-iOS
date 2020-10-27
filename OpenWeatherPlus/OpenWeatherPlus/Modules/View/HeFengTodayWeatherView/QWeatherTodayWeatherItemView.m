//
//  QWeatherTodayWeatherItemView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherTodayWeatherItemView.h"

@implementation QWeatherTodayWeatherItemView
{
    NSArray *titlesArray;

}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    titlesArray = @[@"hengfengLocalString_34",@"hengfengLocalString_35",@"hengfengLocalString_2",@"hengfengLocalString_3",@"hengfengLocalString_4",@"hengfengLocalString_5",@"hengfengLocalString_6"];
    self.imageView = [UIImageView new];
    [self addSubview:self.imageView];
    
    self.titleLabel = [QWeatherBaseLabel new];
    self.titleLabel.hefengFontSize = QWeatherFontSize_14;
    self.titleLabel.textColor = QWeatherColor_A4A4A4;
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [QWeatherBaseLabel new];
    self.contentLabel.hefengFontSize = QWeatherFontSize_14;
    self.contentLabel.textColor = QWeatherColor_4A4A4A;
    [self addSubview:self.contentLabel];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.centerY.equalTo(0);
        make.width.height.equalTo(20);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(8);
        make.centerY.equalTo(0);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(8);
        make.centerY.equalTo(0);
    }];
}
- (void)setIdx:(NSInteger)idx{
    _idx = idx;
    self.titleLabel.hefengLocalString = titlesArray[idx];
    self.imageView.image = UIImageMake(QWeatherStringFormat(@"todayItem_%ld",(long)idx));
}
-(void)reloadViewWithModel:(QWeatherHomeTabelViewDataModel *)model{
    switch (_idx) {
        case 0:
            self.contentLabel.hefengTempString = model.daily.firstObject.tempMax;
            self.imageView.image = [QWeatherTool getWeatherImageWithWeatherCode:model.daily.firstObject.iconDay isDay:YES formatString:QWeatherImageFormatString];
            break;
        case 1:
            self.contentLabel.hefengTempString = model.daily.firstObject.tempMin;
            self.imageView.image = [QWeatherTool getWeatherImageWithWeatherCode:model.daily.firstObject.iconNight isDay:NO formatString:QWeatherImageFormatString];
            break;
        case 2:
            self.contentLabel.text = QWeatherStringFormat(@"%@mm",model.now.precip);
            break;
        case 3:
            self.contentLabel.text = QWeatherStringFormat(@"%@%%",model.now.humidity);
            break;
        case 4:
            self.contentLabel.text = QWeatherStringFormat(@"%@HPA",model.now.pressure);
            break;
        case 5:
            self.contentLabel.text = QWeatherStringFormat(@"%@KM",model.now.vis);
            break;
        case 6:
            self.titleLabel.text = QWeatherStringFormat(@"%@",model.now.windDir);
            self.contentLabel.text = QWeatherStringFormat(@"%@%@",model.now.windScale,QWeatherLocal(@"hengfengLocalString_32"));
            break;

        default:
            break;
    }
}
@end
