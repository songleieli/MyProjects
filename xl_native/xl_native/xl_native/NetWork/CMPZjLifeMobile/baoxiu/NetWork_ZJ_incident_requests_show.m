//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_incident_requests_show.h"


@implementation ZjIncidentRequestsShowModel


@end


@implementation ZjIncidentRequestsShowRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjIncidentRequestsShowModel"};
}

@end

@implementation NetWork_ZJ_incident_requests_show

-(Class)responseType{
    return [ZjIncidentRequestsShowRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests/show";
}

@end
