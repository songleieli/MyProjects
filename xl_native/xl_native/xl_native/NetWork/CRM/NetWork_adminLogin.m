//
//  NetWork_ activityCommentList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_adminLogin.h"

@implementation AdminLoginCommunityListModel

@end

@implementation AdminLoginModel

@end

@implementation AdminLoginRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"AdminLoginModel"};
}

@end


@implementation NetWork_adminLogin

-(Class)responseType{
    return [AdminLoginRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/user/adminLogin";
}


@end
