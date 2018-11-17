//
//  WCAppDelegateBase.h
//  NewSolution
//
//  Created by songlei on 14-6-26.
//  Copyright (c) 2014年 com.winchannel. All rights reserved.
//

#import <UIKit/UIKit.h>                     //底层工具库


#pragma mark - 自定义应用委托基类

@interface AppDelegateBase : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;                 //主窗口
@property (nonatomic, strong) NSDictionary *launchOptions;      //应用启动参数
@property (nonatomic, strong) UIApplication *application;       //应用信息

@property (strong,nonatomic)Reachability *reachiability;        //监听网络变化
@property (assign,nonatomic)BOOL isReachable;//是否可用
@property (assign,nonatomic)NetworkStatus status;//判定状态用的


+(AppDelegateBase *)appDelegate;

- (void)appRegisterForRemoteNotification :(NSDictionary *)launchOptions; //子类用于注册推送通知
- (void)onBaseContextWillStartupWithOptions:(NSDictionary *)launchOptions;    //基础环境初始化开始
- (void)onBaseContextDidStartupWithOptions:(NSDictionary *)launchOptions;     //基础环境初始化完成
- (void)delayLoadData;                                                        //应用启动后，延时加载方法

- (UIViewController *)getProjRootViewController;


@end
