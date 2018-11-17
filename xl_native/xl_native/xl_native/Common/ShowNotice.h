//
//  ShowNotice.h
//  中酒批
//
//  Created by zhaoweibing on 14-4-25.
//  Copyright (c) 2014年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowNotice : UIView

+ (ShowNotice *)showView:(UIView *)view frame:(CGRect)frame msg:(NSString *)msg;
- (void)hideNoticeAnimated:(BOOL)animated;
- (void)setNoticeMsg:(NSString*)msg;

@end
