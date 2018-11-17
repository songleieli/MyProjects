//
//  ScrollRefreshView.h
//  ZJW
//
//  Created by 中酒批 on 15/5/25.
//  Copyright (c) 2015年 oyxc. All rights reserved.
//

#import "TPKeyboardAvoidingScrollView.h"
#import "SRRefreshView.h"

@protocol SRScrollerViewDelegate;

@interface SRScrollerRefreshView : TPKeyboardAvoidingScrollView

@property (nonatomic, strong, readonly) SRRefreshView *srHeadView;//下拉刷新视图

@property (nonatomic, weak) id<SRScrollerViewDelegate> srdelegate;

- (id)initWithFrame:(CGRect)frame;
- (void)freshFinished;

@end

@protocol SRScrollerViewDelegate <NSObject>

- (void)srScrollerViewLoadDataWithRefresh;

@end
