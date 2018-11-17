//
//  XLVoiceOrderView.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLVoiceOrderView : UIViewController

@property (strong, nonatomic) OrderListModel *model;

@property (copy, nonatomic) dispatch_block_t reloadTable; 

@end

NS_ASSUME_NONNULL_END
