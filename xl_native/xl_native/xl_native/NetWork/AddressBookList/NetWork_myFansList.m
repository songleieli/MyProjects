//
//  NetWork_myFansList.m
//  xl_native
//
//  Created by MAC on 2018/10/15.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_myFansList.h"

@implementation MyFansListModel

@end

@implementation MyFansListRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"data" : @"data"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"data" : @"MyFansListModel"};
//}

@end

@implementation NetWork_myFansList

-(Class)responseType{
    return [MyFansListRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/villager/follow/queryFollower";
}

@end
