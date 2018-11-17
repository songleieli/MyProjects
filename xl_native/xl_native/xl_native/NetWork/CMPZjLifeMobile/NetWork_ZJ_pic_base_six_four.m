//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pic_base_six_four.h"


@implementation ZjPicBases64Respone


@end

@implementation NetWork_ZJ_pic_base_six_four

-(Class)responseType{
    return [ZjPicBases64Respone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests/pic_base_six_four";
}

@end
