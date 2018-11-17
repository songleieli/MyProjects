//
//  FirstFunctionViewController.m
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "HuinongViewController.h"

@interface HuinongViewController ()

@end

@implementation HuinongViewController

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    /*四个一级页面判断需要登录，我爱我乡没有游客模式*/
//    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
//    } cancelBlock:nil isAnimat:YES];

    self.tabBar.top = [self getTabbarTop];    //  重新设置tabbar的高度
}

-(void)initNavTitle{
    self.title = @"惠农";
    self.lableNavTitle.textColor = XLColorMainLableAndTitle;
    self.navBackGround.backgroundColor = [UIColor whiteColor];
    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = XLColorCutLine;
    [self.navBackGround addSubview:lineView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *url = [WCBaseContext sharedInstance].h5Server;
//    url = [NSString stringWithFormat:@"%@/H5/farmweFitting.html",url];
//
//    [self.webDefault loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self reLoadHomeUrl];
}

-(void)reLoadHomeUrl{
    
    NSString *url = [WCBaseContext sharedInstance].h5Server;
    url = [NSString stringWithFormat:@"%@/H5/farmweFitting.html",url];
    self.homeUrl = url;
    [self.webDefault loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.homeUrl]]];
}

#pragma -mark  -----重写父类中的方法 实现tabar隐藏后的操作------------
-(void)tabBarDidHide:(BOOL)hidden
{
    if(hidden){
        self.navBackGround.hidden = YES;
        self.webDefault.frame = CGRectMake(0, KStatusBarHeight_New, ScreenWidth, ScreenHeight - KTabBarHeightOffset_New - KStatusBarHeight_New);
    }
    else{
        self.navBackGround.hidden = NO;
        self.webDefault.frame = CGRectMake(0, kNavBarHeight_New, ScreenWidth, ScreenHeight - kNavBarHeight_New - kTabBarHeight_New);
    }
}

//重写父类中的方法，实现播放视频。
- (void)homePageVideoUrl:(NSString *)url{
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    PlayerViewController *playVC =[[PlayerViewController alloc] init];
    playVC.videoUrlString = url;
    
    [self.navigationController pushViewController:playVC animated:YES];
}


@end
