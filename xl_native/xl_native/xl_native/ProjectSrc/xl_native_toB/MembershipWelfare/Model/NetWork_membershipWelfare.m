//
//  NetWork_membershipWelfare.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NetWork_membershipWelfare.h"

@implementation MembershipWelfareRespone

@end

@implementation NetWork_membershipWelfare

-(Class)responseType{
    return [MembershipWelfareRespone class];
}
-(NSString*)responseCategory{
    return @"/mgt/user/consume/voucher/change";
}

@end
