//
//  NetWork_ deleteTopic.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_deleteComment.h"

@implementation DeleteCommentResponse


@end
@implementation NetWork_deleteComment
- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [DeleteCommentResponse class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/deleteComment";
}

@end
