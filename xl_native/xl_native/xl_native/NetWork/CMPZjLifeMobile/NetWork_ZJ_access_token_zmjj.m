//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_access_token_zmjj.h"

@implementation ZjAccessTokenRespone

@end

@implementation NetWork_ZJ_access_token_zmjj

-(Class)responseType{
    return [ZjAccessTokenRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/lejiahui_oauth/access_token_zmjj";
}

@end
