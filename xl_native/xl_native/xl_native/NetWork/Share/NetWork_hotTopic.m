//
//  NetWork_hotTopic.m
//  xl_native
//
//  Created by MAC on 2018/10/11.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_hotTopic.h"

//@implementation HotTopicModel
//
//@end

@implementation HotTopicRespone

@end

@implementation NetWork_hotTopic

-(Class)responseType{
    return [HotTopicRespone class];
}
-(NSString*)responseCategory{
    return @"/user/classifytag/sns/info";
}

@end
