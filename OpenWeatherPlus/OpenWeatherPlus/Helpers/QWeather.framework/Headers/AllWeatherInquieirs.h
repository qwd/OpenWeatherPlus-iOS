//
//  AllWeatherInquieirs.h
//  QWeather
//
//  Created by Coder on 2018/4/29.
//  Copyright © 2018年 Song. All rights reserved.
//

#define QWeatherConfigInstance [AllWeatherInquieirs sharedInstance]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, APP_TYPE) {
    APP_TYPE_BIZ = 1,// 付费用户
    APP_TYPE_DEV = 2,// 普通用户
};

typedef NS_ENUM(NSInteger, INQUIRE_TYPE) {
    INQUIRE_TYPE_WEATHER_NOW = 1,//实况天气
    INQUIRE_TYPE_WEATHER_3D,//3天预报
    INQUIRE_TYPE_WEATHER_7D,//7天预报
    INQUIRE_TYPE_WEATHER_10D,//10天预报
    INQUIRE_TYPE_WEATHER_15D,//15天预报
    INQUIRE_TYPE_WEATHER_24H,//24小时预报
    INQUIRE_TYPE_WEATHER_72H,//72小时预报
    INQUIRE_TYPE_WEATHER_168H,//168小时预报
    INQUIRE_TYPE_WEATHER_MINUTELY,// 分钟级降雨（邻近预报）
    INQUIRE_TYPE_WEATHER_AIR_NOW,//空气质量实况
    INQUIRE_TYPE_WEATHER_AIR_5D,//空气质量5天预报
    INQUIRE_TYPE_WARNING,// 天气灾害预警
    INQUIRE_TYPE_WARNINGLIST,//天气灾害预警城市列表
    INQUIRE_TYPE_INDICES_1D,// 当天生活指数
    INQUIRE_TYPE_INDICES_3D,// 3天生活指数
    INQUIRE_TYPE_WEATHER_POI_NOW,//景点实况天气
    INQUIRE_TYPE_WEATHER_POI_7D,//景点7天预报
    INQUIRE_TYPE_HISTORICAL_WEATHER,// 历史天气
    INQUIRE_TYPE_HISTORICAL_AIR,//历史空气质量
    INQUIRE_TYPE_SUNMOON,//太阳和月亮
    INQUIRE_TYPE_GEO_CITY_LOOKUP,//城市查询
    INQUIRE_TYPE_GEO_TOPCITY,//热门城市查询
    INQUIRE_TYPE_GEO_POI_LOOKUP,//POI搜索
    INQUIRE_TYPE_GEO_POI_RANGE,//POI范围搜索
};

typedef NS_ENUM(NSInteger, LANGUAGE_TYPE) {
    LANGUAGE_TYPE_ZH = 0,// 简体中文
    LANGUAGE_TYPE_ZHHANT = 1,// 繁体中文
    LANGUAGE_TYPE_EN = 2,// 英文
    LANGUAGE_TYPE_DE = 3,// 德语
    LANGUAGE_TYPE_ES = 4,// 西班牙语
    LANGUAGE_TYPE_FR = 5,// 法语
    LANGUAGE_TYPE_IT = 6,// 意大利语
    LANGUAGE_TYPE_JP = 7,// 日语
    LANGUAGE_TYPE_KR = 8,// 韩语
    LANGUAGE_TYPE_RU = 9,// 俄语
    LANGUAGE_TYPE_IN = 10,// 印度语
    LANGUAGE_TYPE_TH = 11,// 泰语
    LANGUAGE_TYPE_AR = 12,//阿拉伯语
    LANGUAGE_TYPE_PT = 13,//葡萄牙语
    LANGUAGE_TYPE_BN = 14,//孟加拉语
    LANGUAGE_TYPE_MS = 15,//马来语
    LANGUAGE_TYPE_NL = 16,//荷兰语
    LANGUAGE_TYPE_EL = 17,//希腊语
    LANGUAGE_TYPE_LA = 18,//拉丁语
    LANGUAGE_TYPE_SV = 19,//瑞典语
    LANGUAGE_TYPE_ID = 20,//印尼语
    LANGUAGE_TYPE_PL = 21,//波兰语
    LANGUAGE_TYPE_TR = 22,//土耳其语
    LANGUAGE_TYPE_CS = 23,//捷克语
    LANGUAGE_TYPE_ET = 24,//爱沙尼亚语
    LANGUAGE_TYPE_VI = 25,//越南语
    LANGUAGE_TYPE_FIL = 26,//菲律宾语
    LANGUAGE_TYPE_FI = 27,//芬兰语
    LANGUAGE_TYPE_HE = 28,//希伯来语
    LANGUAGE_TYPE_IS = 29,//冰岛语
    LANGUAGE_TYPE_NB = 30,//挪威语
};

