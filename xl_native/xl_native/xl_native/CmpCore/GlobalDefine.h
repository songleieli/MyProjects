//
//  CommonDefine.h
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define IsIPad                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsIos7Up                ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IsIos10Up                ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define iphone4x_3_5            ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iphone5x_4_0            ([UIScreen mainScreen].bounds.size.height==568.0f)
#define iphone6x_4_7            ([UIScreen mainScreen].bounds.size.height==667.0f)
#define iphone6px_5_5           ([UIScreen mainScreen].bounds.size.height==736.0f)

#define kSYSTEM_VERSION_iOS10Later [[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] integerValue] >= 10

#define kWeakSelf(self)  __weak __typeof(&*self)weakSelf = self;


#define AppVersion              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight            [UIScreen mainScreen].bounds.size.height
#define ApplicationHeight       [UIScreen mainScreen].applicationFrame.size.height


#define kNavBarHeight_New_test           (xlIsIPhoneX?35:0)



#define Size(w, h)                          CGSizeMake(w, h)  //设置size
#define Point(x, y)                         CGPointMake(x, y) //设置point

#define ViewWidth(v)                        v.frame.size.width //获取view的 width
#define ViewHeight(v)                       v.frame.size.height//获取view的 height
#define ViewX(v)                            v.frame.origin.x//获取view的 x
#define ViewY(v)                            v.frame.origin.y//获取view的 y

#define RectX(f)                            f.origin.x //获取frame的 x
#define RectY(f)                            f.origin.y //获取frame的 y

#define RectWidth(f)                        f.size.width //获取frame的 width

#define RectHeight(f)                       f.size.height //获取frame的 height

#define zTabBarBgImgHeight1080      231*ScreenWidth/1080
#define zTabBarHeight1080           zTabBarBgImgHeight1080 - zTabBarBgImgHeight1080 - 83*zTabBarBgImgHeight1080/231

#define isIPhoneXAll ([[UIApplication sharedApplication] statusBarFrame].size.height == 44)

#define kNavBarHeight_New           (isIPhoneXAll?88:64)
#define kTabBarHeight_New           (isIPhoneXAll?83:49)
#define KViewStartTopOffset_New      (isIPhoneXAll?-44.0f:-20.0f)
#define KTabBarHeightOffset_New      (isIPhoneXAll?34.0:0.0f)

#define KStatusBarHeight_New        (isIPhoneXAll?44.0f:20.0f)


/*
 *乐家慧定义一些常用数字
 */
#define mycommonEdge             36  //view的左右边距 1080标准
#define tableViewEdge            30  //tableView的左右编剧 1080标准
#define mylableSize              42 //常用字体大小 1080标准
#define zmjjtablecelldistance    30 //tablecell的间距  1080标准






//总高度
//#define TotalHeight             (IsIos7Up?ScreenHeight:ApplicationHeight)

//默认数据库
#define UserDefaults            [NSUserDefaults standardUserDefaults]


/*
 定义全局的NSUserDefault Key
 */
#define LJH_ACCOUNT_USER_HASLOGIN                       @"LJH_ACCOUNT_USER_HASLOGIN"
#define LJH_ACCOUNT_USER_HASHIDE_MYWALLET_BLANCE        @"LJH_ACCOUNT_USER_HASHIDE_MYWALLET_BLANCE"

#define JR_ACCOUNT_USER_HASTGTFAIL        @"JR_ACCOUNT_USER_HASTGTFAIL"
#define JR_ACCOUNT_USER_LOGINFROMWEB      @"JR_ACCOUNT_USER_LOGINFROMWEB"
#define JR_ACCOUNT_USER_hasloadHsop      @"JR_ACCOUNT_USER_hasloadHsop"
#define JR_ACCOUNT_USER_SESSIONID       @"JR_ACCOUNT_USER_SESSIONID"
#define JR_ACCOUNT_USER_USERNAME        @"JR_ACCOUNT_USER_USERNAME"
#define INFO_IS_NOT_FIRST_USER          @"INFO_IS_NOT_FIRST_USER"



#define JR_APP_USER_HASACCOUNT_CLICK    @"JR_APP_USER_HASACCOUNT_CLICK"
#define JR_APP_USER_HASMAIN_CLICK       @"JR_APP_USER_HASMAIN_CLICK"
#define JR_APP_USER_HASMANAGE_CLICK     @"JR_APP_USER_HASMANAGE_CLICK"


#define JR_APP_USER_LOIGNINFO             @"JR_APP_USER_LOIGNINFO"
#define JR_APP_USER_APP_USER_ACCOUNT      @"JR_APP_USER_APP_USER_ACCOUNT"

