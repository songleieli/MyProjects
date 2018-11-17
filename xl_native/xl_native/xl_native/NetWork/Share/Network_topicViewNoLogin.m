//
//  Network_topicViewNoLogin.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/28.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "Network_topicViewNoLogin.h"

@implementation ListNoLoginModel


@end

@implementation ImagesNoLoginModel


@end

@implementation CommentsNoLoginModel
- (NSDictionary *)propertyMappingObjcJson {
    return @{@"list" : @"list"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"list" : @"ListNoLoginModel"};
}

@end


@implementation topicViewNoLoginModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"images" : @"images",@"comments":@"comments"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"images" : @"ImagesNoLoginModel",@"comments":@"CommentsNoLoginModel"};
}
@end

@implementation topicViewNoLoginResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"topicViewNoLoginModel"};
}

@end

@implementation Network_topicViewNoLogin
-(Class)responseType{
    
    return [topicViewNoLoginResponse class];
}
-(NSString*)responseCategory{
    return @"/user/neighborhood/topicView";
}
@end
