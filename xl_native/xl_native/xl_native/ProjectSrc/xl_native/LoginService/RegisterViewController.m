//
//  RegisterViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/17.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "RegisterViewController.h"



@interface RegisterViewController ()<UITextFieldDelegate>

/** 手机号 */
@property(nonatomic,strong) UITextField * textFieldIphone;
/** 密码 */
@property(nonatomic,strong) UITextField * textFieldPsd;
/** 重复密码 */
@property(nonatomic,strong) UITextField * textFieldRePsd;
/** 选择地区 */
@property(nonatomic,strong) UITextField * textFiledSelectArea;

/** 请输入姓名 */
@property(nonatomic,strong) UITextField * textFiledNRealName;



@property(nonatomic,assign)BOOL startOne;
@property(nonatomic,assign)BOOL startTwo;
/** 确定按钮 */
@property(nonatomic,strong) UIButton *buttonText;

@end

@implementation RegisterViewController

- (NSMutableArray *)listSelectArea{
    
    if (!_listSelectArea) {
        _listSelectArea = [[NSMutableArray alloc] init];
    }
    return _listSelectArea;
}


-(void)initNavTitle{
    
    self.title = @"注册";
    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = RGBFromColor(0xd4d4d4);
    [self.navBackGround addSubview:lineView];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    
    self.isNavBackGroundHiden = NO;
    
    [super viewDidLoad];
    
    [self creatUI];
}


