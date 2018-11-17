//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_incident_requests_done.h"



@implementation ZjIncidentRequestsDoneRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

//- (NSDictionary *)classNameForItemInArray {
//    return @{@"result" : @"ZjMaterialsSignTempModel"};
//}

@end

@implementation NetWork_ZJ_incident_requests_done

-(Class)responseType{
    return [ZjIncidentRequestsDoneRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests/incident_done";
}

@end
