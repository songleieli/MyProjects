//
//  NickNameViewController.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "InvitationCell.h"

@interface InvitationViewController : BaseTableMJViewController

@property (copy, nonatomic) NSString *userId;///< 个人信息id
@property(nonatomic,strong) NSMutableArray *listDataArray;

@end
