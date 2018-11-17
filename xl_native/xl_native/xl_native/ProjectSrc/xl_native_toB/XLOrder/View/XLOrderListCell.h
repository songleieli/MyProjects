//
//  XLOrderListCell.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const orderListCellID = @"orderListCellID";

NS_ASSUME_NONNULL_BEGIN

@interface XLOrderListCell : UITableViewCell

@property (strong, nonatomic) UserListModel *userListModel; 
@property (strong, nonatomic) OrderListModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *rightImg;

@property (copy, nonatomic) dispatch_block_t voiceBtnclick;

@end

NS_ASSUME_NONNULL_END
