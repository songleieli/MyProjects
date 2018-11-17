//
//  BaseWebViewController.h
//  君融贷
//
//  Created by admin on 15/9/25.
//  Copyright (c) 2015年 JRD. All rights reserved.
//
#import <WebKit/WebKit.h>

#import "NetWork_uploadApi.h"


@interface TBBaseWKWebViewController : TBBaseViewController <WKUIDelegate,WKNavigationDelegate,UIActionSheetDelegate>

@property (nonatomic, copy) NSString *homeUrl; //当前WKWebView的一级页面地址
@property (nonatomic, copy) NSString *myCallBackVariable;
@property (nonatomic, strong) WKWebView *webDefault;
@property (strong, nonatomic) UIProgressView *progressView;


- (void)reloadWebWithUrl:(NSString *)url msg:(NSString *)msg;

- (void)hiddenTabBar:(BOOL)hidden isAnimat:(BOOL)isAnimat;

- (void)voicePurchase:(NSString*)myCallBack;

- (void)voiceCallBack:(NSString *)filePathMp3 voiceContent:(NSString *)voiceContent myCallBack:(NSString*)myCallBack;

- (void)homePageVideoUrl:(NSString *)url;

- (void)reLoadHomeUrl; //重新加载首页


@end
