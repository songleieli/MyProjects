//
//  DemoAppDelegate.h
//  
//
//  Created by song leilei on 15/11/13.
//
//

#import "AppDelegateBase.h"
#import "TBRootViewController.h"

//#import "AlerViewJoinCostom.h"
//#import "NetWork_ZJ_getLastVersionAppInfo.h"
//#import "NetWork_ZJ_getSourceToken.h"

//#import "WXApi.h"
#import "WeiboSDK.h"

@class ZJHomeViewController;

@interface XlNativeToBDelegate : AppDelegateBase<UIAlertViewDelegate>

@property (nonatomic, strong) TBRootViewController *rootViewController;
@property (nonatomic, strong) NSDictionary *dicPushUserInfo;
@property (nonatomic, copy) NSString *pushSourceSystemCommunityId;

+(XlNativeToBDelegate *)shareApp;

@end
