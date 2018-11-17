//
//  CMPLjhMobileRootViewController.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/11.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLVoiceButton.h"

@class BaseNavigationController;

@class XlHomeViewController;
@class HuinongViewController;
@class XLGchangNewViewController;
@class TopicViewController;
@class MyViewController;

@interface CMPZjLifeMobileRootViewController : UIViewController

//viewController
@property (nonatomic, strong) XlHomeViewController* homeNewViewController;
@property (nonatomic, strong) HuinongViewController* huinongViewController;
@property (nonatomic, strong) XLGchangNewViewController* gchangViewController;
@property (nonatomic, strong) TopicViewController *topicViewController;
@property (nonatomic, strong) MyViewController* myViewController; 

//NavViewController
@property (nonatomic, strong) BaseNavigationController *xlHomeNavViewController;
@property (nonatomic, strong) BaseNavigationController *huinongNavController;
@property (nonatomic, strong) BaseNavigationController *gchangNavViewController;
@property (nonatomic,strong)   BaseNavigationController * topicNavViewController;
@property (nonatomic,strong)   BaseNavigationController * settingNavViewController;


@property (nonatomic, strong) BaseNavigationController *currentViewController;


//@property (strong, nonatomic) XLVoiceButton *suspensionBtn;
//@property (assign, nonatomic) CGPoint currentTemp;

- (void)selectTabAtIndex:(NSInteger)toIndex;

@end
