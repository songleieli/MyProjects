//
//  loginViewController.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/16.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

//#import "JPUSHService.h"

#import "RegisterViewController.h"

@interface ZJLoginViewController : ZJBaseViewController

/*注册成功后，需要带上手机号 RegisterViewController 中调用*/
@property(nonatomic,strong)UITextField * textFieldUser;//userTextField;
@property(nonatomic,strong)UITextField * textFieldPass;

@end
