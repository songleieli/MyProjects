//
//  CustomTabBarController.m
//  CustomTabBarController
//
//  Created by angie on 22/05/2012.
//  Copyright (c) 2012 cetetek. All rights reserved.
//

#import "TBCustomTabViewController.h"
#import "ZJCustomTabBar.h"
#import "XLSearchVC.h"
#import "TBLoginViewController.h"
#import "ScanQRcode.h"
#import "XLMembershipWelfareVC.h"

@interface TBCustomTabViewController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation TBCustomTabViewController

@synthesize selectedIndex = _selectedIndex;


-(CGFloat)getTabbarTop{

    CGFloat top = ScreenHeight - kTabBarHeight_New;//默认隐藏
//    if(self.navigationController.navigationBarHidden == NO){ //显示
//    if(self.isNavBackGroundHiden == NO){
//        top = ScreenHeight - kTabBarHeight_New - kNavBarHeight_New - KTabBarHeightOffset_New;
//    }
    
    UIViewController *rootViewController = [[self parentViewController] parentViewController];
    UIViewController *baseNavViewController = [self parentViewController];
    
    
    

    NSLog(@"self class = %@",NSStringFromClass([self class]));
    
//    if([rootViewController isKindOfClass:[JunrongLoanRootViewController class]]
//       && [baseNavViewController isKindOfClass:[BaseNavigationController class]]){
//        
//        /*
//         用于判断应用启用无线热点，的页面适配
//         */
//    
//    if(rootViewController.view.top == 0 && baseNavViewController.view.top == 0){
//        /*
//         正常启动 或 正常启动切换到热点再切换到正常
//         */
//        NSLog(@"正常启动 或 正常启动切换到热点再切换到正常");
//    }
//    else if (rootViewController.view.top == 20 && baseNavViewController.view.top == 0){
//        /*
//         正常启动情况下，切换到热点
//         */
//        NSLog(@"正常启动情况下，切换到热点");
//        
//        top = top -20;
//
//    }
//    else if (rootViewController.view.top == 20 && baseNavViewController.view.top == 20){
//        /*
//         热点启动 或 热点启动切换到正常在切换到热点
//         */
//        NSLog(@"热点启动");
//        
//        if(self.navigationController.navigationBarHidden == NO){//显示NAV
//            top = top -20;
//        }
//        else{//不显示NAV
//            top = top -40;
//        }
//    }
//    else if (rootViewController.view.top == 0 && baseNavViewController.view.top == 20){
//        /*
//         热点启动，切换到正常
//         */
//        NSLog(@"热点启动，切换到正常");
//        if(self.navigationController.navigationBarHidden == NO){//显示NAV
//            //不处理
//        }
//        else{//不显示NAV
//            top = top - 20;
//        }
//    }
//    }
    

    
    return top;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view bringSubviewToFront:self.tabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChange:) name : UIApplicationDidChangeStatusBarFrameNotification object : nil ];

    NSArray *titles     = @[@"财富计划",@"乡邻订单",@"乡邻档案"];

    
    NSMutableDictionary * propertyProjectImageDic= [NSMutableDictionary dictionaryWithCapacity:0];
    [propertyProjectImageDic setObject:[UIImage imageNamed:@"tabBar0"] forKey:@"Default"];
    [propertyProjectImageDic setObject:[UIImage imageNamed:@"tabBar0_H"] forKey:@"Seleted"];
    
    NSMutableDictionary *neighboursImageDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [neighboursImageDic setObject:[UIImage imageNamed:@"tabBar1"] forKey:@"Default"];
    [neighboursImageDic setObject:[UIImage imageNamed:@"tabBar1_H"] forKey:@"Seleted"];
    
    NSMutableDictionary *plusImageDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [plusImageDic setObject:[UIImage imageNamed:@"tabBar2"] forKey:@"Default"];
    [plusImageDic setObject:[UIImage imageNamed:@"tabBar2_H"] forKey:@"Seleted"];

    
    NSArray *imageArray = [NSArray arrayWithObjects:propertyProjectImageDic, neighboursImageDic,plusImageDic, nil];
    
    _tabBar = [[TBCustomTabBar alloc] initWithButtonImages:imageArray titleArray:titles delegate:self];
    
    
    self.tabBar.frame = CGRectMake(0, [self getTabbarTop], ScreenWidth, kTabBarHeight_New);
    [self.tabBar selectTabAtIndex:_selectedIndex];
    
//    _tabBar.delegate = self;
    [self.view addSubview:self.tabBar];
    
    self.view.backgroundColor = XLRGBColor(242, 242, 242);
}

- (void)viewDidUnload{
	[super viewDidUnload];
	
	_tabBar = nil;
}

#pragma mark - 热点frame 变化通知 ---

-(void)statusBarFrameDidChange:(NSNotification *)notification{
    self.tabBar.top = [self getTabbarTop];
}


#pragma mark - instant methods

- (TBCustomTabBar *)tabBar{
	return _tabBar;
}

- (NSUInteger)selectedIndex{
	return _selectedIndex;
}


