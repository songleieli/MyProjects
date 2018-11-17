//
//  NSString+URLEncoding.m
//  迪信通Cloud
//
//  Created by user on 13-1-23.
//  Copyright (c) 2013年 eastedge. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)urlEncodedString
{  
    CFStringRef encodedCFString = 
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  
                                            (CFStringRef)self,  
                                            NULL,  
                                            CFSTR("!*'();:@&=+$,/?%#[] "),
//                                            CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                            kCFStringEncodingUTF8);
    NSString *encodedString = (NSString *)CFBridgingRelease(encodedCFString);
    NSString *result = @"";
    if (encodedCFString) {
        result = [[NSString alloc] initWithString:encodedString];
    }
    encodedCFString = nil;
    
    return result;
}  

- (NSString*)urlDecodedString
{
//    NSMutableString *outputStr = [NSMutableString stringWithString:self];
//    [outputStr replaceOccurrencesOfString:@"+"
//                               withString:@" "
//                                  options:NSLiteralSearch
//                                    range:NSMakeRange(0, [outputStr length])];
//    
//    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    CFStringRef decodedCFString = 
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,  
                                                            (CFStringRef)self,  
                                                            CFSTR(""),  
                                                            kCFStringEncodingUTF8);
    
    NSString *decodedString = (NSString *)CFBridgingRelease(decodedCFString);
    NSString *result = @"";
    if (decodedString) {
        result = [[NSString alloc] initWithString:decodedString];
        result = [result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }

    return result;
}

@end
