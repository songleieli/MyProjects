//
//  NetWork_ activityCommentList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_login.h"




@implementation LoginDataModel


@end


@implementation ZjLoginRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"LoginDataModel"};
}
@end


@implementation NetWork_login

-(Class)responseType{
    return [ZjLoginRespone class];
}

-(NSString*)responseCategory{
    return @"/user/appuser/login";
}


@end
