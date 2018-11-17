//
//  CMPLjhMobileRootViewController.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/11.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.

#import "TBRootViewController.h"
#import "BaseNavigationController.h"

#import "TBWealthPlanViewController.h"
#import "TBOrderViewController.h"
#import "TBFilesViewController.h"


@interface TBRootViewController ()<TBChangeIndexDelegate>

@end

@implementation TBRootViewController

#pragma mark ------------属性-----------


- (TBWealthPlanViewController *)wealthPlanViewController{
    if (!_wealthPlanViewController){
        _wealthPlanViewController = [[TBWealthPlanViewController alloc]init];
        _wealthPlanViewController.selectedIndex = 0;
        _wealthPlanViewController.changeIndexDelegate = self;
    }
    return _wealthPlanViewController;
}

- (TBOrderViewController *)orderViewController{
    if (!_orderViewController){
        _orderViewController = [[TBOrderViewController alloc]init];
        _orderViewController.selectedIndex = 1;
        _orderViewController.changeIndexDelegate = self;
    }
    return _orderViewController;
}

- (TBFilesViewController *)filesViewController{
    if (!_filesViewController){
        _filesViewController = [[TBFilesViewController alloc]init];
        _filesViewController.selectedIndex = 2;
        _filesViewController.changeIndexDelegate = self;
    }
    return _filesViewController;
}



#pragma -mark NavController

- (BaseNavigationController *)wealthPlanNavViewController{
    if (!_wealthPlanNavViewController){
        _wealthPlanNavViewController = [BaseNavigationController navigationWithRootViewController:self.wealthPlanViewController];
    }
    return _wealthPlanNavViewController;
}

- (BaseNavigationController *)orderNavViewController{
    if (!_orderNavViewController){
        _orderNavViewController = [BaseNavigationController navigationWithRootViewController:self.orderViewController];
    }
    return _orderNavViewController;
}

- (BaseNavigationController *)filesNavViewController{
    if (!_filesNavViewController){
        _filesNavViewController = [BaseNavigationController navigationWithRootViewController:self.filesViewController];
    }
    return _filesNavViewController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.wealthPlanNavViewController];
    [self addChildViewController:self.orderNavViewController];
    [self addChildViewController:self.filesNavViewController];
    [[UINavigationBar appearance] setBarTintColor:defaultZjBlueColor];
    
    self.currentViewController = self.wealthPlanNavViewController;
    [self.view addSubview:self.wealthPlanNavViewController.view];
    
}
- (void)selectTabAtIndex:(NSInteger)toIndex{

    BaseNavigationController *toViewController = [self.childViewControllers objectAtIndex:toIndex];
    [toViewController popToRootViewControllerAnimated:NO];
    
    if(toViewController.topViewController == self.currentViewController.topViewController){
        return;
    }
    [UIView setAnimationsEnabled:NO];
    [self transitionFromViewController:self.currentViewController toViewController:toViewController duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
        // do nothing
    } completion:^(BOOL finished) {
        // do nothing
        [UIView setAnimationsEnabled:YES];
        self.currentViewController = toViewController;
        //切换完成后需要将 suspensionBtn 提到最上层
    }];
}

#pragma -mark ChangeIndexDelegate

- (BOOL)customTabBar:(TBCustomTabViewController *)tabBar shouldSelectIndex:(NSInteger)index{
    
    return YES;
}
- (void)customTabBar:(TBCustomTabViewController *)tabBar didSelectIndex:(NSInteger)index {
    [XLTBSingleTool sharedInstance].tabBarIndex = index;
    [self selectTabAtIndex:index];
}

@end
