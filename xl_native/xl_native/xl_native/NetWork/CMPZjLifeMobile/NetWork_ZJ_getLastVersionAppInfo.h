//
//  NetWork_ZJ_getLastVersionAppInfo
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/7/13.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Ljh.h"

@interface GetLastVersionAppInfoData : IObjcJsonBase

@property(nonatomic,strong) NSString * version;
@property(nonatomic,strong) NSString * url;
@property(nonatomic,strong) NSString * appContent;
@property(nonatomic,strong) NSString * ismupdatel;
@property(nonatomic,strong) NSString * versionFlag;

@end


@interface GetLastVersionAppInfoRespone : IObjcJsonBase

@property(nonatomic,strong) NSString * status;
@property(nonatomic,strong) NSString * message;
@property(nonatomic,strong) GetLastVersionAppInfoData * data;


@end


@interface NetWork_ZJ_getLastVersionAppInfo : WCServiceBase_Ljh

@property(nonatomic,strong) NSString * appName;
@property(nonatomic,strong) NSString * appType;
@property(nonatomic,strong) NSString * version;

@end
