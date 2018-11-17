//
//  NetWork_ activityCommentList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_appuser_oauth.h"




@implementation AppUserOauthRespone


@end


@implementation NetWork_appuser_oauth

-(Class)responseType{
    return [AppUserOauthRespone class];
}

-(NSString*)responseCategory{
    return @"/user/st/appuser/oauth";
}


@end
