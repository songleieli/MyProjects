//
//  NickNameViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "MyCreditViewController.h"
//#import "NetWork_updateUser.h"

@interface MyCreditViewController () //<UITextFieldDelegate>
//{ BOOL _canedit; }

/** 昵称textField */
// @property(nonatomic,strong) UITextField * nickNameTextField;

@property (strong, nonatomic) YMPowerDashboard *circleAnimationView;

@end

@implementation MyCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的信用";
    self.view.backgroundColor = XLRGBColor(239, 239, 239);
    
    [self setupViews];
}

- (void)setupViews{
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight_New, ScreenWidth, 380)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    

    CGFloat defaultValue = 0.8f;
    CGRect frame = CGRectMake((ScreenWidth - 260.0f) * 0.5f, 80.0f, 260.0f, 260.0f);
    self.circleAnimationView = [[YMPowerDashboard alloc] initWithFrame:frame];
    self.circleAnimationView.animationInterval = 1.5f;
    self.circleAnimationView.strokeColor = XLRGBColor(10, 90, 221);//[UIColor whiteColor];
    [self.circleAnimationView setPercent:defaultValue
                                animated:YES];
    [whiteView addSubview:self.circleAnimationView];
    [self.circleAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(260.0f);
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(60.0f);
    }];
}

@end
