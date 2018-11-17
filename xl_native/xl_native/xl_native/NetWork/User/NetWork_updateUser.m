//
//  NetWork_updateUser.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/25.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_updateUser.h"

@implementation updateUserRespone



@end


@implementation NetWork_updateUser
-(Class)responseType{
    return [updateUserRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/appuser/updateUser";
}

@end
