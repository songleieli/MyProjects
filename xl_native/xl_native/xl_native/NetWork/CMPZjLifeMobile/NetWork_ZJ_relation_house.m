//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_relation_house.h"

@implementation ZjRelationHouseRespone

@end

@implementation NetWork_ZJ_relation_house

-(Class)responseType{
    return [ZjRelationHouseRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/lejiahui_oauth/relation_house";
}

@end
