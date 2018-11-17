//
//  NetWork_topicCommentList.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_topicCommentList.h"


@implementation TopicReplyModel


@end

@implementation TopicCommentListModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"replies" : @"replies"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"replies" : @"TopicReplyModel"};
}

@end


@implementation TopicCommentModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"list" : @"list"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"list" : @"TopicCommentListModel"};
}

@end

@implementation TopicCommentListResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"TopicCommentModel"};
}

@end

@implementation NetWork_topicCommentList

-(Class)responseType{
    return [TopicCommentListResponse class];
}
-(NSString*)responseCategory{
    return @"/user/neighborhood/topicCommentList";
}


@end
