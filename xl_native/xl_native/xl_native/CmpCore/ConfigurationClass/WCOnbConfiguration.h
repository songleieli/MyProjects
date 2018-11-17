#import <Foundation/Foundation.h>
#import "IObjcJsonBase.h"
#import "WCBaseConfiguration.h"
//===================================================================================================================================================

#pragma mark - 自定义配置文件管理器
@interface WCOnbConfiguration : WCBaseConfiguration

@property (nonatomic, strong) NSString  *appstorepath;
@property (nonatomic, strong) NSString *resourceBundleName;
@property (nonatomic, strong) NSString *loginViewController;        //登录视图管理器名称
@property (nonatomic, strong) NSString *rootViewController;         //登录视图管理器名称
@property (nonatomic, strong) NSString *startAppDelegate;           //启动appDelegate字段

@end
//===================================================================================================================================================
