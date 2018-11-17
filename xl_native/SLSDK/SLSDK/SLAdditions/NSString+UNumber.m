//
//  NSString+UNumber.m
//  中酒批
//
//  Created by ios on 14-2-10.
//  Copyright (c) 2014年 Ios. All rights reserved.
//

#import "NSString+UNumber.h"

@implementation NSString (UNumber)

- (NSString*)replaceUNumber

{
    NSString *tempStr0 = [(NSString *)self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr1 = [tempStr0 stringByReplacingOccurrencesOfString:@"\%u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                           mutabilityOption:NSPropertyListImmutable
                           
                                                                     format:NULL
                           
                                                           errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}

@end
