//
//  XLMenuView.h
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLMenuView : UIViewController

@property (copy, nonatomic) void (^select)(NSInteger num);

@end

NS_ASSUME_NONNULL_END
