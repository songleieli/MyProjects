//
//  MyViewTableViewCell.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_addressBookList.h"

#define InvitationCellHeight     sizeScale(50)  //评论title的高度

@interface InvitationCell : UITableViewCell


@property (nonatomic, strong)AaddressBookModel * listModel;
@property (copy, nonatomic) void (^inviteUser)(NSString *userId);



- (void)dataBind:(AaddressBookModel*)model;

+ (NSString*) cellId;


@end
