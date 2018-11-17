//
//  DemoAppDelegate.h
//  
//
//  Created by song leilei on 15/11/13.
//
//

#import <Foundation/Foundation.h>
#import "AppDelegateBase.h"
//#import "CMCsportalRootViewController.h"
//#import "AlerViewJoinCostom.h"





//@class ZJHomeViewController;




@interface CMCsportalAppDelegate : AppDelegateBase


@property (nonatomic, strong) CMCsportalRootViewController *rootViewController;
@property (nonatomic, strong) NSDictionary *dicPushUserInfo;
@property (nonatomic, copy) NSString *pushSourceSystemCommunityId;




+(CMCsportalAppDelegate *)shareApp;

@end
