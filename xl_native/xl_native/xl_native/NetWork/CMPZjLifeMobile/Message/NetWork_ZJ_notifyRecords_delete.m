//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_notifyRecords_delete.h"


@implementation ZjNotifyRecordsDeleteRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"data" : @"ZjGetMessageReadTempModel"};
//}

@end

@implementation NetWork_ZJ_notifyRecords_delete


-(Class)responseType{
    return [ZjNotifyRecordsDeleteRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/notifyRecords/delete";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    
    return @"appNameOwner";
}

@end
