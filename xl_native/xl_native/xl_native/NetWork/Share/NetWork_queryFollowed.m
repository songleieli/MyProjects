//
//  NetWork_findAllTagList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_queryFollowed.h"

@implementation QueryFollowedModel


@end

@implementation QueryFollowedTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"followList" : @"followList"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"followList" : @"QueryFollowedModel"};
}

@end

@implementation QueryFollowedResponse

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"data" : @"data"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"QueryFollowedTempModel"};
}



@end


@implementation NetWork_queryFollowed
-(Class)responseType{
    return [QueryFollowedResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/villager/follow/queryFollowed";
}


@end
