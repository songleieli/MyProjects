//
//  loginViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/16.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ZJLoginViewController.h"

#import "IHKeyboardAvoiding.h"
#import "ZJLoginService.h"
#import "GTMBase64.h"

#import "NetWork_login.h"




@interface ZJLoginViewController ()<UITextFieldDelegate,YBAttributeTapActionDelegate>{
    
    BOOL _wasKeyboardManagerEnabled;

}



@property(nonatomic,strong)UIButton * btnCancel;
@property(nonatomic,assign)BOOL startOne;
@property(nonatomic,assign)BOOL startTwo;

@property(nonatomic,strong) UIButton * buttonlogin;

@end

@implementation ZJLoginViewController



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
}

-(void)initNavTitle{
    //[super initNavTitle]; //不响应BaseView中的方法
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)creatUI{

    self.view.backgroundColor = [UIColor whiteColor];
    UIView * bgView = [[UIView alloc]init];
    bgView.size = [UIView getSize_width:ScreenWidth-2*21 height:350];
    bgView.top  = sizeScale(70);
    bgView.left = 21;
    [self.view addSubview:bgView];
    
    bgView.backgroundColor = [UIColor clearColor];
    
    UIImageView * iocnImageView =[[UIImageView alloc]init];
    iocnImageView.size = [UIView getSize_width:85 height:85];
    iocnImageView.left = (bgView.width - iocnImageView.width)/2;
    iocnImageView.top = 0;
    iocnImageView.image = [BundleUtil getCurrentBundleImageByName:@"login_icon"]; //[UIImage imageNamed:@"login_icon"];
    iocnImageView.layer.masksToBounds = YES;
    iocnImageView.layer.cornerRadius = 20.0;
    [bgView addSubview:iocnImageView];
    
    UIView * userViwe = [[UIView alloc]init];
    userViwe.size = [UIView getSize_width:bgView.width height:63];
    userViwe.left = 0;
    [bgView addSubView:userViwe frameBottomView:iocnImageView offset:42];
    
    self.textFieldUser = [[UITextField alloc]init];
    self.textFieldUser.size = [UIView getSize_width:userViwe.width height:20];
    self.textFieldUser.top = (userViwe.height - self.textFieldUser.height)/2;
    self.textFieldUser.left = 0;
    self.textFieldUser.tag = 10000;
    self.textFieldUser.delegate =self;
    self.textFieldUser.font = [UIFont defaultFontWithSize:14];
    self.textFieldUser.borderStyle = UITextBorderStyleNone;
    self.textFieldUser.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textFieldUser.placeholder = @"请输入账号";
    
    //test
//    self.textFieldUser.text = @"18210225831";
    
    [self.textFieldPass addTarget:self action:@selector(textFieldEditingDidChange:) forControlEvents:UIControlEventEditingChanged];
    [userViwe addSubview:self.textFieldUser];

    
    
    UILabel *lableUser = [[UILabel alloc]init];
    lableUser.size = [UIView getSize_width:40 height:25];
    lableUser.origin = [UIView getPoint_x:0 y:0];
    lableUser.backgroundColor = [UIColor clearColor];
    lableUser.text = @"账号";
    lableUser.textColor = RGBAlphaColor(167, 167, 167, 1);
    lableUser.font = [UIFont defaultFontWithSize:17];
    
    
    
    
    self.textFieldUser.leftView = lableUser;
    self.textFieldUser.delegate  = self;
    self.textFieldUser.leftViewMode = UITextFieldViewModeAlways;
    
    
    UILabel * colorLable = [[UILabel alloc]init];
    colorLable.frame = [UIView getFrame_x:0 y:userViwe.y-1 width:userViwe.width height:1];
    colorLable.backgroundColor = RGBFromColor(0xecedf1);
    [userViwe addSubview:colorLable];
    

    UIView *  passwordViwe = [[UIView alloc]init];
    passwordViwe.size = [UIView getSize_width:bgView.width height:63];
    passwordViwe.left = 0;
    [bgView addSubView:passwordViwe frameBottomView:userViwe offset:0];
    
    UILabel * passColorLable = [[UILabel alloc]init];
    passColorLable.frame = [UIView getFrame_x:0 y:passColorLable.y-1 width:userViwe.width height:1];
    passColorLable.backgroundColor = RGBFromColor(0xecedf1);
    [passwordViwe addSubview:passColorLable];
    
    self.textFieldPass = [[UITextField alloc]init];
    self.textFieldPass.size = [UIView getSize_width:userViwe.width height:20];
    self.textFieldPass.top = (userViwe.height - self.textFieldPass.height)/2;
    self.textFieldPass.left = 0;
    self.textFieldPass.tag = 10001;
    self.textFieldPass.delegate = self;
    self.textFieldPass.borderStyle = UITextBorderStyleNone;
    self.textFieldPass.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.textFieldPass.placeholder = @"";
    self.textFieldPass.font = [UIFont defaultFontWithSize:14];
    [passwordViwe addSubview:self.textFieldPass];
    
    //test
//    self.textFieldPass.text = @"zhangtao";
    
    [self.textFieldPass addTarget:self action:@selector(textFieldEditingDidChange:) forControlEvents:UIControlEventEditingChanged];

/* 由于不能发送手机短信，暂时先屏蔽忘记密码功能。
    UIButton * forgetButtun = [[UIButton alloc]init];
    forgetButtun.tag = 94;
    forgetButtun.size = [UIView getSize_width:100 height:30];
    forgetButtun.right = passwordViwe.right - 14;
    forgetButtun.titleLabel.font = [UIFont defaultFontWithSize:14];
    forgetButtun.titleLabel.textColor = RGBAlphaColor(70, 73, 82, 1);
    [forgetButtun setTitleEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, -45)];
    [forgetButtun setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButtun addTarget:self action:@selector(btnClck:) forControlEvents:UIControlEventTouchUpInside];
    [forgetButtun setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
    [forgetButtun setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [bgView addSubView:forgetButtun frameBottomView:passwordViwe offset:16];
*/
    
//    //test
//    passwordViwe.backgroundColor = [UIColor redColor];
    
    
    
    UILabel *lablePwd = [[UILabel alloc]init];
    lablePwd.size = [UIView getSize_width:40 height:25];
    lablePwd.origin = [UIView getPoint_x:0 y:0];
    lablePwd.backgroundColor = [UIColor clearColor];
    lablePwd.textColor = RGBAlphaColor(167, 167, 167, 1);
    lablePwd.text = @"密码";
    lablePwd.font = [UIFont defaultFontWithSize:17];
    
    self.textFieldPass.leftView = lablePwd;
    self.textFieldPass.placeholder = @"请输入密码";
    self.textFieldPass.leftViewMode = UITextFieldViewModeAlways;
    UIButton * rightButtonPassWorld = [[UIButton alloc]initWithFrame:CGRectMake(0, 5.5, 17, 17)];
    [rightButtonPassWorld setBackgroundImage:[UIImage imageNamed:@"loginview_hidePassworld"] forState:UIControlStateNormal];
    rightButtonPassWorld.tag = 1000;
    [rightButtonPassWorld addTarget:self action:@selector(rightButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
    self.textFieldPass.delegate = self;
    self.textFieldPass.rightView = rightButtonPassWorld;
    self.textFieldPass.secureTextEntry = YES;
    self.textFieldPass.rightViewMode = UITextFieldViewModeAlways;
    self.textFieldPass.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    
    
    self.buttonlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonlogin.enabled = NO;
    self.buttonlogin.tag = 92;
    self.buttonlogin.size = [UIView getSize_width:passwordViwe.width height:sizeScale(40)];
    self.buttonlogin.left = 0;
    self.buttonlogin.layer.cornerRadius = 20;
    self.buttonlogin.layer.masksToBounds = YES;
    [self.buttonlogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.buttonlogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonlogin.backgroundColor = RGBFromColor(0xaaaaaa);
    self.buttonlogin.titleLabel.font = [UIFont defaultFontWithSize:16];
    [self.buttonlogin addTarget:self action:@selector(btnClck:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubView:self.buttonlogin frameBottomView:passwordViwe offset:66];
    
    [IHKeyboardAvoiding setAvoidingView:self.view withTarget:bgView];
    
    
    
    
    UILabel *lableRegister = [[UILabel alloc]init];
    lableRegister.size = [UIView getSize_width:180 height:25];
    lableRegister.origin = [UIView getPoint_x:(bgView.width-lableRegister.width)/2 y:0];
    lableRegister.backgroundColor = [UIColor clearColor];
//    lableRegister.text = @"还没有账号？我要注册";
    lableRegister.textColor = RGBAlphaColor(167, 167, 167, 1);
    lableRegister.font = [UIFont defaultFontWithSize:16];
    
    NSString *registerStr = @"还没有账号？我要注册";
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:registerStr];
    [attributed addAttribute:NSFontAttributeName
                       value:lableRegister.font
                       range:NSMakeRange(0,registerStr.length)]; //设置字体大小
    [attributed addAttribute:NSForegroundColorAttributeName
                       value:XLColorMainPart
                       range:NSMakeRange(6,4)];//设置颜色标签颜色
    
    lableRegister.attributedText = attributed;
    [lableRegister yb_addAttributeTapActionWithStrings:@[@"我要注册"] delegate:self];
    
    
    [bgView addSubView:lableRegister frameBottomView:self.buttonlogin offset:66];

    
    bgView.height = lableRegister.bottom;
    
    //bgView居中
    bgView.top = (self.view.height - bgView.height)/2;
    
    //test
    //bgView.backgroundColor = [UIColor redColor];
}

- (void)textFieldEditingDidChange:(UITextField *)textField
{
    if (textField == self.textFieldUser) {
        if (textField.text.length>=11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.textFieldPass) {
        if (textField.text.length>=20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }}
-(void)btnClck:(UIButton *)btn{
    
    if(btn.tag == 90){
        [self.view endEditing:YES];
    }
    else if(btn.tag == 91){
        [self.view endEditing:YES];
    }
    else if(btn.tag == 92){
        // 释放键盘
        [self.textFieldPass resignFirstResponder];
        [self.textFieldUser resignFirstResponder];
        
        [self doLoginAction];
    }
    else if(btn.tag == 93){
        [self.view endEditing:YES];
        [self loginCancle];
    }
    else if(btn.tag == 94){ // 忘记密码
        
        [self.view endEditing:YES];
        
//        ZJRetrieveViewController *retrieveViewController = [[ZJRetrieveViewController alloc] init];
//        [self.navigationController pushViewController:retrieveViewController animated:YES];
        
//        ZJForgetPassworldViewController * forgetViewController = [[ZJForgetPassworldViewController alloc]init];
//        [self.navigationController pushViewController:forgetViewController animated:YES];

    }
}

-(void)rightButtonClcik:(UIButton *)btn{
//    [GlobalFunc event:@"event_click_"];
    UITextField * passworldTextFiled = (UITextField *)[self.view viewWithTag:10001];
    
    if (!passworldTextFiled.secureTextEntry) {
        UIButton * rightButtonPassWorld = (UIButton *)[self.view viewWithTag:1000];
        [rightButtonPassWorld setBackgroundImage:[UIImage imageNamed:@"loginview_hidePassworld"] forState:UIControlStateNormal];
        passworldTextFiled.secureTextEntry = YES;
        
    }else{
        UIButton * rightButtonPassWorld = (UIButton *)[self.view viewWithTag:1000];
        [rightButtonPassWorld setBackgroundImage:[UIImage imageNamed:@"loginpPassworldShow"] forState:UIControlStateNormal];
        passworldTextFiled.secureTextEntry = NO;
    }
}

#pragma -mark Custom Method

-(void)gotoRegisterViewController{
    
}

-(void)gotoForgetPasswordViewController{
    
}

-(void)doLoginAction{
    NSString *userName = self.textFieldUser.text.trim;
    NSString *userPassword = self.textFieldPass.text.trim;
    
    
    bool mobileResult = IsValidPhoneNum(userName);
    bool pwdResult = IsValidUserPwd(userPassword);
    
    if(!mobileResult){
        [self showFaliureHUD:@"手机号格式有误"];
        return;
    }
    
    if(!pwdResult){ /*暂时先不验证*/
//        [self showFaliureHUD:@"密码格式有误"];
//        return;
    }
    
    __weak __typeof (self) weakSelf = self;
    NetWork_login *request = [[NetWork_login alloc]init];
    request.mobile = userName;
    request.password = [userPassword RSA];
    [request showWaitMsg:@"加载中......" handle:self];
    [request startPostWithBlock:^(ZjLoginRespone *result, NSString *msg, BOOL finished) {
        if(finished){
            weakSelf.buttonlogin.enabled = NO;
            [weakSelf deal_loginRespones:result userPwd:userPassword];
            [weakSelf loginSuccessful:userName];
        }
        else{
            [weakSelf showFaliureHUD:msg];
            weakSelf.buttonlogin.enabled = YES;
        }
    }];
}


/*处理-登录*/
- (void)deal_loginRespones:(ZjLoginRespone *)loignRespone userPwd:(NSString*)userPwd{
    [GlobalData sharedInstance].hasLogin = YES;
    [GlobalData sharedInstance].loginDataModel = loignRespone.data;
}
//登录成功
- (void)loginSuccessful:(NSString*)userPhone{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationUserLoginSuccess
                                                            object:nil];
    });
    
    if ([ZJLoginService sharedInstance].completeBlock) {
        [ZJLoginService sharedInstance].completeBlock(YES);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//取消成功
- (void)loginCancle{
    if ([ZJLoginService sharedInstance].cancelledBlock) {
        [ZJLoginService sharedInstance].cancelledBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册JPush推送标签
-(void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
    
        NSString *message = [NSString stringWithFormat:@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias];
    
    
//        UIAlertView *alertOne = [[UIAlertView alloc]initWithTitle:@"alias设置成功。" message:message delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//        [alertOne show];
    
}


#pragma mark- YBAttributeTapActionDelegate

- (void)yb_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index{
    NSLog(@"%@",string);
    
    
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}



#pragma mark- textFiled的代理方法

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark - textField代理方法

////限制输入框长度不能超过11位
//-(void)textFieldDidChange:(UITextField *)textField{
//    if (textField == self.textFieldUser) {
//        if (textField.text.length>=11) {
//            textField.text = [textField.text substringToIndex:11];
//        }
//    }
//}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    UIButton * btn = (UIButton *)[self.view viewWithTag:92];
    [self enableOrNotEnable:NO btn:btn];

    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"----------");
    
    if (range.location > 0 && range.length == 1 && string.length == 0){
        /*
         *禁用退格清空
         */
        textField.text = [textField.text substringToIndex:textField.text.length - 1];
        return NO;
    }
    
    
    
    UIButton * btn = (UIButton *)[self.view viewWithTag:92];
    UITextField * textFeildUesr = [self.view viewWithTag:10000];
    UITextField * textFeildPass = [self.view viewWithTag:10001];
    
    if(range.location == 0 && [string isEqualToString:@""] && textFeildUesr.text.length <=1){
        /*
         * textFeildUesr 退格为空
         */
        NSLog(@"关闭");
        [self enableOrNotEnable:NO btn:btn];
        return YES;
    }
    
    if(range.location == 0 && [string isEqualToString:@""] && textFeildPass.text.length <=1){
        /*
         * textFeildPass 退格为空
         */
        
        NSLog(@"关闭");
        [self enableOrNotEnable:NO btn:btn];
        return YES;
    }
    
    if(textFeildUesr == textField){
        if(textFeildPass.text.trim.length == 0){
            NSLog(@"关闭");
            [self enableOrNotEnable:NO btn:btn];
            return YES;
        }
        
        NSString *passStr = textFeildPass.text.trim;
        if((passStr > 0 && string.length > 0) || (passStr > 0 && textFeildUesr.text.length > 0)){
            NSLog(@"--------启用1-----------");
            self.startOne = YES;
        }
        else{
            self.startOne = NO;
        }
    }
    
    if(textFeildPass == textField){
        if(textFeildUesr.text.trim.length == 0){
            NSLog(@"关闭");
            [self enableOrNotEnable:NO btn:btn];
            return YES;
        }
        
        NSString *userStr = textFeildUesr.text.trim;
        if((userStr > 0 && string.length > 0) || (userStr > 0 && textFeildPass.text.length > 0)){
            NSLog(@"--------启用2-----------");
            self.startTwo = YES;
        }
        else{
            self.startTwo = NO;
        }
    }
    
    if(self.startOne == YES && textFeildPass.text.length > 0){
        NSLog(@"--------启用-------------");
        [self enableOrNotEnable:YES btn:btn];
    }
    
    if(self.startTwo == YES && textFeildUesr.text.length > 0){
        NSLog(@"--------启用-------------");
        [self enableOrNotEnable:YES btn:btn];
    }
    return YES;
}

-(void)enableOrNotEnable:(BOOL)enable btn:(UIButton*)btn{
    if(enable == YES){
        btn.enabled = YES;
        //btn.backgroundColor = RGBFromColor(0xfa555c);
        btn.backgroundColor = XLColorMainPart;
    }
    else{
        btn.enabled = NO;
        btn.backgroundColor = RGBFromColor(0xaaaaaa);
    }
}


@end
