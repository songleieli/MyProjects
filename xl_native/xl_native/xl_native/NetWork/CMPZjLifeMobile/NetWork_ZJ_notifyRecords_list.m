//
//  NetWork_ activityCommentList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_notifyRecords_list.h"



@implementation ZjNotifyRecordsListTempModel


@end


@implementation ZjNotifyRecordsListRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZjNotifyRecordsListTempModel"};
}
@end


@implementation NetWork_ZJ_notifyRecords_list

-(Class)responseType{
    return [ZjNotifyRecordsListRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/notifyRecords/list";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    
    return @"appNameOwner";
}


@end