#pragma mark - Private methods

- (void)hiddenTabBar:(BOOL)hidden isAnimat:(BOOL)isAnimat{
    if(isAnimat){
        if(hidden && self.tabBar.frame.origin.y == self.view.height - kTabBarHeight_New){       //隐藏tabbar
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            
            self.tabBar.frame = CGRectMake(0, self.view.height+10, ScreenWidth, kTabBarHeight_New);
            [UIView commitAnimations];
            
        } else if(!hidden && self.tabBar.frame.origin.y-10 == self.view.height){                 //显示tabbar
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            
            self.tabBar.frame = CGRectMake(0, self.view.height - kTabBarHeight_New, ScreenWidth, kTabBarHeight_New);
            [UIView commitAnimations];
        }
    }
    else{
        if(hidden && self.tabBar.frame.origin.y == self.view.height - kTabBarHeight_New){       //隐藏tabbar
            self.tabBar.frame = CGRectMake(0, self.view.height, ScreenWidth, kTabBarHeight_New);
            
        } else if(!hidden && self.tabBar.frame.origin.y == self.view.height){                 //显示tabbar
            self.tabBar.frame = CGRectMake(0, self.view.height - kTabBarHeight_New, ScreenWidth, kTabBarHeight_New);
        }
    }
}

#pragma mark tabBar delegates

- (BOOL)tabBar:(TBCustomTabBar *)tabBar shouldSelectIndex:(NSInteger)index{
    
    if(index == _selectedIndex){
        return NO;
    }
    else{
        if ([_changeIndexDelegate respondsToSelector:@selector(customTabBar:shouldSelectIndex:)]){
            return [_changeIndexDelegate customTabBar:self shouldSelectIndex:index];
        }
        return YES;
    }
}

- (void)tabBar:(TBCustomTabBar *)tabBar didSelectIndex:(NSInteger)index{
    if ([_changeIndexDelegate respondsToSelector:@selector(customTabBar:didSelectIndex:)]){
        return [_changeIndexDelegate customTabBar:self didSelectIndex:index];
    }
}

- (void)addNavigationItem
{
    [self setupNavigationItem:@"nav_exit_icon" text:@"退出" textColor:XLRGBColor(9, 114, 218) isRight:NO];
    [self setupNavigationItem:@"qrcode_icon" text:@"扫码" textColor:XLRGBColor(51, 51, 51) isRight:YES];
}
- (void)addSearchBar
{
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(10, CGRectGetMaxY(self.navBackGround.frame) + 10, ScreenWidth - 20, 26);
    search.backgroundColor = [UIColor whiteColor];
    viewBorderRadius(search, 5, 0, [UIColor clearColor]);
    [search addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:search];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    [search addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(search).offset(-15);
        make.centerY.equalTo(search);
        make.width.width.mas_equalTo(17);
    }];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = XLRGBColor(193, 193, 193);
    lab.text = @"搜索";
    [search addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(search).offset(15);
        make.centerY.equalTo(search);
    }];
}
- (void)searchClick
{
    [self.navigationController pushViewController:[[XLSearchVC alloc] init] animated:YES];
}

- (void)setupNavigationItem:(NSString *)imgStr text:(NSString *)text textColor:(UIColor *)textColor isRight:(BOOL)isRight
{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgStr]];
    [self.navBackGround addSubview:img];
    
    if (isRight) {
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.navBackGround).offset(-14);
            make.right.equalTo(self.navBackGround).offset(-44);
            make.width.width.mas_equalTo(20);
        }];
    } else {
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.navBackGround).offset(-14);
            make.left.equalTo(self.navBackGround).offset(14);
            make.width.width.mas_equalTo(20);
        }];
    }
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = textColor;
    lab.text = text;
    [self.navBackGround addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img);
        make.left.equalTo(img.mas_right).offset(5);
    }];
    
    UIButton *click = [UIButton buttonWithType:UIButtonTypeCustom];
    click.backgroundColor = [UIColor whiteColor];
    click.backgroundColor = [UIColor clearColor];
    [click addTarget:self action:@selector(avigationItemClick:) forControlEvents:UIControlEventTouchUpInside];
    if (isRight) {
        click.tag = 1000;
    } else {
        click.tag = 1001;
    }
    [self.navBackGround addSubview:click];
    [click mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(img);
        make.right.equalTo(lab.mas_right);
        make.height.mas_equalTo(20);
    }];
}
- (void)avigationItemClick:(UIButton *)btn
{
    if (btn.tag == 1000) {
        if([GlobalFunc isSimulator]){
            return;
        }
        ScanQRcode *vc = [[ScanQRcode alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (btn.tag == 1001) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]] ;
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            [GlobalData cleanAccountInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationUserLoginSuccess
                                                                object:nil];

            TBLoginViewController *tempVC = [[TBLoginViewController alloc] init];
            BaseNavigationController *tempNav = [[BaseNavigationController alloc]initWithRootViewController:tempVC];
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:tempNav animated:YES completion:nil];
        }]] ;
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
