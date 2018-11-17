//
//  XLVoiceSingleTool.m
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLVoiceSingleTool.h"

@implementation XLVoiceSingleTool

static XLVoiceSingleTool *instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        instance.voiceFirstClick = 0;
    });
    return instance;
}

@end
