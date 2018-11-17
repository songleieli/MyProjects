//
//  CMPLjhMobileRootViewController.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/11.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.

#import "CMPZjLifeMobileRootViewController.h"

#import "BaseNavigationController.h"

#import "XlHomeViewController.h"
#import "HuinongViewController.h"
#import "XLGchangNewViewController.h"
#import "TopicViewController.h"
#import "MyViewController.h"


@interface CMPZjLifeMobileRootViewController ()<ZJChangeIndexDelegate>

@end

@implementation CMPZjLifeMobileRootViewController

#pragma mark ------------懒加载-----------

/*
 *一呼即有功能按钮
 */
//- (XLVoiceButton *)suspensionBtn {
//    if (!_suspensionBtn) {
//        _suspensionBtn = [[XLVoiceButton alloc] init];
//        _suspensionBtn.frame = [UIView getFrame_x:ScreenWidth-80 y:ScreenHeight - 80 - kTabBarHeight_New
//                                            width:80 height:80];
//        _suspensionBtn.voiceResultAction = ^(VoiceJumpModel *model) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationXLVoiceResultPushVC object:model];
//        };
//    }
//    return _suspensionBtn;
//}

- (XlHomeViewController *)homeNewViewController{
    if (!_homeNewViewController){
        _homeNewViewController = [[XlHomeViewController alloc]init];
        _homeNewViewController.selectedIndex = 0;
        _homeNewViewController.changeIndexDelegate = self;
    }
    return _homeNewViewController;
}

- (HuinongViewController *)huinongViewController{
    if (!_huinongViewController){
        _huinongViewController = [[HuinongViewController alloc]init];
        _huinongViewController.selectedIndex = 1;
        _huinongViewController.changeIndexDelegate = self;
    }
    return _huinongViewController;
}

- (XLGchangNewViewController *)gchangViewController{
    if (!_gchangViewController){
        _gchangViewController = [[XLGchangNewViewController alloc]init];
        _gchangViewController.selectedIndex = 2;
        _gchangViewController.changeIndexDelegate = self;
    }
    return _gchangViewController;
}


- (TopicViewController *)topicViewController{
    if (!_topicViewController){
        _topicViewController = [[TopicViewController alloc]init];
        _topicViewController.selectedIndex = 3;
        _topicViewController.changeIndexDelegate = self;
    }
    return _topicViewController;
}

- (MyViewController *)myViewController{
    if (!_myViewController){
        _myViewController = [[MyViewController alloc]init];
        _myViewController.selectedIndex = 4;
        _myViewController.changeIndexDelegate = self;
    }
    return _myViewController;
}



#pragma -mark NavController

- (BaseNavigationController *)xlHomeNavViewController{
    if (!_xlHomeNavViewController){
        _xlHomeNavViewController = [BaseNavigationController navigationWithRootViewController:self.homeNewViewController];
    }
    return _xlHomeNavViewController;
}

- (BaseNavigationController *)huinongNavController{
    if (!_huinongNavController){
        _huinongNavController = [BaseNavigationController navigationWithRootViewController:self.huinongViewController];
    }
    return _huinongNavController;
}

- (BaseNavigationController *)gchangNavViewController{
    if (!_gchangNavViewController){
        _gchangNavViewController = [BaseNavigationController navigationWithRootViewController:self.gchangViewController];
    }
    return _gchangNavViewController;
}

- (BaseNavigationController *)topicNavViewController{
    if (!_topicNavViewController){
        _topicNavViewController = [BaseNavigationController navigationWithRootViewController:self.topicViewController];
    }
    return _topicNavViewController;
}

-(BaseNavigationController *)settingNavViewController{
    if (!_settingNavViewController) {
        _settingNavViewController = [BaseNavigationController navigationWithRootViewController:self.myViewController];
    }
    return _settingNavViewController;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.xlHomeNavViewController];
    [self addChildViewController:self.huinongNavController];
    [self addChildViewController:self.gchangNavViewController];
    [self addChildViewController:self.topicNavViewController];
    [self addChildViewController:self.settingNavViewController];
    [[UINavigationBar appearance] setBarTintColor:defaultZjBlueColor];
    
    self.currentViewController = self.xlHomeNavViewController;
    [self.view addSubview:self.xlHomeNavViewController.view];
    
//    [self.view addSubview:self.suspensionBtn];
}
- (void)selectTabAtIndex:(NSInteger)toIndex{
    
//    if(toIndex == 2){
//        return;
//    }
    
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
//        [self.view bringSubviewToFront:self.suspensionBtn];
    }];
}

#pragma -mark ChangeIndexDelegate

- (BOOL)customTabBar:(ZJCustomTabBarLjhTableViewController *)tabBar shouldSelectIndex:(NSInteger)index{
    
    return YES;
}
- (void)customTabBar:(ZJCustomTabBarLjhTableViewController *)tabBar didSelectIndex:(NSInteger)index{
    [self selectTabAtIndex:index];
}

@end
