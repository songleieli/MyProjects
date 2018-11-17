//
//  AddIntegralTool.m
//  xl_native
//
//  Created by MAC on 2018/9/21.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "AddIntegralTool.h"

@implementation AddIntegralTool

static AddIntegralTool *instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
- (void)addIntegral:(BaseViewController *)vc code:(NSString *)code{

        NetWork_addIntegral *request = [[NetWork_addIntegral alloc] init];
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        request.code = code;
        [request startPostWithBlock:^(AddIntegralRespone *result, NSString *msg, BOOL finished) {
            if(!finished){
                if (vc != nil) {
                    [vc showFaliureHUD:msg];
                }
            }
        }];
}

@end
