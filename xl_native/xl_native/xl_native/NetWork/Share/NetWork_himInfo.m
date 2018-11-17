//
//  NetWork_himInfo.m
//  xl_native
//
//  Created by MAC on 2018/10/12.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_himInfo.h"

@implementation HimInfoModel

@end

@implementation HimInfoRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"HimInfoModel"};
}

@end

@implementation NetWork_himInfo

-(Class)responseType{
    return [HimInfoRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/appuser/getHimInfo";
}

@end
