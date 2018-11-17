//
//  Network_topicViewLogin.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/28.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "Network_topicViewLogin.h"



@implementation LisLoginModel


@end

@implementation ImageLoginModel


@end

@implementation CommentsLoginModel
- (NSDictionary *)propertyMappingObjcJson {
    return @{@"list" : @"list"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"list" : @"LisLoginModel"};
}

@end

@implementation TopicViewLoginModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"images" : @"images",@"comments":@"comments"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"images" : @"ImageLoginModel",@"comments":@"CommentsLoginModel"};
}
@end

@implementation TopicViewLoginResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"TopicViewLoginModel"};
}

@end

@implementation Network_topicViewLogin
-(Class)responseType{
    
    return [TopicViewLoginResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/neighborhood/topicView";
}
@end
