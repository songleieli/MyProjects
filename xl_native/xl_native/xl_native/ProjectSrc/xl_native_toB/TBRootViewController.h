//
//  CMPLjhMobileRootViewController.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/11.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseNavigationController;

@class TBWealthPlanViewController;
@class TBOrderViewController;
@class TBFilesViewController;

@interface TBRootViewController : UIViewController

//viewController
@property (nonatomic, strong) TBWealthPlanViewController* wealthPlanViewController;
@property (nonatomic, strong) TBOrderViewController* orderViewController;
@property (nonatomic, strong) TBFilesViewController* filesViewController;

//NavViewController
@property (nonatomic, strong) BaseNavigationController *wealthPlanNavViewController;
@property (nonatomic, strong) BaseNavigationController *orderNavViewController;
@property (nonatomic, strong) BaseNavigationController *filesNavViewController;

@property (nonatomic, strong) BaseNavigationController *currentViewController;

- (void)selectTabAtIndex:(NSInteger)toIndex;

@end
