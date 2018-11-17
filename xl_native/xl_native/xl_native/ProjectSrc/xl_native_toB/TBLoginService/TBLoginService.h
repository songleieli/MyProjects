//
//  LoginService.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/16.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseViewController.h"

@interface TBLoginService : NSObject

@property (nonatomic, strong) void (^completeBlock)(BOOL success);

@property (nonatomic, strong) void (^cancelledBlock)(void);

@property (nonatomic, strong) BaseViewController *showMsgTarget;


+ (instancetype)sharedInstance;

- (void)authenticateWithCompletion:(void(^)(BOOL success))complete
                       cancelBlock:(void(^)())cancelBlock
                          isAnimat:(BOOL)isAnimat;

/*
 *扩展方法，showMsgTarget，用于在校验token是显示校验信息
 */
- (void)authenticateWithCompletion:(void(^)(BOOL success))complete
                       cancelBlock:(void(^)())cancelBlock
                     showMsgTarget:(BaseViewController *)showMsgTarget
                          isAnimat:(BOOL)isAnimat;



@end
