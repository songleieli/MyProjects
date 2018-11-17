//
//  XLVoiceJumpViewController.m
//  xl_native
//
//  Created by MAC on 2018/9/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLProjectWkWebViewController.h"

@interface XLProjectWkWebViewController ()


@end

@implementation XLProjectWkWebViewController

    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = YES; //隐藏一呼即有按钮
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewDidDisappear:(BOOL)animated{
//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = NO; //显示一呼即有按钮
}




-(void)initNavTitle{
    
    self.isNavBackGroundHiden  = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)reLoadHomeUrl{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
