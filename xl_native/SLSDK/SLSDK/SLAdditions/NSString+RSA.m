//
//  NSString+trim.m
//  君融贷
//
//  Created by admin on 15/10/10.
//  Copyright (c) 2015年 JRD. All rights reserved.
//

#import "NSString+RAS.h"
#import "RSAEncryptor.h"

@implementation NSString (RAS)


-(NSString*)RSA{
    
    NSString *filePath =  [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    //加密
    return [RSAEncryptor encryptString:self publicKeyWithContentsOfFile:filePath];
    
}

@end
