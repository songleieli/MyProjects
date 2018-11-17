//
//  DemoAppDelegate.m
//
//
//  Created by song leilei on 15/11/13.
//
//

#import "CMPZjLifeMobileAppDelegate.h"

#import "TSStorageManager.h"
//#import "JPUSHService.h"


#define ZJ_JPUSH_KEY             @"c4983bc34ae2570bb4e8610e"  //极光推送


@interface CMPZjLifeMobileAppDelegate ()

@end

@implementation CMPZjLifeMobileAppDelegate


#pragma mark ------------------静态方法------------------------
+(CMPZjLifeMobileAppDelegate *)shareApp{
    
    return (CMPZjLifeMobileAppDelegate *)[UIApplication sharedApplication].delegate;
    
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
    
    
    //微信注册
//    [WXApi registerApp:[WCBaseContext sharedInstance].wxWgAppKey];
    //注册微博分享
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:[WCBaseContext sharedInstance].sinaWgAppKey];
    
}

- (void)onBaseContextDidStartupWithOptions:(NSDictionary *)launchOptions{
    /*
     *在此处加载通用功能，比如引导页，广告等。。。
     */
    [super onBaseContextDidStartupWithOptions:launchOptions];
    
    /*
     *版本更新
     */
    //[self updateVrsion];
}

-(UIViewController*)getProjRootViewController{

    NSLog(@"--------- 程序启动预设加载完成 do nothing------");
    [self checkUserToken];

    NSString *rootViewController = [GlobalFunc sharedInstance].gWCOnbConfiguration.rootViewController;
    CMPZjLifeMobileRootViewController *vc = [[NSClassFromString(rootViewController) alloc] init];
    self.rootViewController = vc;
    return vc;
}

- (void)checkUserToken {
    NetWork_checkUserToken *request = [[NetWork_checkUserToken alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    [request startPostWithBlock:^(CheckUserTokenRespone *result, NSString *msg, BOOL finished) {
        if (finished) {
            NSString *status = result.status;

            if (![status isEqualToString:@"1"]) {
                [GlobalData cleanAccountInfo];
                
                ZJLoginViewController *tempVC = [[ZJLoginViewController alloc] init];
                BaseNavigationController *tempNav = [[BaseNavigationController alloc]initWithRootViewController:tempVC];
                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:tempNav animated:NO completion:nil];
            }
        }
    }];
}

#pragma mark - 子类重载方法
- (void)appRegisterForRemoteNotification :(NSDictionary *)launchOptions{
    /*
     用于重载 注册推送通知。
     */
}




@end
