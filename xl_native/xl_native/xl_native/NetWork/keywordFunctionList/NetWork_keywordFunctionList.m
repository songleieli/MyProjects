//
//  NetWork_keywordFunctionList.m
//  xl_native
//
//  Created by MAC on 2018/9/26.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_keywordFunctionList.h"

@implementation keywordFunctionListRespone

@end

@implementation NetWork_keywordFunctionList

-(Class)responseType{
    return [keywordFunctionListRespone class];
}
-(NSString*)responseCategory{
    return @"/user/keyword/function/list";
}

@end
