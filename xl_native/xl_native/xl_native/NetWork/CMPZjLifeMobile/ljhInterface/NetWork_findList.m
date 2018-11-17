//
//  NetWork_findList.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_findList.h"

@implementation FindListModel

@end

@implementation FindListRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"FindListModel"};
}

@end


@implementation NetWork_findList



- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}


-(Class)responseType{
    return [FindListRespone class];
}

-(NSString*)responseCategory{
    return @"/user/st/attentionCommunityUser/findList";
}

@end
