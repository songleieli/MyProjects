//
//  SRFootView.h
//  SlimeRefresh
//
//  Created by zhaoweibing on 14-4-23.
//  Copyright (c) 2014年 zrz. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import <UIKit/UIKit.h>

@interface SRFootView : UIView

@property (nonatomic, strong) UILabel *labelFootState;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end
