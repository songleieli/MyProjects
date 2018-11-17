//
//  NetWork_uploadIcon.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_uploadIcon.h"

@implementation UploadIconRespone


@end

@implementation NetWork_uploadIcon

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [UploadIconRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/appuser/uploadIcon";
}

@end