-(void)creatUI{
    
    // 头部分割条
    UILabel * colorLable = [[UILabel alloc]init];
    colorLable.frame = [UIView getFrame_x:0 y:self.navBackGround.bottom width:ScreenWidth height:12];
    colorLable.backgroundColor = RGBFromColor(0xecedf1);
    [self.view addSubview:colorLable];

    UIView * bgView = [[UIView alloc]init];
    bgView.size = [UIView getSize_width:ScreenWidth-2*21 height:450];
    bgView.top  =colorLable.bottom ;
    bgView.left = 21;
    [self.view addSubview:bgView];
    
    

    // 输入手机号的View
    UIView * inPutIphoneNumber = [[UIView alloc]init];
    inPutIphoneNumber.size = [UIView getSize_width:bgView.width height:55];
    inPutIphoneNumber.left = 0;
    inPutIphoneNumber.top  = 0;
    [bgView addSubview:inPutIphoneNumber];
    
    
    self.textFieldIphone = [[UITextField alloc]init];
    self.textFieldIphone.left = 0;
    self.textFieldIphone.size = [UIView getSize_width:inPutIphoneNumber.width-42 height:20];
    self.textFieldIphone.top = (inPutIphoneNumber.height - self.textFieldIphone.height)/2;
    self.textFieldIphone.font = [UIFont defaultFontWithSize:14];
    self.textFieldIphone.borderStyle = UITextBorderStyleNone;
    self.textFieldIphone.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.textFieldIphone.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldIphone.placeholder = @"请输入手机号";
    self.textFieldIphone.delegate  = self;
    
    UILabel * lableSqare = [[UILabel alloc]init];
    lableSqare.backgroundColor = RGBFromColor(0xecedf1);
    lableSqare.size = [UIView getSize_width:inPutIphoneNumber.width height:1];
    lableSqare.top = inPutIphoneNumber.height - 1;
    lableSqare.left = 0;
    [inPutIphoneNumber addSubview:lableSqare];
    [inPutIphoneNumber addSubview:self.textFieldIphone];

    
    //  设置输入密码
    UIView * passworldView = [[UIView alloc]init];
    passworldView.size = [UIView getSize_width:bgView.width height:55];
    passworldView.left = 0;
    [bgView addSubView:passworldView frameBottomView:inPutIphoneNumber];
    
    
    self.textFieldPsd = [[UITextField alloc]init];
    self.textFieldPsd.size = [UIView getSize_width:passworldView.width height:20];
    self.textFieldPsd.top = (passworldView.height - self.textFieldPsd.height)/2;
    self.textFieldPsd.left = 0;
    self.textFieldPsd.tag = 564379;
    self.textFieldPsd.font = [UIFont defaultFontWithSize:14];
    self.textFieldPsd.borderStyle = UITextBorderStyleNone;
    self.textFieldPsd.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.textFieldPsd.placeholder = @"请输入密码";
    self.textFieldPsd.delegate = self;
    self.textFieldPsd.secureTextEntry = YES;
    [passworldView addSubview:self.textFieldPsd];

    /*下划线*/
    UILabel * lablePassworldView = [[UILabel alloc]init];
    lablePassworldView.backgroundColor = RGBFromColor(0xecedf1);
    lablePassworldView.size = [UIView getSize_width:passworldView.width height:1];
    lablePassworldView.top = passworldView.height - 1;
    lablePassworldView.left = 0;
    [passworldView addSubview:lablePassworldView];

    
    //  输入4位数的邀请吗
    UIView * inviteView = [[UIView alloc]init];
    inviteView.size = [UIView getSize_width:bgView.width height:55];
    inviteView.left = 0;
    [bgView addSubView:inviteView frameBottomView:passworldView];
    
    self.textFieldRePsd = [[UITextField alloc]init];
    self.textFieldRePsd.size = [UIView getSize_width:inviteView.width height:20];
    self.textFieldRePsd.top = (inviteView.height - self.textFieldRePsd.height)/2;
    self.textFieldRePsd.left = 0;
    self.textFieldRePsd.font = [UIFont defaultFontWithSize:14];
    self.textFieldRePsd.borderStyle = UITextBorderStyleNone;
//    self.textFieldRePsd.clearButtonMode =UITextFieldViewModeWhileEditingtextFieldRePsd
    self.textFieldRePsd.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldRePsd.placeholder = @"请再一次输入密码";
    [inviteView addSubview:self.textFieldRePsd];
    
    UILabel * lableinviteView = [[UILabel alloc]init];
    lableinviteView.backgroundColor = RGBFromColor(0xecedf1);
    lableinviteView.size = [UIView getSize_width:inviteView.width height:1];
    lableinviteView.top = inviteView.height - 1;
    lableinviteView.left = 0;
    [inviteView addSubview:lableinviteView];
    
    
    
    UIView * verifyCodeView = [[UIView alloc]init];
    verifyCodeView.size = [UIView getSize_width:bgView.width  height:55];
    verifyCodeView.left = 0;
    [bgView addSubView:verifyCodeView frameBottomView:inviteView];
    // 线条
    UILabel * labelVerifyCodeLine = [[UILabel alloc]init];
    labelVerifyCodeLine.size = [UIView getSize_width:bgView.width height:1];
    labelVerifyCodeLine.left = 0;
    labelVerifyCodeLine.top = verifyCodeView.height -1 ;
    labelVerifyCodeLine.backgroundColor =RGBFromColor(0xecedf1);
    [verifyCodeView addSubview:labelVerifyCodeLine];
    
    
    self.textFiledSelectArea = [[UITextField alloc]init];
    self.textFiledSelectArea.size = [UIView getSize_width:verifyCodeView.width height:20];
    self.textFiledSelectArea.top = (verifyCodeView.height - self.textFiledSelectArea.height)/2;
    self.textFiledSelectArea.left = 0;
    self.textFiledSelectArea.tag = 1122;
    self.textFiledSelectArea.delegate = self;
    self.textFiledSelectArea.font = [UIFont defaultFontWithSize:14];
    self.textFiledSelectArea.borderStyle = UITextBorderStyleNone;
    self.textFiledSelectArea.placeholder = @"请选择地区";
    [verifyCodeView addSubview:self.textFiledSelectArea];
    
    [self.textFiledSelectArea addTarget:self action:@selector(textFieldEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    UIView * realNameView = [[UIView alloc]init];
    realNameView.size = [UIView getSize_width:bgView.width  height:55];
    realNameView.left = 0;
    [bgView addSubView:realNameView frameBottomView:verifyCodeView];
    // 线条
    UILabel * labelRealNameLine = [[UILabel alloc]init];
    labelRealNameLine.size = [UIView getSize_width:bgView.width height:1];
    labelRealNameLine.left = 0;
    labelRealNameLine.top = verifyCodeView.height -1 ;
    labelRealNameLine.backgroundColor =RGBFromColor(0xecedf1);
    [realNameView addSubview:labelRealNameLine];
    
    
    self.textFiledNRealName = [[UITextField alloc]init];
    self.textFiledNRealName.size = [UIView getSize_width:verifyCodeView.width-80 height:20];
    self.textFiledNRealName.top = (verifyCodeView.height - self.textFiledSelectArea.height)/2;
    self.textFiledNRealName.left = 0;
    self.textFiledNRealName.tag = 1122;
    self.textFiledNRealName.delegate = self;
    self.textFiledNRealName.font = [UIFont defaultFontWithSize:14];
    self.textFiledNRealName.borderStyle = UITextBorderStyleNone;
    self.textFiledNRealName.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.textFiledNRealName.placeholder = @"请输入姓名";
    [realNameView addSubview:self.textFiledNRealName];
    
    
    //  设置注册按钮
    UIButton * registerButton = [[UIButton alloc]init];
    registerButton.backgroundColor = defaultMainColor; //RGBFromColor(0xfa555c);

    registerButton.tag = 91;
    [registerButton setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
    registerButton.size = [UIView getSize_width:verifyCodeView.width height:sizeScale(40)];
    registerButton.left = 0;
    [registerButton setTitle:@"确定" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont defaultFontWithSize:22];
    [registerButton addTarget:self action:@selector(btnClck:) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius = sizeScale(6);
    
    
    [bgView addSubView:registerButton frameBottomView:realNameView offset:60];
    
}

-(void)btnClck:(UIButton *)btn{
    
    if(IsValidPhoneNum(self.textFieldIphone.text.trim)&&self.textFieldIphone.text.length ==11){
        
        if(self.textFieldPsd.text.trim.length == 0){
            [self showFaliureHUD:@"密码不能为空！"];
            return;
        }
        if(self.textFieldRePsd.text.trim.length == 0){
            [self showFaliureHUD:@"密码重复不能为空！"];
            return;
        }
        if(![self.textFieldRePsd.text.trim isEqualToString:self.textFieldPsd.text.trim]){
            [self showFaliureHUD:@"两次密码不一致"];
            return;
        }
        if(!self.lastModel){
            [self showFaliureHUD:@"请选择所在地区！"];
            return;
        }
        if(self.textFiledNRealName.text.trim.length == 0){
            [self showFaliureHUD:@"名字不能为空！"];
            return;
        }
        
    }else{
        [self showFaliureHUD:@"您输入的手机号格式不正确!"];
    }
    
    NetWork_registerAccount *request = [[NetWork_registerAccount alloc] init];
    request.code = self.lastModel.code;
    request.mobile = self.textFieldIphone.text.trim;
    request.password = self.textFieldPsd.text.trim;
    request.userName = self.textFiledNRealName.text.trim;
    [request showWaitMsg:@"加载中" handle:self];
    [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
        if(finished){
            NSLog(@"-----------");
            
            [self showFaliureHUD:@"注册成功，请登录"];
            sleep(1);
            ZJLoginViewController *vc = nil;
            NSArray *pushVCAry=[self.navigationController viewControllers];
            if(pushVCAry.count > 0){
                vc = [pushVCAry objectAtIndex:0]; //注册页面
                vc.textFieldUser.text =  self.textFieldIphone.text.trim;
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showFaliureHUD:msg];
        }
    }];
    
}

- (void)didSelectArea{
    NSMutableString *muStr = [[NSMutableString alloc] init];
    for(int i=0;i<self.listSelectArea.count;i++){
        SonElementModel* model = [self.listSelectArea objectAtIndex:i];
        if(i==self.listSelectArea.count-1){
            self.lastModel = model;
            [muStr appendString:model.name];
        }
        else{
            [muStr appendString:[NSString stringWithFormat:@"%@-",model.name]];
        }
    }
    
    self.textFiledSelectArea.text = muStr;
}

#pragma mark - textField代理方法


- (void)textFieldEditingDidBegin:(UITextField *)textField{
    
    NSLog(@"--textFieldEditingDidBegin-----");
    
    
    NetWork_getSonElement *request = [[NetWork_getSonElement alloc] init];
    [request showWaitMsg:@"请稍后" handle:self];
    [request startPostWithBlock:^(SonElementRespone *result, NSString *msg, BOOL finished) {
        if(finished){
            [textField resignFirstResponder];
            SelectAreaController *selectAreaController = [[SelectAreaController alloc] init];
            [selectAreaController.listDataArray addObjectsFromArray:result.data];
            [self.navigationController pushViewController:selectAreaController animated:YES];
        }
        else{
            [self showFaliureHUD:msg];
        }
    }];
}


-(void)enableOrNotEnable:(BOOL)enable btn:(UIButton*)btn{
    if(enable == YES){
        btn.enabled = YES;
        btn.backgroundColor = defaultMainColor; //RGBFromColor(0xfa555c);
    }
    else{
        btn.enabled = NO;
        btn.backgroundColor = RGBFromColor(0xaaaaaa);
    }
}

@end
