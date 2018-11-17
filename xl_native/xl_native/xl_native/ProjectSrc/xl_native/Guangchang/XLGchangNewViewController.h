//
//  FirstFunctionViewController.h
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCustomTabBarLjhTableViewController.h"
#import "MyScrollView.h"
#import "XLGCBodyView.h"



@interface XLGchangNewViewController : ZJCustomTabBarLjhTableViewController


@property (strong, nonatomic) MyScrollView   *scrolBanner;//Banner轮播图


@property (nonatomic,strong) UIView * viewHeadBg;
@property (nonatomic,strong) UIView * viewFooterBg;

@property(nonatomic,strong) XLGCBodyView *bodyView;

@end
