//
//  WCAppDelegateBase.m
//  NewSolution
//
//  Created by songlei on 14-6-26.
//  Copyright (c) 2014年 com.winchannel. All rights reserved.
//

#import "AppDelegateBase.h"  //自定义应用委托基类

#import "IFlyMSC/IFlyMSC.h"

#pragma mark - 自定义应用委托基类 延展(内部)
@interface AppDelegateBase ()

- (void)delayLoadData;                                      //延迟加载数据方法
- (void)setupSystem;            //设置系统
- (void)listeningNotification;  //监听通知

@end

@implementation AppDelegateBase

#pragma mark - 获取主窗口window
- (UIWindow*)window
{
    if(_window == nil)
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    return _window;
}

+(AppDelegateBase *)appDelegate{
    return (AppDelegateBase *)[UIApplication sharedApplication].delegate;
}

#pragma mark - UIApplicationDelegate代理协议

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.application = application;
    self.launchOptions = launchOptions;

    [self onBaseContextWillStartupWithOptions:launchOptions]; //程序启动，还没有加载 RootViewController。
    
    [self appRegisterForRemoteNotification:launchOptions];  //如果需要注册推送通知，在子类中重写该方法。
   
    self.window.rootViewController = [self getProjRootViewController];
    [self.window makeKeyAndVisible];
    
    [self onBaseContextDidStartupWithOptions:launchOptions]; //程序启动，已经加载 RootViewController。
    //[self delayLoadData]; //需要延迟加载的一些方法
    
    [self performSelector:@selector(delayLoadData) withObject:nil afterDelay:8.0f];

    self.reachiability =[Reachability reachabilityWithHostName:@"https://www.baidu.com/"];//可以以多种形式初始化
    [self.reachiability startNotifier]; //开始监听,会启动一个run loop
    
    // 测试
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"5ba0c792"];
    [IFlySpeechUtility createUtility:initString];
    
//    // 每日登陆APP 积分埋点
//    [[AddIntegralTool sharedInstance] addIntegral:nil code:@"10006"];

    #pragma mark - 友盟统计
    [UMConfigure setEncryptEnabled:YES];
    [UMConfigure initWithAppkey:@"5baeecddf1f5565f50000198" channel:nil];
    
     return YES;
}




#pragma mark - 子类重载方法
- (void)appRegisterForRemoteNotification :(NSDictionary *)launchOptions{
    /*
     用于重载 注册推送通知。
     */
}

- (UIViewController*)getProjRootViewController{
    /*
       用于重载 返回当前Window的RootViewController,如果子类没有重载该方法则返回 UIViewController。
     */
    return [[UIViewController alloc]init];
}

- (void)onBaseContextWillStartupWithOptions:(NSDictionary *)launchOptions {
    //do nothing
    NSLog(@"---------RootViewController 即将加载------");
}

- (void)onBaseContextDidStartupWithOptions:(NSDictionary *)launchOptions {
    //do nothing
    NSLog(@"---------RootViewController 已经加载------");
}

#pragma mark - 延迟加载数据方法

- (void)delayLoadData{
    
    
    NSLog(@"---------delayLoadData 延时加载------");

    [self setupSystem];
    [self listeningNotification];
}
- (void)setupSystem{
    /*
     * 系统设置方法
     */
    
    [self setupSDWebImageManager];
    
}
-(void)listeningNotification{
    /*
     * 添加全局通知监听
     */
}

- (void)setupSDWebImageManager
{
    
     //[[SDImageCache sharedImageCache] clearDisk];
    
//    [[SDImageCachesharedImageCache]addReadOnlyCachePath:bundlePath];
//    [[SDWebImageManager sharedManager] ]
    //[SDWebImageManager sharedManager].usingFileNameForKey = YES; //usingFileNameForKey自定义新增属性 去除SDWebImage缓存路径 将下载完成的图片指向已有的缓存路径
}


@end
