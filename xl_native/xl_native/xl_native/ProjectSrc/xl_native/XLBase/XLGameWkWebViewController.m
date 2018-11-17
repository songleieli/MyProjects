//
//  XLVoiceJumpViewController.m
//  xl_native
//
//  Created by MAC on 2018/9/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLGameWkWebViewController.h"

@interface XLGameWkWebViewController ()


@end

@implementation XLGameWkWebViewController

    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = YES; //隐藏一呼即有按钮
}

-(void)viewDidDisappear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarHidden = NO;
//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = NO; //显示一呼即有按钮
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

-(void)initNavTitle{
    
    self.isNavBackGroundHiden  = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)reLoadHomeUrl{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


@end
