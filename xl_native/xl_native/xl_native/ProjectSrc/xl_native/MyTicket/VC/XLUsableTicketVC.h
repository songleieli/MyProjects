//
//  XLUsableTicketVC.h
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "BaseViewController.h"

#import "MyWelfareTicketCell_temp.h"

NS_ASSUME_NONNULL_BEGIN


@interface XLUsableTicketVC : BaseTableMJViewController

@property (copy, nonatomic) NSString *isused; ///< 0使用过，1未使用过，2过期

@end

NS_ASSUME_NONNULL_END