typedef NS_ENUM(NSInteger, UNIT_TYPE) {
    UNIT_TYPE_M = 0,// 公制
    UNIT_TYPE_I = 1,// 英制
};

typedef NS_ENUM(NSInteger, INDICES_TYPE) {
    INDICES_TYPE_all = 0,//全部生活指数
    INDICES_TYPE_spt = 1 ,//运动指数
    INDICES_TYPE_cw = 2 ,//洗车指数
    INDICES_TYPE_drsg = 3 ,//穿衣指数
    INDICES_TYPE_fis = 4,//钓鱼指数
    INDICES_TYPE_uv = 5 ,//紫外线指数
    INDICES_TYPE_trav = 6 ,//旅游指数
    INDICES_TYPE_comf = 8 ,//舒适度指数
    INDICES_TYPE_ag = 7 ,//花粉过敏指数
    INDICES_TYPE_flu = 9 ,//感冒指数
    INDICES_TYPE_ap = 10 ,//空气污染扩散条件指数
    INDICES_TYPE_ac = 11 ,//空调开启指数
    INDICES_TYPE_gl = 12 ,//太阳镜指数
    INDICES_TYPE_mu = 13,//化妆指数
    INDICES_TYPE_dc = 14,//晾晒指数
    INDICES_TYPE_ptfc = 15,//交通指数
    INDICES_TYPE_spi = 16,//防晒指数
    INDICES_TYPE_ski = 17,//滑雪指数
};
 
UIKIT_EXTERN NSString * const INDICES_TYPESTRING[];
typedef NS_ENUM(NSInteger, SERCHMODE_TYPE) {
    SERCHMODE_TYPE_EXACT= 0,//精准查询
    SERCHMODE_TYPE_FUZZY = 1,//模糊搜索
};
@interface AllWeatherInquieirs : NSObject

#pragma mark -  请在 AppDelegate 中填写

/**
 用户ID，登录控制台可查看
 必填
 */

@property (nonatomic, copy) NSString *publicID;

/**
 用户认证key，登录控制台可查看
 必填
 */

@property (nonatomic, copy) NSString *appKey;

/**
 请求超时时间，默认30秒
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/** 根据接口需要填写 必填项 选填项 */

#pragma mark - 必选参数

/**
 用户类型，分为 付费用户 普通用户
 必选
 */

@property (nonatomic, assign) APP_TYPE appType;

/**
 需要查询的城市或地区，可输入以下值：
 1. 城市ID：城市列表
 2. 经纬度格式：经度,纬度（经度在前纬度在后，英文,分隔，十进制格式，北纬东经为正，南纬西经为负
 3. 城市名称，支持中英文和汉语拼音
 4. 城市名称，上级城市 或 省 或 国家，英文,分隔，此方式可以在重名的情况下只获取想要的地区的天气数据，例如 西安,陕西
 5. IP
 6. 根据请求自动判断，根据用户的请求获取IP，通过 IP 定位并获取城市数据
 7. 可为空，系统自动获取当前设备所在经纬度，然后将获取到的经纬度作为location参数调用传location的接口
 */

@property (nonatomic, copy) NSString *location;

