//
//  BaseWebViewController.m
//  君融贷
//
//  Created by admin on 15/9/25.
//  Copyright (c) 2015年 JRD. All rights reserved.
//

#import "TBBaseWKWebViewController.h"
#import "NSString+Encryption.h"
#import "UIApplication+Extension.h"


//选择时间
#import "iToast.h"
#import "MBProgressHUD.h"

#import "Callback_token.h"
#import "Callback_voice_purchase.h"
#import "Callback_userInfo.h"

@interface TBBaseWKWebViewController ()<UIAlertViewDelegate>

@property (nonatomic, copy)NSString *aliPayCallBackInfo;
@property (nonatomic, copy)NSString *outTradeNo;
@property (nonatomic, copy)NSString *getTimeCallBackInfo;
@property(nonatomic,strong) MBProgressHUD * hub;
@property(nonatomic,strong) UIWebView * callBackWebView;
@property(nonatomic,strong) NSString *webloadurl;//当前页面的url

@property (strong, nonatomic) UIView *topNav;

/// 无数据展示的view
@property (nonatomic,strong) UIView* noDataView;

@end

@implementation TBBaseWKWebViewController

- (UIProgressView *)progressView{

    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
        _progressView.trackTintColor = [UIColor whiteColor];
        _progressView.progressTintColor=RGBAlphaColor(9, 44, 102, 1);
    }
    return _progressView;
}

- (WKWebView *)webDefault{
    
    if (!_webDefault) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        config.mediaTypesRequiringUserActionForPlayback = false;
        
        _webDefault = [[WKWebView alloc] initWithFrame:CGRectMake(0, KStatusBarHeight_New, ScreenWidth, ScreenHeight - KTabBarHeightOffset_New - KStatusBarHeight_New) configuration:config];
        _webDefault.backgroundColor = [UIColor whiteColor];
        _webDefault.UIDelegate = self;
        _webDefault.navigationDelegate = self;
        _webDefault.scrollView.showsVerticalScrollIndicator = NO;
        _webDefault.scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _webDefault.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }

        [_webDefault addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
        [_webDefault addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    }
    return _webDefault;
}


- (void)dealloc{
    NSLog(@"----------------BaseWKWebViewController------dealloc---------------------");
    [self.webDefault removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webDefault removeObserver:self forKeyPath:@"title"];
    //    // if you have set either WKWebView delegate also set these to nil here
    [self.webDefault setNavigationDelegate:nil];
    [self.webDefault setUIDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.webDefault];
    [self.webDefault addSubview:self.progressView];

    [self.view addSubview:self.topNav];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    [self.webDefault reload];
}
- (void)reloadWebWithUrl:(NSString *)url msg:(NSString *)msg{
    if(url.length>0){
        NSLog(@"-------------reloadWebWithUrl url = %@",url);
        @autoreleasepool {
            [self showFaliureHUD:msg];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:30];
            [self.webDefault loadRequest:request];
        }
    }
}

/*
 *进度条
 */

#pragma mark - 加载进度条

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    NSLog(@" %s,change = %@",__FUNCTION__,change);
    if ([keyPath isEqual: @"estimatedProgress"] && object == self.webDefault) {
        [self.progressView setAlpha:1.0f];
        self.progressView.progress = self.webDefault.estimatedProgress;

        if(self.webDefault.estimatedProgress >= 1.0f){
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else if ([keyPath isEqual: @"title"] && object == self.webDefault) {
//        self.title = @"";//self.webDefault.title;
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKWebView WKNavigationDelegate 相关
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error{
    
    [self showNoDataImage];
}
/// 是否允许加载网页 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([urlString.trim hasSuffix:@"show=true"]) {// 临时数据 后台操作
        urlString = @"xl://go_home";
    }
    
    if([urlString.trim hasPrefix:@"xl://"]){ //基础框架
        /*
         *处理 Scheme
         */
        urlString = [urlString stringByRemovingPercentEncoding];
        [self dealLjhScheme:webView ljhSchemeStr:urlString];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    } else if ([urlString.trim hasPrefix:@"tel:"]) { // 打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString.trim]];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt
    defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(NSString *result))completionHandler{
    
    NSLog(@"获取同步方法%@",prompt);
    //系统默认
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
     [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
     textField.text = defaultText;
     }];
     [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     completionHandler(alertController.textFields[0].text?:@"");
     }])];
     
     [self presentViewController:alertController animated:YES completion:nil];
}

/// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self removeNoDataImage];
    
    NSLog(@"------------didFinishNavigation----------");
    if (self.homeUrl.length == 0) {
        self.homeUrl = @"";
    }
    if(![self.webDefault canGoBack] || [[[webView URL] absoluteString] hasPrefix:self.homeUrl]){
        [self hiddenTabBar:NO isAnimat:YES];
    }
    else{
        [self hiddenTabBar:YES isAnimat:YES];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    @autoreleasepool {
        //[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}


#pragma mark ===========H5 与原生代码交互=============

#pragma mark -----处理 xl：Scheme-----

-(void)dealLjhScheme:(WKWebView*)webView ljhSchemeStr:(NSString*)ljhSchemeStr{
    
    NSString *functionStr = @"";
    //NSString *paramStr = @"";
    NSArray *array = [ljhSchemeStr componentsSeparatedByString:@"?"];
    if(array.count >= 2){
        NSMutableString *str = [[NSMutableString alloc] init];
        for(int i=1;i<array.count;i++){
            [str appendString:[array objectAtIndex:i]];
            if(i != array.count - 1){
                [str appendString:@"?"];
            }
        }
    }
    functionStr = [array objectAtIndex:0];
    NSArray *arrayFunction = [functionStr componentsSeparatedByString:@"/"];//从字符A中分隔成2个元素的数组
    NSString *myCallBack = [arrayFunction objectAtIndex:arrayFunction.count-1];
    
    NSString *callBackStr = @"";
    if([ljhSchemeStr.trim hasPrefix:@"xl://get_token"]){ //获取用户token
       callBackStr = [self HybridCall_GetToken:myCallBack];
    }
    else if([ljhSchemeStr.trim hasPrefix:@"xl://goback"]){ //h5页面返回
        [self HybridCall_GoBack];
    }
    else if([ljhSchemeStr.trim hasPrefix:@"xl://get_voice"]){ // 语音购买
        [self voicePurchase:myCallBack];
    }
    else if([ljhSchemeStr.trim hasPrefix:@"xl://get_url"]){ // 首页视频

        NSArray *data = [ljhSchemeStr.trim componentsSeparatedByString:@"?"];
        NSString *jsonStr = data[1];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        NSString *videoUrl = jsonDic[@"video_url"];
        
        [self homePageVideoUrl:videoUrl];
    } else if ([ljhSchemeStr.trim hasPrefix:@"xl://go_home"]){ // 回到首页
            [self reLoadHomeUrl];
    }
    else if ([ljhSchemeStr.trim hasPrefix:@"xl://goto_square"]){ // 乡邻广场
        AppDelegateBase *delegate = (AppDelegateBase *)[[UIApplication sharedApplication] delegate];
        ZJCustomTabBar *tab = (ZJCustomTabBar *)delegate.window.rootViewController;
        [tab selectTabAtIndex:2];
        [self reLoadHomeUrl];
    }
    else if ([ljhSchemeStr.trim hasPrefix:@"xl://get_userInfo"]){ // 乡邻广场
        callBackStr = [self HybridCall_GetUserInfo:myCallBack];
    }
    if(callBackStr.length >0 ){
        //test  js 保留
        //WKWebView调用JS 方法
        [self.webDefault evaluateJavaScript:callBackStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response3: %@ error: %@", response, error);
        }];
    }
}

#pragma mark -----H5 与原生代码交互-----

-(NSString*)HybridCall_GetToken:(NSString*)myCallBack{
    
    Callback_token *callback_token = [[Callback_token alloc]init];
    callback_token.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    
    return [NSString stringWithFormat:@"%@('%@');",myCallBack, [callback_token generateJsonStringForProperties]];
}

-(void)HybridCall_GoBack{
    if([self.webDefault canGoBack]){
        [self.webDefault goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)voiceCallBack:(NSString *)filePathMp3 voiceContent:(NSString *)voiceContent myCallBack:(NSString*)myCallBack{
    
    NSString *filePath = [NSString stringWithFormat:@"file://%@",filePathMp3];
    NSString *extName = [filePath pathExtension];
    NSURL *audioUrl = [NSURL URLWithString:filePath];
    /*
     *测试上传视频
     */
    NSMutableDictionary *fileDic = [[NSMutableDictionary alloc]init];
    NSData *mp3Data = [NSData dataWithContentsOfURL:audioUrl];
    NSString *key = [NSString stringWithFormat:@"%@.%@",[GlobalFunc getCurrentTimeWithFormatter:@"yyyyMMddHHmmssSSS"],extName];
    [fileDic setObject:mp3Data forKey:key];
    
    NetWork_uploadApi *requestUpload = [[NetWork_uploadApi alloc] init];
    requestUpload.uploadFilesDic = fileDic;
    [requestUpload showWaitMsg:@"加载中..." handle:self];
    [requestUpload startPostWithBlock:^(UploadRespone *result, NSString *msg, BOOL finished) {
        
        if(finished){ //语音上传成功后回调H5
            NSLog(@"----------");
            
            Callback_voice_purchase *callback_voice_purchase = [[Callback_voice_purchase alloc] init];
            callback_voice_purchase.voice_url = ((UploadModel*)[result.data objectAtIndex:0]).showAttachUrl;
            callback_voice_purchase.voice_content = voiceContent;
            
            NSString *voiceCallBackStr = [NSString stringWithFormat:@"%@('%@');",myCallBack, [callback_voice_purchase generateJsonStringForProperties]];
            //WKWebView调用JS 方法
            [self.webDefault evaluateJavaScript:voiceCallBackStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response3: %@ error: %@", response, error);
            }];
        }
    }];
}

/*获取用户信息*/
-(NSString*)HybridCall_GetUserInfo:(NSString*)myCallBack{
    
    Callback_userInfo *callback_userInfo = [[Callback_userInfo alloc]init];
    callback_userInfo.userId = [GlobalData sharedInstance].adminLoginDataModel.userId;
    callback_userInfo.userName = [GlobalData sharedInstance].adminLoginDataModel.userName;
    callback_userInfo.userIcon = [GlobalData sharedInstance].adminLoginDataModel.userIcon;

    
    return [NSString stringWithFormat:@"%@('%@');",myCallBack, [callback_userInfo generateJsonStringForProperties]];
}


#pragma -mark 虚拟方法 在子类中重写功能
- (void)reLoadHomeUrl{
    NSLog(@"---------------over write me----重新加载H5的一级页面--------------");

}

- (void)homePageVideoUrl:(NSString *)url{
    NSLog(@"---------------over write me----播放本地视频--------------");

}

- (void)voicePurchase:(NSString*)myCallBack{
    NSLog(@"---------------over write me----声音购买商品--------------");

}

- (void)hiddenTabBar:(BOOL)hidden isAnimat:(BOOL)isAnimat{
    NSLog(@"---------------over write me-----------实现隐藏tableBar-------");
}
#pragma mark - 无数据图
-(void)showNoDataImage{
    if (!self.noDataView) {
        self.noDataView = [[UIView alloc] init];
        self.noDataView.backgroundColor = [UIColor whiteColor];
        
        [self.view.subviews enumerateObjectsUsingBlock:^(WKWebView* obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[WKWebView class]]) {
                [self.noDataView setFrame:CGRectMake(0, 0,obj.frame.size.width, obj.frame.size.height)];
                [obj addSubview:self.noDataView];
            }
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webDefaultReload)];
        [self.noDataView addGestureRecognizer:tap];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"h5_refresh"]];
        img.size = CGSizeMake(100, 100);
        img.center = self.noDataView.center;
        [self.noDataView addSubview:img];
    }
}
- (void)webDefaultReload
{
    [self reLoadHomeUrl];
}
-(void)removeNoDataImage{
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }
}

- (UIView *)topNav {
    if (!_topNav) {
        _topNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KStatusBarHeight_New)];
        _topNav.backgroundColor = navBackgroundColor;
    }
    return _topNav;
}

@end
