//
//  SLGlobalDefines.h
//  SLSDK
//
//  Created by songlei on 15/5/15.
//  Copyright (c) 2015年 songlei. All rights reserved.
//

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#pragma mark -Cache and Downloads

#define CACHE_ROOT_FOLDER @"WCCache"
#define CACHE_RESOURCE_FOLDER @"resource"
#define CACHE_MULTIMEDIA_FOLDER @"multimedia"
#define CACHE_MULTIMEDIA_WEBPAGE_FOLDER @"webPage"
#define CACHE_DOWNLOAD_TMP_FOLDER @"downloadTmp"
#define CACHE_LOG_FOLDER @"log"

#define JR_APP_USER_APP_USER_LATITUDE      @"JR_APP_USER_APP_USER_LATITUDE"
#define JR_APP_USER_APP_USER_LONGITUDE      @"JR_APP_USER_APP_USER_LONGITUDE"


#define ZJ_APP_USER_APP_SOURCE_TOKEN            @"ZJ_APP_USER_APP_SOURCE_TOKEN"
#define ZJ_APP_USER_APP_PROJECT_ID              @"ZJ_APP_USER_APP_PROJECT_ID"
#define ZJ_APP_USER_APP_PROJECT_ID_OWNER        @"ZJ_APP_USER_APP_PROJECT_ID_OWNER"

#define ZJ_APP_USER_APP_SOURCE_URL              @"ZJ_APP_USER_APP_SOURCE_URL"
#define ZJ_APP_USER_APP_USER_PHONE              @"ZJ_APP_USER_APP_USER_PHONE"



#ifndef SLGlobalDefines_h
#define SLGlobalDefines_h

#import "JSONKit.h"
#import "WCNetworkOperationProvider.h"

#import "WCBaseContext.h"
#import "UIDevice+Hardware.h"
#import "WCBaseConfiguration.h"
#import "WCPlistHelper.h"
#import "ASIHTTPRequest.h"
#import "WCServiceBase.h"
#import "Reachability.h"

#import "NSString+RAS.h"
#import "NSString+Extension.h"
#import "NSString+Encryption.h"
#import "NSString+trim.h"
#import "NSString+URLEncoding.h"
#import "UIDevice+Hardware.h"
#import "UIImage+Category.h"
#import "UIColor+Category.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "SL_Utils.h"
//#import "NSObject+JSON.h"
//#import "NSDictionary+JSON.h"

#endif
