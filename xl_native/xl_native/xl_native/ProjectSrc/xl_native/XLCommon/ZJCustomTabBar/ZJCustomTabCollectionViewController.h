//
//  CustomTabBarController.h
//  CustomTabBarController
//
//  Created by Hu Zhiqiang on 22/05/2012.
//  Copyright (c) 2012 __My Computer__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJCustomTabBar.h"
#import "BaseCollectionController.h"

@protocol ChangeIndexDelegate;

@interface ZJCustomTabCollectionViewController : BaseCollectionController <ZJCustomTabBarDelegate>{
	ZJCustomTabBar        *_tabBar;
	NSUInteger      _selectedIndex;
    
    
}
@property(nonatomic) NSUInteger selectedIndex;
@property (nonatomic, retain) ZJCustomTabBar *tabBar;
@property (nonatomic, weak) id <ChangeIndexDelegate> changeIndexDelegate;

-(CGFloat)getTabbarTop;
- (void)hiddentabBar:(BOOL)hidden isAnimat:(BOOL)isAnimat;

@end

@protocol ChangeIndexDelegate<NSObject>
@optional

- (BOOL)customTabBar:(ZJCustomTabCollectionViewController *)tabBar shouldSelectIndex:(NSInteger)index;
- (void)customTabBar:(ZJCustomTabCollectionViewController *)tabBar didSelectIndex:(NSInteger)index;

@end

