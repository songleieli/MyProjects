//
//  NetWork_allTopicList.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "Network_followTopicList.h"


@implementation Network_followTopicList

-(Class)responseType{
    
    return [allTopicListLoginResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/neighborhood/classifyTopicList";
}

@end
