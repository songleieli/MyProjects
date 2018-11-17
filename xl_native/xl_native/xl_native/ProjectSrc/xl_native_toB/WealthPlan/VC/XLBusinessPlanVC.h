//
//  XLBusinessPlanVC.h
//  xl_native
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "TBCustomTabViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLBusinessPlanVC : TBCustomTabViewController

@property (copy, nonatomic) void (^totallBlock)(NSInteger total);

@end

NS_ASSUME_NONNULL_END
