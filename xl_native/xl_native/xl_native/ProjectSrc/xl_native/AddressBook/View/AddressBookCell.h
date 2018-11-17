//
//  AddressBookCell.h
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressBookCell : UITableViewCell

@property (strong, nonatomic) AaddressBookModel *model;
@property (strong, nonatomic) MyFansListModel *fansModel;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;

@property (copy, nonatomic) void (^inviteUser)(NSString *userId);

@end

