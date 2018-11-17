//
//  ModifyPasswordViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/25.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "NetWork_updatePassword.h"

//#import "ViewAppSetViewController.h" //修改设置

@interface ModifyPasswordViewController ()<UITextFieldDelegate>

/** 原密码 */
@property(nonatomic,strong) UITextField * textFieldPassWord;

/** 新密码 */
@property(nonatomic,strong) UITextField * textFieldNewPass;

@property(nonatomic,assign)BOOL startOne;
@property(nonatomic,assign)BOOL startTwo;


@end

@implementation ModifyPasswordViewController

-(void)initNavTitle{
    [super initNavTitle];
    self.title = @"修改密码";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBFromColor(0xecedf1);
    [self creatUI];
}



-(void)creatUI{
    self.view.backgroundColor = RGBFromColor(0xf6f6f6);
    
// 创建bgView
    UIView * viewBg = [[UIView alloc]init];
    viewBg.size = [UIView getSize_width:ScreenWidth height:ScreenHeight - 12-kNavBarHeight_New];
    viewBg.top = 12 + self.navBackGround.bottom;
    viewBg.left = 0;
    viewBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewBg];
//  原密码View
    UIView * viwePassWordBg = [[UIView alloc]init];
    viwePassWordBg.size = [UIView getSize_width:viewBg.width height:63];
    viwePassWordBg.left = 21;
    
    [viewBg addSubview: viwePassWordBg];
    self.textFieldPassWord = [[UITextField alloc]init];
    self.textFieldPassWord.size = [UIView getSize_width:viwePassWordBg.width-21 height:20];
    self.textFieldPassWord.top = (viwePassWordBg.height - self.textFieldPassWord.height)/2;
    self.textFieldPassWord.left = 0;
    self.textFieldPassWord.tag = 10000000;
    self.textFieldPassWord.delegate = self;
    self.textFieldPassWord.font = [UIFont defaultFontWithSize:14];
    self.textFieldPassWord.borderStyle = UITextBorderStyleNone;
    self.textFieldPassWord.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.textFieldNewPass.delegate = self;
    self.textFieldPassWord.placeholder = @"请输入原密码";
    self.textFieldPassWord.secureTextEntry = YES;
    [self.textFieldPassWord addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [viwePassWordBg addSubview:self.textFieldPassWord];
    
//  设置白色线条
    UILabel * colorLable = [[UILabel alloc]init];
    colorLable.frame = [UIView getFrame_x:0 y:viwePassWordBg.height-1 width:viwePassWordBg.width-21*2  height:1];
    colorLable.backgroundColor = RGBFromColor(0xecedf1);
    [viwePassWordBg addSubview:colorLable];
    
//  新密码的View
    // 密码的View  passwordView
    UIView *  viweNewPassword = [[UIView alloc]init];
    viweNewPassword.size = [UIView getSize_width:viewBg.width -21*2 height:63];
    viweNewPassword.left = 21;
    [viewBg addSubView:viweNewPassword frameBottomView:viwePassWordBg offset:0];
    self.textFieldNewPass = [[UITextField alloc]init];
    self.textFieldNewPass.size = [UIView getSize_width:viweNewPassword.width height:20];
    self.textFieldNewPass.top = (viweNewPassword.height - self.textFieldNewPass.height)/2;
    self.textFieldNewPass.left = 0;
    self.textFieldNewPass.tag = 10000001;
    self.textFieldNewPass.borderStyle = UITextBorderStyleNone;
    self.textFieldNewPass.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.textFieldNewPass.placeholder = @"请输入6~20位字母和数字组合的新密码";
    self.textFieldNewPass.font = [UIFont defaultFontWithSize:14];
    [viweNewPassword addSubview:self.textFieldNewPass];
    
    [self.textFieldNewPass addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    UIButton * rightButtonPassWorld = [[UIButton alloc]initWithFrame:CGRectMake(0, 5.5, 17, 17)];
    [rightButtonPassWorld setBackgroundImage:[UIImage imageNamed:@"loginview_hidePassworld"] forState:UIControlStateNormal];
    rightButtonPassWorld.tag = 7777;
    [rightButtonPassWorld addTarget:self action:@selector(rightButtonClcik:) forControlEvents:UIControlEventTouchUpInside];
    self.textFieldNewPass.delegate = self;
    self.textFieldNewPass.rightView = rightButtonPassWorld;
    self.textFieldNewPass.secureTextEntry = YES;
    self.textFieldNewPass.rightViewMode = UITextFieldViewModeAlways;
    UILabel * colorLable2 = [[UILabel alloc]init];
    colorLable2.frame = [UIView getFrame_x:0 y:viweNewPassword.height-1 width:viweNewPassword.width  height:1];
    colorLable2.backgroundColor = RGBFromColor(0xecedf1);
    [viweNewPassword addSubview:colorLable2];

    //创建注册按钮
    UIButton * loginButton = [[UIButton alloc]init];
    loginButton.tag = 192;
    loginButton.enabled = NO;
    [loginButton setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
    loginButton.size = [UIView getSize_width:ScreenWidth-69*2 height:sizeScale(44)];
    loginButton.left = 69;
    [loginButton setTitle:@"提交" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = RGBFromColor(0xaaaaaa);
    loginButton.titleLabel.font = [UIFont defaultFontWithSize:20];
    [loginButton addTarget:self action:@selector(btnClck:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.cornerRadius = sizeScale(6);
    [viewBg addSubView:loginButton frameBottomView:viweNewPassword offset:64];
    
}
-(void)btnClck:(UIButton *)btn{
    
    
    NSString *userPassword = self.textFieldNewPass.text.trim;
    bool pwdResult = IsValidUserPwd(userPassword);

    if(!pwdResult){
        [self showFaliureHUD:@"密码格式有误"];
        return;
    }
    
    NSString * textFieldOldPassword = self.textFieldPassWord.text.trim;
    NSString * textFieldNewPassword = self.textFieldNewPass.text.trim;
    NetWork_updatePassword * updatePassword =[[NetWork_updatePassword alloc]init];
    updatePassword.password = textFieldNewPassword;
    updatePassword.oldPassword = textFieldOldPassword;
    updatePassword.token =[GlobalData sharedInstance].loginDataModel.token;
    [updatePassword showWaitMsg:@"提交中..." handle:self];
    __weak __typeof(self) weakSelf = self;
    [updatePassword startPostWithBlock:^(updatePasswordRespone * result, NSString *msg, BOOL finished) {
           if (finished) {
               [weakSelf showFaliureHUD:msg];
               
               [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
        }
        else{
            [weakSelf showFaliureHUD:msg];
            
        }
    }];
}
-(void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)rightButtonClcik:(UIButton *)btn{
    
    if (!self.textFieldNewPass.secureTextEntry) {
        UIButton * rightButtonPassWorld = (UIButton *)[self.view viewWithTag:4312990];
        [rightButtonPassWorld setBackgroundImage:[UIImage imageNamed:@"loginview_hidePassworld"] forState:UIControlStateNormal];
        self.textFieldNewPass.secureTextEntry = YES;
        
    }else{
        UIButton * rightButtonPassWorld = (UIButton *)[self.view viewWithTag:4312990];
        
        [rightButtonPassWorld setBackgroundImage:[UIImage imageNamed:@"loginpPassworldShow"] forState:UIControlStateNormal];
        self.textFieldNewPass.secureTextEntry = NO;
        
    }
}

#pragma mark- textFiled的代理方法

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITextField * UserTextFile = (UITextField *)[self.view viewWithTag:10000000];
    [UserTextFile resignFirstResponder];
    UITextField * passworldTextFiled = (UITextField *)[self.view viewWithTag:10000001];
    [passworldTextFiled resignFirstResponder];
}

//限制输入框长度不能超过20位
-(void)textFieldDidChange:(UITextField *)textField{
    if (textField == self.textFieldNewPass) {
        if (textField.text.length>=20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (textField == self.textFieldPassWord) {
        if (textField.text.length>=20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}

#pragma mark - textField代理方法

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    UIButton * btn = (UIButton *)[self.view viewWithTag:192];
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
    
    UIButton * btn = (UIButton *)[self.view viewWithTag:192];
    UITextField * textFeildOld = [self.view viewWithTag:10000000];
    UITextField * textFeildNew = [self.view viewWithTag:10000001];
    
    if(range.location == 0 && [string isEqualToString:@""] && textFeildOld.text.length <=1){
        /*
         * textFeildUesr 退格为空
         */
        NSLog(@"关闭");
        [self enableOrNotEnable:NO btn:btn];
        return YES;
    }
    
    if(range.location == 0 && [string isEqualToString:@""] && textFeildNew.text.length <=1){
        /*
         * textFeildPass 退格为空
         */
        
        NSLog(@"关闭");
        [self enableOrNotEnable:NO btn:btn];
        return YES;
    }
    
    if(textFeildOld == textField){
        if(textFeildNew.text.trim.length == 0){
            NSLog(@"关闭");
            [self enableOrNotEnable:NO btn:btn];
            return YES;
        }
        
        NSString *passStr = textFeildNew.text.trim;
        if((passStr > 0 && string.length > 0) || (passStr > 0 && textFeildOld.text.length > 0)){
            NSLog(@"--------启用1-----------");
            self.startOne = YES;
        }
        else{
            self.startOne = NO;
        }
    }
    
    if(textFeildNew == textField){
        if(textFeildOld.text.trim.length == 0){
            NSLog(@"关闭");
            [self enableOrNotEnable:NO btn:btn];
            return YES;
        }
        
        NSString *userStr = textFeildOld.text.trim;
        if((userStr > 0 && string.length > 0) || (userStr > 0 && textFeildNew.text.length > 0)){
            NSLog(@"--------启用2-----------");
            self.startTwo = YES;
        }
        else{
            self.startTwo = NO;
        }
    }
    
    if(self.startOne == YES && textFeildNew.text.length > 0){
        NSLog(@"--------启用-------------");
        [self enableOrNotEnable:YES btn:btn];
    }
    
    if(self.startTwo == YES && textFeildOld.text.length > 0){
        NSLog(@"--------启用-------------");
        [self enableOrNotEnable:YES btn:btn];
    }
    return YES;
}

-(void)enableOrNotEnable:(BOOL)enable btn:(UIButton*)btn{
    if(enable == YES){
        btn.enabled = YES;
        btn.backgroundColor = defaultMainColor;
    }
    else{
        btn.enabled = NO;
        btn.backgroundColor = RGBFromColor(0xaaaaaa);
    }
}

@end
