//
//  Network_publishTopic.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "Network_publishTopic.h"



@implementation publishTopicintegralResultModel



@end

@implementation publishTopicModel

- (NSDictionary *)classNameForItemInArray {
    return @{@"integralResult" : @"publishTopicintegralResultModel"};
}
@end



@implementation publishTopicResponse

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"publishTopicModel"};
}

@end


@implementation Network_publishTopic

-(Class)responseType{
    
    return [publishTopicResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/neighborhood/publishTopic";
}



@end
