//
//  HeFengSettingViewController.m
//  OpenWeatherPlus
//
//  Created by he on 2019/3/29.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import "HeFengSettingViewController.h"
#import "HeFengAboutViewController.h"
#import "HeFengCityManagerViewController.h"

@interface HeFengSettingViewController ()
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation HeFengSettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeTextSetting];
    [[HeFengNotificationCenter rac_addObserverForName:KNotificationChangeTextSetting object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self changeTextSetting];
    }];
}
-(void)changeTextSetting{
    self.titleView.titleLabel.font = [HeFengWeatherTool getFontWithFontSize:17];
    self.titleView.title = HeFengLocal(@"hengfengLocalString_13");
}
- (void)initTableView {
    [super initTableView];
    NSMutableArray *dataSourceSectionArray = [NSMutableArray array];
    __block NSInteger identifier = 0;
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *dataSourceRowArray = [NSMutableArray array];
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull title, NSUInteger titleidx, BOOL * _Nonnull stop) {
                QMUIStaticTableViewCellData *cellData = [[QMUIStaticTableViewCellData alloc] init];
                cellData.identifier = identifier;
                cellData.text = title;
                cellData.didSelectTarget = self;
                cellData.didSelectAction = @selector(handleCheckmarkCellEvent:);
                switch (idx) {
                    case 1:
                    {
                        if (titleidx==HeFengWeatherManager.settingModel.languageType) {
                            cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeCheckmark;
                        }else{
                            cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeNone;
                        }
                    }
                        break;
                    case 2:
                    {
                        if (titleidx==HeFengWeatherManager.settingModel.unitType) {
                            cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeCheckmark;
                        }else{
                            cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeNone;
                        }
                    }
                        break;
                    case 3:
                    {
                        if (titleidx==HeFengWeatherManager.settingModel.fontType) {
                            cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeCheckmark;
                        }else{
                            cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeNone;
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
                [dataSourceRowArray addObject:cellData];
                identifier++;
            }];
            [dataSourceSectionArray addObject:dataSourceRowArray];
        }else{
            QMUIStaticTableViewCellData *cellIndicatorData = [[QMUIStaticTableViewCellData alloc] init];
            cellIndicatorData.identifier = identifier;
            cellIndicatorData.text = obj;
            cellIndicatorData.didSelectTarget = self;
            cellIndicatorData.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
            cellIndicatorData.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
            [dataSourceSectionArray addObject:@[cellIndicatorData]];
            identifier++;
        }
    }];
    self.tableView.qmui_staticCellDataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:dataSourceSectionArray];
    self.tableView.backgroundColor =  HeFengColor_ECECEC;
}

- (void)handleDisclosureIndicatorCellEvent:(QMUIStaticTableViewCellData *)cellData {
    if (cellData.identifier==0) {
        [self.navigationController pushViewController:[HeFengCityManagerViewController new] animated:YES];
    }else{
        [self.navigationController pushViewController:[HeFengAboutViewController new] animated:YES];
    }
}

- (void)handleCheckmarkCellEvent:(QMUIStaticTableViewCellData *)cellData {
    if (cellData.accessoryType == QMUIStaticTableViewCellAccessoryTypeCheckmark) {
        return;
    }
    for (QMUIStaticTableViewCellData *data in self.tableView.qmui_staticCellDataSource.cellDataSections[cellData.indexPath.section]) {
        data.accessoryType = QMUIStaticTableViewCellAccessoryTypeNone;
    }
    cellData.accessoryType = QMUIStaticTableViewCellAccessoryTypeCheckmark;
    [HeFengWeatherManager updateSettingWithIndex:cellData.identifier];
    [self.tableView reloadData];
    self.titleView.title = HeFengLocal(@"hengfengLocalString_13");
}
#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = [tableView.qmui_staticCellDataSource cellForRowAtIndexPath:indexPath];
    QMUIStaticTableViewCellData *cellData = [tableView.qmui_staticCellDataSource cellDataAtIndexPath:indexPath];
    cell.textLabel.text = HeFengLocal(cellData.text);
    cell.textLabel.font = [HeFengWeatherTool getFontWithFontSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tintColor = HeFengColor_4CB055;
    if (indexPath.section==0||indexPath.section==4) {
        cell.textLabel.textColor =HeFengColor_4A4A4A;
    }else{
        if (cellData.accessoryType == QMUIStaticTableViewCellAccessoryTypeCheckmark) {
            cell.textLabel.textColor = HeFengColor_4A4A4A;
        }else{
            cell.textLabel.textColor = HeFengColor_A4A4A4;
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return Space_16;
    }else if (section==4){
        return 24;
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    HeFengBaseLabel *label = [HeFengBaseLabel new];
    switch (section) {
        case 1:
            label.hefengLocalString = @"hengfengLocalString_15";
            break;
        case 2:
            label.hefengLocalString = @"hengfengLocalString_19";
            break;
        case 3:
            label.hefengLocalString = @"hengfengLocalString_31";
            break;
        default:
            label.text = @"";
            break;
    }
    label.textColor = HeFengColor_7A7A7A;
    label.hefengFontSize = HeFengFontSize_12;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-8);
        make.left.equalTo(Space_16);
    }];
    return view;
}
- (nullable UIImage *)navigationBarBackgroundImage{
    return [UIImage qmui_imageWithColor:HeFengColor_FAFAFA];
}
- (nullable UIColor *)navigationBarTintColor{
    return HeFengColor_A4A4A4;
}
- (nullable UIColor *)titleViewTintColor{
    return HeFengColor_212121;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray =
        @[
          @"hengfengLocalString_14",
          @[@"hengfengLocalString_16",@"hengfengLocalString_17",@"hengfengLocalString_18"],
          @[@"hengfengLocalString_20",@"hengfengLocalString_21"],
          @[@"hengfengLocalString_22",@"hengfengLocalString_23",@"hengfengLocalString_24"],
          @"hengfengLocalString_25"];
    }
    return _titleArray;
}
@end