#define JR_APP_USER_APP_USER_COMMUNITY              @"JR_APP_USER_APP_USER_COMMUNITY"  //登录关注小区
#define JR_APP_USER_APP_USER_COMMUNITY_NOLOGIN      @"JR_APP_USER_APP_USER_COMMUNITY_NOLOGIN"   //未登录关注小区
#define lj_APP_USER_APP_USER_ACTIVITY_STARTTIME     @"lj_APP_USER_APP_USER_ACTIVITY_STARTTIME"//活动开始时间
#define lj_APP_USER_APP_USER_ACTIVITY_ENDTIME       @"lj_APP_USER_APP_USER_ACTIVITY_ENDTIME"
#define lj_APP_USER_APP_USER_PayProperty_ENDTIME    @"lj_APP_USER_APP_USER_PayProperty_ENDTIME"//物业缴费的结束时间
#define zmjj_APP_USER_SERCHHISTORY                  @"zmjj_APP_USER_SERCHHISTORY"  //乐家慧搜索历史
/*
 *乐家慧用户信息定义
 */
#define ZJ_APP_USER_LOIGNINFO                   @"ZJ_APP_USER_LOIGNINFO"
#define ZJ_APP_USER_MOBIL                       @"ZJ_APP_USER_MOBIL"
#define ZJ_APP_USER_HSHOP                       @"ZJ_APP_USER_HSHOP"
#define ZJ_APP_USER_CURR_COMMUNOTYINFO          @"ZJ_APP_USER_CURR_COMMUNOTYINFO"
#define ZJ_APP_USER_COMMUNOTY_LIST              @"ZJ_APP_USER_COMMUNOTY_LIST"
#define ZJ_APP_MSG_DELEGAT_LIST                 @"ZJ_APP_MSG_DELEGAT_LIST"
#define ZJ_APP_READ_CHECK_TAGS                  @"ZJ_APP_READ_CHECK_TAGS"  //抄表关键字
#define ZJ_APP_READ_MATERIAL_TAGS               @"ZJ_APP_READ_MATERIAL_TAGS"
#define ZJ_APP_SHOUKUAN_TAGS                    @"ZJ_APP_SHOUKUAN_TAGS"  //收款关键字


/*
 *我爱我乡Bd端
 */
#define TB_APP_USER_LOIGNINFO                   @"TB_APP_USER_LOIGNINFO"






#define DefaultHttpMethod       @"POST"//默认的http请求方式，如果POST用的多就设为POST
#define jrd_area                @"area.txt"//地区
#define jrd_areaUrl             @"areaUrl"//地区下载地址
#define jrd_areaVersion         @"areaVersion"//地址版本号
#define jrd_areaNewVersion      @"areaNewVersion"//新地址版本号

//#define jrd_userName            @"userName"
#define jrd_userPsd             @"userPsd"
//#define jrd_userId              @"userId"//用户ID
#define jrd_uuid                @"uuid"//uuid
#define jrd_userLogo            @"userLogo"//用户头像
#define jrd_sessionId           @"sessionId"//sessionId

#define jrd_platform            @"4"//平台类型, 3：Android；4：ios

#define jrd_selectedCardNum     @"selectedCardNum"//默认card

#define jrd_adActivityType      @"adActivityType"//广告类型
#define jrd_adID                @"adID"//广告ID
#define jrd_adTitle             @"adTitle"//广告名称
#define jrd_adPic               @"adPic"//广告图片地址

#define jrd_appUsed             @"appUsed"//已使用过

#define jrd_latitude            @"latitude"//纬度
#define jrd_longitude           @"longitude"//经度
#define jrd_provinceName        @"provinceName"//省
#define jrd_cityName            @"cityName"//市

#define jrd_appServiceVersion   @"appServiceVersion"//app服务器记录的最新版本
#define jrd_appUrl              @"appUrl"//app下载地址
#define jrd_appMustUpdate       @"appMustUpdate"//是否强制更新

//存储文件数据
#define jrd_mainScrolAd         @"mainScrolAd.txt"//闪购滚动广告

#define jrd_firstRun            @"firstRun" //第一次启动

#define jrd_unreadXiaoNengMessageCount   @"unreadXiaoNengMessageCount" //小能未读消息数


#define defaultBgColor          [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]//F3F3F3


/*
 定义全局的颜色值 乐家慧
 */
#define defaultLightColor       [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1]//A6A6A6
#define defaultDarkColor        [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1]//565656
#define defaultBlackColor       [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define defaultRedColor         [UIColor colorWithRed:240/255.0 green:89/255.0 blue:130/255.0 alpha:1]//F05982
#define defaultBlueColor        [UIColor colorWithRed:14/255.0 green:155/255.0 blue:227/255.0 alpha:1]//0E9BE3
#define defaultBlueDarkColor    [UIColor colorWithRed:0/255.0 green:99/255.0 blue:172/255.0 alpha:1]//0063AC


#define defaultLineColor        [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]
#define defaultLineLightColor   [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]
#define defaultHeadColor        [UIColor colorWithRed:255/255.0 green:104/255.0 blue:104/255.0 alpha:1]






//#define defaultJawBgColor          RGBFromColor(0xe2e8f3)//背景色


#define defaultJawBgColor          RGBFromColor(0xf0f0f0)//背景色
/*
 定义全局的颜色值 乐家慧
 */
