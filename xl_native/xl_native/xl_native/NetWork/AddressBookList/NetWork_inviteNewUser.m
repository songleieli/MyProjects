//
//  NetWork_inviteNewUser.m
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_inviteNewUser.h"

@implementation InviteNewUserRespone

@end

@implementation NetWork_inviteNewUser

-(Class)responseType{
    return [InviteNewUserRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/sns/invite";
}

@end
