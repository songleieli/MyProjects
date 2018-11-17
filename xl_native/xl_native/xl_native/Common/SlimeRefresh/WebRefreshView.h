//
//  ScrollRefreshView.h
//  ZJW
//
//  Created by 中酒批 on 15/5/25.
//  Copyright (c) 2015年 oyxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SRWebViewDelegate;

@interface WebRefreshView : UIWebView

@property (nonatomic, weak) id<SRWebViewDelegate> srdelegate;

- (id)initWithFrame:(CGRect)frame;
- (void)freshFinished;

@end

@protocol SRWebViewDelegate <NSObject>

- (void)srWebViewLoadDataWithRefresh;

@end
