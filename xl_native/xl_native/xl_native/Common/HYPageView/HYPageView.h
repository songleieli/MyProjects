//
//  HYPageView.h
//  HYNavigation
//
//  Created by runlhy on 16/9/27.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYPageViewDelegate;


@interface HYPageView : UIScrollView

// Personalized configuration properties
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *unselectedColor;
@property (nonatomic, strong) UIColor *topTabScrollViewBgColor;
@property (nonatomic, strong) UIColor *topTabBottomLineColor;

@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat rightSpace;
@property (nonatomic, assign) CGFloat minSpace;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (strong, nonatomic) NSMutableArray *strongArray;
@property (assign, nonatomic) NSInteger      currentPage;
@property (nonatomic, weak) id <HYPageViewDelegate> delegate;



/**
 default YES.
 */
@property (nonatomic, assign) BOOL isAdapteNavigationBar;
/**
 default NO.
 */
@property (nonatomic, assign) BOOL isAnimated;
/**
 default YES.
 */
@property (nonatomic, assign) BOOL isTranslucent;
/**
 default YES ,Valid when only one page can be filled with all buttons
 */
@property (nonatomic, assign) BOOL isAverage;
/**
 Initializes and returns a newly allocated view object with the specified frame rectangle.
 
 @param frame       ...
 @param titles      Some title
 @param controllers Name of some controllers
 @param parameters  You need to set a property called "parameter" for your controller to receive.

 @return self
 */

/*
 *一个参数parameter 的写法
 */
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewControllers:(NSArray *)controllers withParameters:(NSArray *)parameters;

//- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewControllers:(NSArray *)controllers withParameters:(NSArray *)parameters withParametersDic:(NSArray*)withParametersDic;

/*
 *一个参数parameter 的写法 用 NSDictionary 来取代 parameter
 */
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewControllers:(NSArray *)controllers  withParametersDic:(NSArray*)withParametersDic;

@end


@protocol HYPageViewDelegate<NSObject>
@optional
- (void)pageView:(HYPageView *)tabBar didSelectIndex:(NSInteger)index;
@end

