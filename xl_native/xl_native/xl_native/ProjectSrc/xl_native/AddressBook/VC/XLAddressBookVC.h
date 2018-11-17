//
//  XLAddressBookVC.h
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLAddressBookVC : ZJBaseViewController

@property (copy, nonatomic) NSString *uid; 
@property (assign, nonatomic) NSInteger vcType; ///< 1:邀请好友 2:我的粉丝

@end

NS_ASSUME_NONNULL_END