/**
 选择获取历史的日期限度，最多可选择最近10天的数据，例如今天是7月5日，最多可获取6月25日至7月4日的历史数据。日期格式为yyyyMMdd，例如 date=20200531
 必选
 */

@property (nonatomic, copy) NSString *date;

/**
 查询时间，格式为HHmm，24 时制
 必选
 */

@property (nonatomic, copy) NSString *time;

/**
 查询地区所在时区
 必选
 */

@property (nonatomic, copy) NSString *tz;

/**
 所查询地区的纬度
 纬度采用十进制格式，北纬为正，南纬为负
 必选
 */

@property (nonatomic, copy) NSString *lat;

/**
 所查询地区的经度
 经度采用十进制格式，东经为正，西经为负
 */

@property (nonatomic, copy) NSString *lon;

/**
 海拔高度，单位为米
 必选
 */

@property (nonatomic, copy) NSString *alt;

#pragma mark - 可选参数

/**
 多语言，可以不使用该参数，默认为简体中文
 详见多语言参数
 参数若不传，则默认传"zh"
 可选
 */

@property (nonatomic, copy) NSString *lang;

@property (nonatomic, assign) LANGUAGE_TYPE languageType;

/**
 单位选择，公制（m）或英制（i），默认为公制单位
 详见度量衡单位参数
 若不传，则默认传"m"
 可选
 */

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) UNIT_TYPE unitType;

/**
 生活指数数据类型，包括洗车指数、穿衣指数、钓鱼指数等。可以一次性获取多个类型的生活指数.
 indices内 放入需要的INDICES_TYPESTRING类型，默认indices = @[INDICES_TYPESTRING[INDICES_TYPE_comf]]
 
 具体生活指数的类型参数值如下：
 */
@property (nonatomic, strong) NSArray *indices;

/**
选择POI所在城市，可设定只搜索在特定城市内的POI信息。城市名称可以是中文、英文或城市的LocationID。默认全世界范围。
城市名称需要精准匹配，建议使用LocaitonID，如城市名称无法识别，则数据返回为空。
*/
@property (nonatomic,copy) NSString *city;
/**
POI类型，可选择搜索某一类型的POI，目前仅限景点。例如type=scenic
*/
@property (nonatomic,copy) NSString *type;
/**
POI类型，搜索范围，可设置搜索半径，取值范围1-50，单位：公里。默认5公里。
*/
@property (nonatomic,copy) NSString *radius;
/**
 查询灾害预警列表选择指定的国家，目前仅支持中国。例如range=cn。
 查询热门城市范围，默认全球范围。 可选择某个国家范围内的热门城市，国家名称需使用ISO 3166 所定义的国家代码。
 world 全球城市范围，默认
 cn 中国城市范围，可替换为其他国家的 ISO 3166 国家代码，例如range=cn
 */

@property (nonatomic, copy) NSString *range;

/**
 查询方式(城市搜索专用属性)
 可选值:模糊检索(fuzzy)、精准检索(exact)
 默认:mode = SERCHMODE_TYPE_EXACT
 可选
 */

@property (nonatomic, assign) SERCHMODE_TYPE mode;

/**
 搜索查询返回的数量
 默认返回20个与查询城市或的确相关性最强的结果，可选1-50个，当使用IP地址或坐标查询时，仅返回一个结果
 默认:number=@"20"
 可选
 */

@property (nonatomic, copy) NSString *number;

#pragma mark - Init

+ (instancetype)sharedInstance;

- (instancetype)init;

#pragma mark - Inquire Action

/**
 查询类型 INQUIRE_TYPE 必填
 根据 type 类型进行对应接口查询
 */

- (void)weatherWithInquireType:(INQUIRE_TYPE)inquireType
                   WithSuccess:(void(^)(id responseObject))getSuccess
              faileureForError:(void(^)(NSError *error))getError;

/**
 修改域名
 
 @param domain 访问域名字符串，默认： 付费为https://api.QWeather.net 免费为https://devapi.QWeather.net
 */
-(void)changeDomain:(NSString *)domain;
@end
