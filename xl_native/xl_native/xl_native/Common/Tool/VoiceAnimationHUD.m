//
//  VoiceAnimationHUD.m
//  xl_native
//
//  Created by MAC on 2018/9/20.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "VoiceAnimationHUD.h"

@implementation VoiceAnimationHUD

+ (void)showDefault:(NSString *)msg success:(BOOL)success
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    if (success) {
        [SVProgressHUD showSuccessWithStatus:msg];
    } else {
        [SVProgressHUD showErrorWithStatus:msg];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}
+ (void)showAnimation
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:CGFLOAT_MAX];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@""];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

@end
