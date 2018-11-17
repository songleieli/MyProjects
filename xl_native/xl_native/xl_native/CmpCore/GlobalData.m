//
//  GloalData.m
//  君融贷
//
//  Created by admin on 15/10/15.
//  Copyright (c) 2015年 JRD. All rights reserved.
//

#import "GlobalData.h"
#import "Reachability.h"
#import "WCBaseContext.h"

//#import "RymView.h"

@interface GlobalData ()

@property(strong) Reachability *hostReach;
//@property(strong) Reachability *internetReach;

@end

@implementation GlobalData

+ (instancetype)sharedInstance{
    
    static GlobalData *SharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(SharedData == nil){
            SharedData = [[self alloc] init];
        }
    });
    return SharedData;
}


- (BOOL)hasLogin {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:LJH_ACCOUNT_USER_HASLOGIN];
}

- (void)setHasLogin:(BOOL)hasLogin {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:hasLogin forKey:LJH_ACCOUNT_USER_HASLOGIN];
    [prefs synchronize];
}

- (BOOL)isNotFirstUse{
    return   [[NSUserDefaults standardUserDefaults] boolForKey:INFO_IS_NOT_FIRST_USER];
}

-(void)setIsNotFirstUse:(BOOL)isNotFirstUse{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:isNotFirstUse forKey:INFO_IS_NOT_FIRST_USER];
    [prefs synchronize];
    
}


-(void)setLatitude:(NSString*)latitude{
    [WCBaseContext sharedInstance].latitude = latitude;
}

-(NSString*)getLatitude{
    return [WCBaseContext sharedInstance].latitude;
}

-(void)setLongitude:(NSString*)longitude{
    [WCBaseContext sharedInstance].longitude = longitude;
}

-(NSString*)getLongitude{
    return [WCBaseContext sharedInstance].longitude;
}

-(LoginDataModel*)getLoginDataModel{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *userAccountStr = [prefs objectForKey:ZJ_APP_USER_LOIGNINFO];
    NSDictionary *userAccountDic = [userAccountStr objectFromJSONString];
    
    
    LoginDataModel *model = [[LoginDataModel alloc] initWithDictionary:userAccountDic];
    
    return model;
}

-(void)setLoginDataModel:(LoginDataModel *)userModel{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(userModel == nil){
        [prefs removeObjectForKey:ZJ_APP_USER_LOIGNINFO];
    }
    else{
        [prefs setObject:[userModel generateJsonStringForProperties] forKey:ZJ_APP_USER_LOIGNINFO];
    }
    [prefs synchronize];
}

/*
 *B端用户信息
 */
-(AdminLoginModel*)getAdminLoginDataModel{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *userAccountStr = [prefs objectForKey:TB_APP_USER_LOIGNINFO];
    NSDictionary *userAccountDic = [userAccountStr objectFromJSONString];
    
    
    AdminLoginModel *model = [[AdminLoginModel alloc]initWithDictionary:userAccountDic];
    
    return model;
}

-(void)setAdminLoginDataModel:(AdminLoginModel *)userModel{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(userModel == nil){
        [prefs removeObjectForKey:TB_APP_USER_LOIGNINFO];
    }
    else{
        [prefs setObject:[userModel generateJsonStringForProperties] forKey:TB_APP_USER_LOIGNINFO];
    }
    [prefs synchronize];
}


+ (void)cleanAccountInfo{
    [GlobalData sharedInstance].hasLogin = NO;
    [GlobalData sharedInstance].loginDataModel = nil;
}



+ (void)deleteWebCache{

    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        //        NSSet *websiteDataTypes
        //
        //        = [NSSet setWithArray:@[
        //
        //                                WKWebsiteDataTypeDiskCache,
        //
        //                                //WKWebsiteDataTypeOfflineWebApplicationCache,
        //
        //                                WKWebsiteDataTypeMemoryCache,
        //
        //                                //WKWebsiteDataTypeLocalStorage,
        //
        //                                //WKWebsiteDataTypeCookies,
        //
        //                                //WKWebsiteDataTypeSessionStorage,
        //
        //                                //WKWebsiteDataTypeIndexedDBDatabases,
        //
        //                                //WKWebsiteDataTypeWebSQLDatabases
        //
        //                                ]];
        
        //// All kinds of data
//
//        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
//
//        //// Date from
//        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
//
//        //// Execute
//        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
//            // Done
//        }];
    }
    else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
    }
}


@end
