//
//  NSString+trim.m
//  君融贷
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 JRD. All rights reserved.
//

#import "NSString+trim.h"

@implementation NSString (trim)

//消除头尾的空格和换行
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
