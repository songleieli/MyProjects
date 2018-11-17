//
//  XLTBSingleTool.m
//  xl_native_toB
//
//  Created by MAC on 2018/11/1.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLTBSingleTool.h"

@implementation XLTBSingleTool

static XLTBSingleTool *instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

@end
