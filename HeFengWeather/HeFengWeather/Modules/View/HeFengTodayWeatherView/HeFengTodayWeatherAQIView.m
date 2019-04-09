//
//  HeFengTodayWeatherAQIView.m
//  HeFengWeather
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengTodayWeatherAQIView.h"

@implementation HeFengTodayWeatherAQIView
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
    titlesArray = @[@"PM2.5",@"PM10",@"SO₂",@"NO₂",@"CO",@"O³"];
    self.line = [UIView new];
    self.line.backgroundColor = HeFengColor_ECECEC;
    [self addSubview:self.line];
    
    self.titleLabel = [HeFengBaseLabel new];
    self.titleLabel.hefengLocalString = @"hengfengLocalString_7";
    self.titleLabel.hefengFontSize = HeFengFontSize_12;
    self.titleLabel.textColor = HeFengColor_4A4A4A;
    [self addSubview:self.titleLabel];
    
    self.aqiBackView = [UIView new];
    kViewRadius(self.aqiBackView, 5);
    [self addSubview:self.aqiBackView];
    
    self.aqiLabel = [HeFengBaseLabel new];
    self.aqiLabel.hefengFontSize = HeFengFontSize_14;
    self.aqiLabel.textColor = HeFengColor_FFFFFF;
    self.aqiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.aqiLabel];
    
    [self itemViewArray];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.right.equalTo(-Space_16);
        make.top.equalTo(0);
        make.height.equalTo(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_16);
        make.top.equalTo(self.line.mas_bottom).offset(Space_24);
    }];
    
    [self.aqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(Space_16);
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.aqiBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.aqiLabel).offset(UIEdgeInsetsMake(0, -5, 0, -5));
    }];
    [self.itemViewArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_32);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Space_24);
    }];
    [self.itemViewArray[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.itemViewArray[0]);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-Space_32);
        make.top.equalTo(self.itemViewArray[0]);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Space_32);
        make.top.equalTo(self.itemViewArray[0].mas_bottom).offset(Space_24);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.itemViewArray[0].mas_bottom).offset(Space_24);
        make.height.width.equalTo(self.itemViewArray[0]);
    }];
    [self.itemViewArray[5] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-Space_32);
        make.top.equalTo(self.itemViewArray[0].mas_bottom).offset(Space_24);
        make.height.width.equalTo(self.itemViewArray[0]);
        make.bottom.equalTo(-Space_16);
    }];
}
-(void)reloadViewWithModel:(HeFengHomeTabelViewDataModel *)model{
    NSArray *numbArray;
    if (!model.airDataModel.air_now_city.pm25) {
        numbArray = @[@"",@"",@"",@"",@"",@""];
        self.aqiLabel.text = @"";
        self.aqiBackView.backgroundColor = KClearColor;
    }else{
        numbArray  = @[model.airDataModel.air_now_city.pm25,
                       model.airDataModel.air_now_city.pm10,
                       model.airDataModel.air_now_city.so2,
                       model.airDataModel.air_now_city.no2,
                       model.airDataModel.air_now_city.co,
                       model.airDataModel.air_now_city.o3];
        self.aqiLabel.text = HeFengStringFormat(@"%@ %@",model.airDataModel.air_now_city.aqi,model.airDataModel.air_now_city.qlty);
        self.aqiBackView.backgroundColor = [HeFengWeatherTool getAqiColorWithString:model.airDataModel.air_now_city.aqi];
    }
    [self.itemViewArray enumerateObjectsUsingBlock:^(HeFengBaseLabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:HeFengStringFormat(@"%@ %@",self->titlesArray[idx],numbArray[idx])];
        text.yy_color = HeFengColor_4A4A4A;
        [text yy_setColor:HeFengColor_A4A4A4 range:[HeFengStringFormat(@"%@ %@",self->titlesArray[idx],@"0") rangeOfString:self->titlesArray[idx]]];
        obj.attributedText = text;
    }];
    self.hidden = NO;
    
}
-(NSMutableArray<HeFengBaseLabel *> *)itemViewArray{
    if (!_itemViewArray) {
        _itemViewArray = [NSMutableArray array];
        for (int i = 0; i<6; i++) {
            HeFengBaseLabel *label = [HeFengBaseLabel new];
            label.text = @"";
            label.hefengFontSize = 14;
            [self addSubview:label];
            [_itemViewArray addObject:label];
        }
    }
    return _itemViewArray;
}
@end
