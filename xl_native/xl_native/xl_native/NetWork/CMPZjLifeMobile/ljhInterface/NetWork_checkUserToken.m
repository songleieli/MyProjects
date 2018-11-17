//
//  NetWork_checkUserToken.m
//  CMPLjhMobile
//
//  Created by sl on 16/6/21.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_checkUserToken.h"

@implementation CheckUserTokenRepsone

@end

@implementation NetWork_checkUserToken

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [CheckUserTokenRepsone class];
}
-(NSString*)responseCategory{
    return @"/user//appuser/checkUserToken";
}

@end
