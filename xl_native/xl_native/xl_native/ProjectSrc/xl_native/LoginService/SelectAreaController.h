//
//  NickNameViewController.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "AreaCell.h"


@class RegisterViewController;

@interface SelectAreaController : BaseTableMJViewController

/*上一级Area，如果为nil说明是跟节点*/
@property(nonatomic,strong) SonElementModel* parentModel;

@property(nonatomic,strong) UIButton * btnBind;

@property(nonatomic,strong) NSMutableArray *listDataArray;




@end
