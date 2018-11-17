//
//  CustomTabBarController.h
//  CustomTabBarController
//
//  Created by Hu Zhiqiang on 22/05/2012.
//  Copyright (c) 2012 __My Computer__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCustomTabBar.h"
#import "BaseTableMJViewController.h"

@protocol TBChangeIndexDelegate;

@interface TBCustomTabViewController : BaseTableMJViewController <TBChangeIndexDelegate>{
	TBCustomTabBar        *_tabBar;
	NSUInteger      _selectedIndex;
}
@property(nonatomic) NSUInteger selectedIndex;
@property (nonatomic, retain) TBCustomTabBar *tabBar;
@property (nonatomic, weak) id <TBChangeIndexDelegate> changeIndexDelegate;

-(CGFloat)getTabbarTop;
- (void)hiddenTabBar:(BOOL)hidden isAnimat:(BOOL)isAnimat;

- (void)addNavigationItem;
- (void)addSearchBar;

@end

@protocol TBChangeIndexDelegate<NSObject>
@optional

- (BOOL)customTabBar:(TBCustomTabViewController *)tabBar shouldSelectIndex:(NSInteger)index;
- (void)customTabBar:(TBCustomTabViewController *)tabBar didSelectIndex:(NSInteger)index;

@end

