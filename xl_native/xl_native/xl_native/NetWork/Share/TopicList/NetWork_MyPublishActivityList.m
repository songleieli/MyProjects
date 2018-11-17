//
//  NetWork_MyPublishActivityList.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/13.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_MyPublishActivityList.h"
#import "Network_hotTopicList.h"

@implementation NetWork_MyPublishActivityList

-(Class)responseType{
    
    return [allTopicListLoginResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/neighborhood/myTopicList";
}

@end
