//
//  NickNameViewController.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "MyFansCell.h"

@interface MyFansViewController : BaseTableMJViewController

@property (copy, nonatomic) NSString *userId;///< 个人信息id
@property(nonatomic,strong) NSMutableArray *listDataArray;

@end