//#define defaultBgColor          [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]//F3F3F3
#define defaultZjBlueColor       [UIColor colorWithRed:70/255.0 green:136/255.0 blue:241/255.0 alpha:1]
#define defaultZjBgColor       [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]
#define defaultZjTopScrollBarSelectColor         [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
#define defaultZjTopScrollBarUnSelectColor       [UIColor colorWithRed:183/255.0 green:219/255.0 blue:253/255.0 alpha:1]
#define defaultZJLineColor       [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1]
#define defaultZJGrayColor       [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1]
#define defaultZJDarkColor       [UIColor colorWithRed:37/255.0 green:37/255.0 blue:37/255.0 alpha:1]


/*
 待删除颜色
 */
#define defaultMainColor        RGBFromColor(0x0972da)//主色
#define SubtitleColor          RGBFromColor(0x8e8e8e)//副标题 灰色
#define NavLableColor           RGBFromColor(0x545454)//导航栏字体颜色灰色 灰色


/*
 *全新定义我爱我乡主题颜色，用于以后更换皮肤，其他的全局定义，慢慢删除
 */

//rgba颜色值
#define RGBAlphaColor(R, G, B, A) \
[UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:(A)]

//16进制颜色值
#define RGBFromColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define XLColorMainPart             RGBFromColor(0xff611c)   //主体色
#define XLColorAuxiliaryOrange      RGBFromColor(0xf47472)   //辅助橘黄色
#define XLColorAuxiliaryRed         RGBFromColor(0xfc4545)   //辅助红色
#define XLColorAuxiliaryGreen       RGBFromColor(0x84bc39)   //辅助色绿
#define XLColorMainLableAndTitle    RGBFromColor(0x333333)   //标题色，正文色
#define XLColorMainClassTwoTitle    RGBFromColor(0x666666)   //二级标题色
#define XLColorTitleTip             RGBFromColor(0xc4c4c4)   //注释,提示文字色
#define XLColorCutLine              RGBFromColor(0xe1e1e1)   //分割线
#define XLColorBackgroundColor    RGBFromColor(0xf2f2f2)   //默认背景颜色

/*
 *我爱我乡，通知定义
 */

#define NSNotificationXLVoiceResultPushVC       @"NSNotificationXLVoiceResultPushVC"   //一呼即有，语音识别完成通知
#define NSNotificationUserLoginSuccess          @"NSNotificationUserLoginSuccess"       //登录成功
#define NSNotificationPublishState              @"NSNotificationPublishState"






/**
 正则表达
 */
#pragma mark - 正则表达
//判断邮箱是否规则
#define IsValidEmail(email)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"] evaluateWithObject:email]

//判断电话号码是否规则
#define IsValidPhoneNum(phoneNum)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(13|14|15|17|18)\\d{9}$"] evaluateWithObject:[NSString stringWithFormat:@"%@",phoneNum]]

//判断是否是汉子姓名
#define IsChaneseName(phoneNum)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\u4e00-\u9fa5]{1,}$"] evaluateWithObject:[NSString stringWithFormat:@"%@",phoneNum]]


//[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1\\d{10}$"] evaluateWithObject:[NSString stringWithFormat:@"%@",phoneNum]] 手机号验证一位 1 后面十位数字

//判断是否为整数
#define IsMoneyInt(money)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[1-9][0-9]{0,9}$"] evaluateWithObject:[NSString stringWithFormat:@"%@",money]]

//判断是否为有效数
#define IsMoneyDouble(money)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^([1-9][0-9]*|[0]{1})[.]{1}[0-9]{0,2}$"] evaluateWithObject:[NSString stringWithFormat:@"%@",money]]

#define IsMoneyInput(money)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^([1-9][0-9]*|0).?[0-9]{0,2}?$"] evaluateWithObject:[NSString stringWithFormat:@"%@",money]]

#define IsMoneyErrorInput(money)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(0[0-9]+)[^A-Za-z0-9.]*$"] evaluateWithObject:[NSString stringWithFormat:@"%@",money]]

//判断是否为链接
#define IsValidUrl(url)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(http|https)://([\\w-]+.)+[\\w-]+(/[\\w-./?%&=]*)?$"] evaluateWithObject:url]

//判断用户名是否规则
#define IsValidUserName(userName)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z][a-zA-Z0-9_]{1,17}$"] evaluateWithObject:userName]

//判断用户密码是否规则  数字+字母组合 长度6-20
#define IsValidUserPwd(pwd)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$"] evaluateWithObject:pwd]

//判断是否包含数字
#define IsContainNum(str)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@".*\\d+.*"] evaluateWithObject:str]


//判断文件名是否规则
#define IsValidFileName(fileName)\
[fileName rangeOfString:@"\\"].length ? NO : [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^*[^?<>:/\"|*]*$"] evaluateWithObject:fileName]

//自定义
#define IsValidText(text,matches)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", matches] evaluateWithObject:text]

