//
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/17.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_getImgCode.h"


@implementation GetImgCodeRespone



@end



@implementation NetWork_getImgCode


- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}


-(Class)responseType{
    return [GetImgCodeRespone class];
}

-(NSString*)responseCategory{
    return @"/common/get/imgCode";
}


@end
