//
//  NetWork_ activityCommentList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_getSourceToken.h"



@implementation ZjSourceTokenModel




@end


@implementation ZjGetSourceTokenRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZjSourceTokenModel"};
}
@end


@implementation NetWork_ZJ_getSourceToken

-(Class)responseType{
    return [ZjGetSourceTokenRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/user/getSourceToken";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    
    return @"appNameOwner";
}


@end
