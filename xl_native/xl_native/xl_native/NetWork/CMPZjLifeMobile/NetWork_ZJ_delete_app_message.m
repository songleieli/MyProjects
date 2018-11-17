//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_delete_app_message.h"

@implementation ZjDeleteAppMessageRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"result" : @"ZjGetMessageListModel"};
//}

@end

@implementation NetWork_ZJ_delete_app_message

-(Class)responseType{
    return [ZjDeleteAppMessageRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/message_lists/delete_app_message";
}

@end
