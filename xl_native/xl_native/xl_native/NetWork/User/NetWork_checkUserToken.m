//
//  NetWork_checkUserToken.m
//  xl_native
//
//  Created by MAC on 2018/10/18.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_checkUserToken.h"

@implementation CheckUserTokenRespone

@end

@implementation NetWork_checkUserToken

-(Class)responseType{
    return [CheckUserTokenRespone class];
}
-(NSString*)responseCategory{
    return @"/user/appuser/checkUserToken";
}

@end
