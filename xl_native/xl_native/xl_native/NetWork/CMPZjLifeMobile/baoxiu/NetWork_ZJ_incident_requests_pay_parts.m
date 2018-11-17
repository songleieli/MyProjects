//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_incident_requests_pay_parts.h"


@implementation ZjIncidentRequestsPayPartsModel


@end

@implementation ZjIncidentRequestsPayPartsTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"pay_parts" : @"pay_parts"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"pay_parts" : @"ZjIncidentRequestsPayPartsModel"};
}

@end


@implementation ZjIncidentRequestsPayPartsRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjIncidentRequestsPayPartsTempModel"};
}

@end

@implementation NetWork_ZJ_incident_requests_pay_parts

-(Class)responseType{
    return [ZjIncidentRequestsPayPartsRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests/pay_parts";
}

@end
