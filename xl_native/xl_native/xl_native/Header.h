//
//  Header.h
//  xl_native
//
//  Created by MAC on 2018/9/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define XLRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define navBackgroundColor XLRGBColor(37, 147, 252)

// 设置 view 圆角和边框
#define viewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#ifdef DEBUG
#define XLLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define XLLog(...)
#endif

#define HMSTR(fmt,...) [NSString stringWithFormat:(fmt),##__VA_ARGS__]

#pragma mark - model / view
#import "MyWelfareTicketCell.h"


#import "VoiceJumpModel.h"
#import "BaseNavigationController.h"
#import "XLVoiceButton.h"
#import "XLVoiceJumpViewController.h"
#import "SVProgressHUD.h"
#import "VoiceAnimationHUD.h"
#import "PlayerViewController.h"
#import "lame.h"
#import "AddIntegralTool.h"
#import "XLTBSingleTool.h"
#import "XLCommentView.h"
#import "XLVoiceSingleTool.h"
#import "ZJLoginViewController.h"
#import "XLPlanDetailVC.h"
#import "NSDate+TimeCategory.h"


#pragma mark - 语音跳转页面
#import "MyCreditViewController.h"
#import "ReadNameAuthViewController.h"
#import "SettingViewController.h"
#import "MyIntegralViewController.h"
#import "PersonalInformationViewController.h"
#import "ModifyPasswordViewController.h"


#import "YMPowerDashboard.h"


#pragma mark - NetWork
#import "NetWork_addIntegral.h"
#import "NetWork_keywordFunctionList.h"
#import "NetWork_addressBookList.h"
#import "NetWork_inviteNewUser.h"
#import "NetWork_aboutUs.h"
#import "NetWork_hotTopic.h"
#import "NetWork_himInfo.h"
#import "NetWork_myFansList.h"
#import "NetWork_checkUserToken.h"
#import "NetWork_myWelfareTicket.h"
#import "NetWork_homePlan.h"
#import "NetWork_orderList.h"
#import "NetWork_orders.h"
#import "NetWork_plantingPlan.h"
#import "NetWork_userList.h"
#import "NetWork_membershipWelfare.h"
#import "NetWork_voucherMessage.h"



#pragma mark - 三方库
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import "MJRefresh.h"
#import "YYModel.h"
#import "IQKeyboardManager.h"



#endif /* Header_h */
