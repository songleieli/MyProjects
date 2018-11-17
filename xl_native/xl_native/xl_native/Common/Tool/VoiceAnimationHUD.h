//
//  VoiceAnimationHUD.h
//  xl_native
//
//  Created by MAC on 2018/9/20.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceAnimationHUD : NSObject


/**
 错误/成功信息提示
 */
+ (void)showDefault:(NSString *)msg success:(BOOL)success;

+ (void)showAnimation;

+ (void)dismiss;

@end
