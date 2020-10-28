//
//  QWeatherInstructionView.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 QWeather. All rights reserved.
//

#import "QWeatherInstructionView.h"
#import "QWeatherBaseView.h"

@interface QWeatherInstructionView()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) QWeatherBaseLabel *rightLabel;
@property (nonatomic,strong) QWeatherBaseLabel *titleLabel;
@property (nonatomic,strong) QWeatherBaseView *bottomeView;
@end

@implementation QWeatherInstructionView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        //        self.backgroundColor = QWeatherColor_F5F5F5;
    }
    return self;
}
-(void)reloadViewWithModel:(QWeatherHomeTabelViewDataModel *)model{
    self.imageView.image = UIImageMake(@"hefeng_logo");
    
}
-(void)configUI{
    //    self.imageView = [UIImageView new];
    //    [self addSubview: self.imageView];
    //
    //    self.titleLabel = [QWeatherBaseLabel new];
    //    self.titleLabel.hefengFontSize = QWeatherFontSize_12;
    //    self.titleLabel.textColor = QWeatherColor_212121;
    //    self.titleLabel.hefengLocalString = @"hengfengLocalString_29";
    //    [self addSubview:self.titleLabel];
    
    self.rightLabel = [QWeatherBaseLabel new];
    self.rightLabel.hefengFontSize = QWeatherFontSize_10;
    self.rightLabel.textColor = QWeatherColor_7A7A7A;
    self.rightLabel.hefengLocalString = @"hengfengLocalString_30";
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel)];
    [self.rightLabel addGestureRecognizer:tapGesture];
    self.rightLabel.userInteractionEnabled = YES;
    [self addSubview:self.rightLabel];
    
    self.bottomeView = [QWeatherBaseView new];
    self.backgroundColor = QWeatherColor_F7F8FA;
    [self addSubview:self.bottomeView];
}
-(void)clickLabel{
    QWeatherPostNotification(KNotificationOpenSafari, nil);
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(Space_16);
    //        make.top.equalTo(8);
    //        make.height.width.equalTo(32);
    //    }];
    //
    //    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.imageView.mas_right).offset(Space_16);
    //        make.centerY.equalTo(self.imageView);
    //    }];
    //
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-Space_16);
        make.top.equalTo(8);
        make.height.equalTo(32);
    }];
    
    [self.bottomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightLabel.mas_bottom).offset(8);
        make.left.bottom.right.equalTo(0);
        if (IS_NOTCHED_SCREEN) {
            make.height.equalTo(20);
        }else{
            make.height.equalTo(0);
        }
    }];
}
@end
