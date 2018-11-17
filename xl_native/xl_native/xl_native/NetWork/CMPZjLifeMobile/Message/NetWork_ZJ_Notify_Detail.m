//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_Notify_Detail.h"

@implementation ZjNotifyDetailModel

@end

//@implementation ZjGetMessageReadTempModel
//
//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"notifyList" : @"notifyList"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"notifyList" : @"ZjGetMessageReadModel"};
//}
//
//@end


@implementation ZjNotifyDetailRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZjNotifyDetailModel"};
}

@end

@implementation NetWork_ZJ_Notify_Detail


-(Class)responseType{
    return [ZjNotifyDetailRespone class];
}

-(NSString*)responseCategory{
    return @"/user/operate/cms/article/detail";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    
    return @"appNameOwner";
}

@end
