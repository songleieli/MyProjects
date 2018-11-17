//
//  XLPlanDetailVC.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "TBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLPlanDetailVC : TBBaseViewController

@property (copy, nonatomic) NSString *planId;
@property (assign, nonatomic) NSInteger type; ///< 1:种植 2:养殖 3:创业

@end

NS_ASSUME_NONNULL_END
