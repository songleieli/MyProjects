//
//  CustomTabBarController.h
//  CustomTabBarController
//
//  Created by Hu Zhiqiang on 22/05/2012.
//  Copyright (c) 2012 __My Computer__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCustomTabBar.h"
#import "BaseWKWebViewController.h"

@protocol ZJWebChangeIndexDelegate;

@interface ZJCustomTabWebController : BaseWKWebViewController <ZJCustomTabBarDelegate>{
	ZJCustomTabBar        *_tabBar;
	NSUInteger      _selectedIndex;
}
@property(nonatomic) NSUInteger selectedIndex;
@property (nonatomic, retain) ZJCustomTabBar *tabBar;
@property (nonatomic, weak) id <ZJWebChangeIndexDelegate> changeIndexDelegate;

-(CGFloat)getTabbarTop;

- (void)hiddenTabBar:(BOOL)hidden isAnimat:(BOOL)isAnimat;

-(void)tabBarDidHide:(BOOL)hidden;

@end

@protocol ZJWebChangeIndexDelegate<NSObject>
@optional

- (BOOL)customTabBar:(ZJCustomTabWebController *)tabBar shouldSelectIndex:(NSInteger)index;
- (void)customTabBar:(ZJCustomTabWebController *)tabBar didSelectIndex:(NSInteger)index;

@end

