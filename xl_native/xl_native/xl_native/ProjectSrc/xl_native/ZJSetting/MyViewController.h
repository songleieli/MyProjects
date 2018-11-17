//
//  ZJMessageViewController.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/8.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ZJCustomTabBarLjhTableViewController.h"
#import "SettingViewController.h"
#import "ReadNameAuthViewController.h"
#import "MyCreditViewController.h"
#import "MyIntegralViewController.h"
#import "MyViewTableViewCell.h"
#import "MyFansViewController.h"
#import "MyAttentionViewController.h"
#import "XLProjectWkWebViewController.h"



@interface MyViewController : ZJCustomTabBarLjhTableViewController<CellDelegate>


@property (nonatomic,strong) UIView * viewHeadBg;
@property (nonatomic,strong) UIView *textFieldBgView;
@property (nonatomic,strong) UIButton *cancleButton;
@property (nonatomic,strong) UITextField * textFieldSearchKey;

/*
//头像
@property (nonatomic, strong) UIImageView * iconImageView;
//登录按钮
@property (nonatomic, strong) UIButton *btnLigin;
//姓名
@property (nonatomic, strong) UILabel *labelName;
//介绍
@property (nonatomic, strong) UILabel *labelDetail;
*/
/*
 *数据源
 */
@property (nonatomic,strong)NSMutableArray * firstSectionSource;
@property (nonatomic,strong)NSMutableArray * secondSectionSource;



@end
