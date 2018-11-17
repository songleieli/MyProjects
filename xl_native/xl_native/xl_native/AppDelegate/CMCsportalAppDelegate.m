//
//  DemoAppDelegate.m
//
//
//  Created by song leilei on 15/11/13.
//
//

#import "CMCsportalAppDelegate.h"
#import "TSStorageManager.h"
#import "IQKeyboardManager.h"



#define APPID_VALUE           @"58a2ca55"


@interface CMCsportalAppDelegate ()




@end

@implementation CMCsportalAppDelegate


#pragma mark ------------------静态方法------------------------
+(CMCsportalAppDelegate *)shareApp{
    
    return (CMCsportalAppDelegate *)[UIApplication sharedApplication].delegate;
    
}


#pragma mark  ------------- 重载基类的方法-------------------



- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)onBaseContextWillStartupWithOptions:(NSDictionary *)launchOptions{
    [super onBaseContextWillStartupWithOptions:launchOptions];
    
    /*
     *在此处加载一些配置文件
     */
    [super onBaseContextWillStartupWithOptions:launchOptions];
    
    [[TSStorageManager sharedStorageManager] open];
    [[WCBaseContext sharedInstance] startupWithConfiguration:[GlobalFunc sharedInstance].gWCOnbConfiguration];
    
    
    // 李振华添加键盘自动弹起事件
    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];

    
    
}

- (void)onBaseContextDidStartupWithOptions:(NSDictionary *)launchOptions{
    /*
     *在此处加载通用功能，比如引导页，广告等。。。
     */
    [super onBaseContextDidStartupWithOptions:launchOptions];
    
    /*
     *版本更新
     */
}

-(UIViewController*)getProjRootViewController{
    
    NSLog(@"--------- 程序启动预设加载完成 do nothing------");
    NSString *rootViewController = [GlobalFunc sharedInstance].gWCOnbConfiguration.rootViewController;
    CMCsportalRootViewController *vc = [[NSClassFromString(rootViewController) alloc] init];
    self.rootViewController = vc;
    return vc;
}

#pragma mark - 消息推送的相关协议

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"注册消息推送成功：%@",deviceToken);
    
}
//注册消息推送失败，并返回失败原因
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册消息推送失败：%@",error);
}
//程序正在运行中接收到远程推送消息，打卡状态
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
  
    
}

//程序进程被杀死后中心启动，非打卡状态
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    
    self.dicPushUserInfo = userInfo;
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        NSLog(@"--------------");
        
        /*
         *应用在打卡状态，弹出提醒框
         */
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送消息" message:@"收到推送消息，是否查看？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
        alert.tag = 999;
        [alert show];
        
    }
    else{
       
    }
    
    //[application setApplicationIconBadgeNumber:0];
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
