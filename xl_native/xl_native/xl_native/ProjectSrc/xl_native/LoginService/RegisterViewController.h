//
//  RegisterViewController.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/17.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "SelectAreaController.h"

#import "NetWork_registerAccount.h"

@interface RegisterViewController : ZJBaseViewController

/*选择区域*/
@property(nonatomic,strong) NSMutableArray *listSelectArea;
/*村委会model*/
@property(nonatomic,strong) SonElementModel* lastModel;


- (void)didSelectArea;

@end
