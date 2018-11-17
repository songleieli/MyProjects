//
//  NSString+Encryption.m
//  ProjectStructure
//
//  Created by zhangfeng on 13-10-11.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import "NSString+Encryption.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Encryption)
- (NSString *)hashWithDigestType:(JKStringDigestType)type {
    const char *s = [self UTF8String];
    NSUInteger digestLength;
    unsigned char * (*digestFunction)(const void *, CC_LONG, unsigned char *) = NULL;
    
    switch (type) {
        case JKStringDigestTypeMD5:
            digestLength = CC_MD5_DIGEST_LENGTH;
            digestFunction = CC_MD5;
            break;
        case JKStringDigestTypeSHA1:
            digestLength = CC_SHA1_DIGEST_LENGTH;
            digestFunction = CC_SHA1;
            break;
        case JKStringDigestTypeSHA512:
            digestLength = CC_SHA512_DIGEST_LENGTH;
            digestFunction = CC_SHA512;
            break;
    }
    
    unsigned char result[digestLength];
    digestFunction(s, (CC_LONG)strlen(s), result);
    
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:(digestLength*2)];
    for (NSUInteger i = 0; i < digestLength; i++)
        [digest appendFormat:@"%02x",result[i]];
    
    return [NSString stringWithString:digest];
    
}

- (NSString *)MD5
{
    /*
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
     */
    return [self hashWithDigestType:JKStringDigestTypeMD5];
}

- (NSString *)SHA1{
    return [self hashWithDigestType:JKStringDigestTypeSHA1];
}

- (NSString *)SHA512{
    return [self hashWithDigestType:JKStringDigestTypeSHA512];
}
@end
