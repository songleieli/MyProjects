//
//  CustomTabBarController.h
//  CustomTabBarController
//
//  Created by Hu Zhiqiang on 22/05/2012.
//  Copyright (c) 2012 __My Computer__. All rights reserved.
//

#import "TBCustomTabBar.h"
#import "TBBaseWKWebViewController.h"

@protocol TBWebChangeIndexDelegate;

@interface TBCustomTabWebController : TBBaseWKWebViewController <ZJCustomTabBarDelegate>{
	TBCustomTabBar        *_tabBar;
	NSUInteger      _selectedIndex;
}
@property(nonatomic) NSUInteger selectedIndex;
@property (nonatomic, retain) TBCustomTabBar *tabBar;
@property (nonatomic, weak) id <TBWebChangeIndexDelegate> changeIndexDelegate;

-(CGFloat)getTabbarTop;

- (void)hiddenTabBar:(BOOL)hidden isAnimat:(BOOL)isAnimat;

-(void)tabBarDidHide:(BOOL)hidden;

@end

@protocol TBWebChangeIndexDelegate<NSObject>
@optional

- (BOOL)customTabBar:(TBCustomTabWebController *)tabBar shouldSelectIndex:(NSInteger)index;
- (void)customTabBar:(TBCustomTabWebController *)tabBar didSelectIndex:(NSInteger)index;

@end

