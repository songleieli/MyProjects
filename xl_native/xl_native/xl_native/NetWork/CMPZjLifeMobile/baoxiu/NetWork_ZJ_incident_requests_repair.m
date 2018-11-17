//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_incident_requests_repair.h"


@implementation ZjIncidentRequestsRepairModel


@end


@implementation ZjIncidentRequestsRepairRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjIncidentRequestsRepairModel"};
}

@end

@implementation NetWork_ZJ_incident_requests_repair

-(Class)responseType{
    return [ZjIncidentRequestsRepairRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests/repair";
}

@end
