//
//  BaseNavigationController.m
//  YCCarPartner
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 huipeng. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

+ (void)initialize {
    
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                          [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1], NSForegroundColorAttributeName,
//                                                          [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1], NSForegroundColorAttributeName,
                                                          [UIFont defaultFontWithSize:17.0f], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    if(IOS8_OR_LATER && [UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
}

+ (instancetype)navigationWithRootViewController:(UIViewController *)viewController {
    return [[[self class] alloc] initWithRootViewController:viewController];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
