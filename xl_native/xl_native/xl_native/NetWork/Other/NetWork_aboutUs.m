//
//  NetWork_aboutUs.m
//  xl_native
//
//  Created by MAC on 2018/10/11.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_aboutUs.h"

@implementation AboutUsModel

@end

@implementation AboutUsRespone

@end

@implementation NetWork_aboutUs

-(Class)responseType{
    return [AboutUsRespone class];
}
-(NSString*)responseCategory{
    return @"/user/operate/cms/article/getByContentType";
}

@end
