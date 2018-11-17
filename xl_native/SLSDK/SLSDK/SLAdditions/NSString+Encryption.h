//
//  NSString+Encryption.h
//  ProjectStructure
//
//  Created by zhangfeng on 13-10-11.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

typedef enum {
    JKStringDigestTypeMD5,
    JKStringDigestTypeSHA1,
    JKStringDigestTypeSHA512
} JKStringDigestType;

//加密算法
@interface NSString (Encryption)
- (NSString *)hashWithDigestType:(JKStringDigestType)type;
- (NSString *)MD5;
- (NSString *)SHA1;
- (NSString *)SHA512;
@end
