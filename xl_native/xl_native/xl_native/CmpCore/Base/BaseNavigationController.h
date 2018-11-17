//
//  BaseNavigationController.h
//  YCCarPartner
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 huipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseNavigationController : UINavigationController

+ (instancetype)navigationWithRootViewController:(UIViewController *)viewController;

@end
