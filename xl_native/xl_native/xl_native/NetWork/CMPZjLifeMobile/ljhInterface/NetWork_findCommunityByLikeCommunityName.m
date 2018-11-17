//
//  NetWork_findCommunityByLikeCommunityName.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/20.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_findCommunityByLikeCommunityName.h"

@implementation FindCommunityByLikeCommunityNameModel



@end


@implementation FindCommunityByLikeCommunityNameRespone
- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"FindCommunityByLikeCommunityNameModel"};
}



@end


@implementation NetWork_findCommunityByLikeCommunityName



- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [FindCommunityByLikeCommunityNameRespone class];
}

-(NSString*)responseCategory{
    return @"/user/attentionCommunityUser/findCommunityByLikeCommunityName";
}


@end
