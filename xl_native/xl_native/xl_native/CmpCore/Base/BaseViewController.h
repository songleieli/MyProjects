//
//  YCCustomViewController.h
//  YCBuddy
//
//  Created by bita on 15/5/26.
//  Copyright (c) 2015年 bita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ShowNotice.h"
#import "VoiceJumpModel.h"

@interface BaseViewController : UIViewController <UIAlertViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,WCServiceJrLoanDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIButton *btnLeft;
@property (strong, nonatomic) UIButton *btnRight;
@property (strong, nonatomic) UIView *titleNavView;
@property (strong, nonatomic) UILabel *lableNavTitle;
@property (strong, nonatomic) UIView *navBackGround;

@property (nonatomic, strong) ShowNotice *showNotice;
@property (nonatomic, assign) BOOL isNavBackGroundHiden;



+ (instancetype)classViewController;

- (void)setTitle:(NSString *)title;

-(void)setBtnRight:(UIButton *)btnRight;


#pragma mark - 进入下一页面
- (void)pushNewVC:(UIViewController *)newViewController
         animated:(BOOL)animated;

- (void)pushNewVC:(UIViewController *)newViewController
         animated:(BOOL)animated
          hideNav:(BOOL)hideNav;

#pragma mark - 到指定页面处理
- (void)pushNewVC:(UIViewController *)newViewController
         enableVC:(NSString *)enableViewControllerName
         animated:(BOOL)animated;

- (void)pushNewVC:(UIViewController *)newViewController
         enableVC:(NSString *)enableViewControllerName
         animated:(BOOL)animated
          hideNav:(BOOL)hideNav;

- (void)addLeftBtn;
- (void)LeftBtnClicked:(UIButton *)sender;

- (void)initNavTitle;


//一般的提示
- (void)showFaliureHUD:(NSString *)message;//接口请求失败提示
- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg;
- (void)handleTokenOverdue:(NSString *)msg; //token 过期处理方法

/*
 *等待框
 */
- (void)startWithCursor:(NSString*)msg;
- (void)stopWatiCursor;

//- (void)voiceResultPushVC:(VoiceJumpModel *)model;

/// main UITableView
@property (nonatomic, strong) UITableView * mainTableView;
/// mainDataArr
@property (strong, nonatomic) NSMutableArray *mainDataArr;
/// 刷新
-(void)headerRereshing;
-(void)footerRereshing;

@end
