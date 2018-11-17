//
//  NickNameViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ReadNameAuthViewController.h"
#import "NetWork_appuser_oauth.h"
@interface ReadNameAuthViewController ()<UITextFieldDelegate>{
    BOOL _canedit;
}

/** 真实姓名 */
@property(nonatomic,strong) UITextField * nickNameTextField;
@property(nonatomic,strong) UITextField * userIdTextField;

@end

@implementation ReadNameAuthViewController

-(void)initNavTitle{
    [super initNavTitle];
    self.title = @"实名认证";
}

- (void)viewDidLoad {
    self.isNavBackGroundHiden = NO;
    [super viewDidLoad];
    [self creatUI];
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)creatUI{
    
    self.view.backgroundColor = RGBFromColor(0xf6f6f6);
    //真实姓名View
    UIView * realNameView = [[UIView alloc]init];
    realNameView.size = [UIView getSize_width:ScreenWidth height:63];
    realNameView.left = 0;
    realNameView.top = 12+self.navBackGround.bottom;
    realNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:realNameView];
    
    UILabel *lableNameTitle =  [[UILabel alloc] init];
    lableNameTitle.size  = [UIView getSize_width:100 height:realNameView.height];
    lableNameTitle.origin = [UIView getPoint_x:15 y:0];
    lableNameTitle.text = @"真实姓名:";
    lableNameTitle.font = [UIFont defaultFontWithSize:16];
    [realNameView addSubview:lableNameTitle];
    
    self.nickNameTextField = [[UITextField alloc]init];
    self.nickNameTextField.size = [UIView getSize_width:ScreenWidth-12*2 height:realNameView.height];
    self.nickNameTextField.top = 0;
    self.nickNameTextField.left = lableNameTitle.right;
    self.nickNameTextField.font = [UIFont defaultFontWithSize:14];
    self.nickNameTextField.borderStyle = UITextBorderStyleNone;
    self.nickNameTextField.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.nickNameTextField.placeholder = @"请输入您的真实姓名";
    [realNameView addSubview:self.nickNameTextField];
    
    UILabel *lableLineName = [[UILabel alloc]init];
    lableLineName.backgroundColor = RGBFromColor(0xecedf1);
    lableLineName.left = 0;
    lableLineName.width = ScreenWidth;
    lableLineName.height = 1;
    lableLineName.top = realNameView.height-1;
    [realNameView addSubview:lableLineName];
    
    
    //真实姓名View
    UIView * idView = [[UIView alloc]init];
    idView.size = [UIView getSize_width:ScreenWidth height:63];
    idView.left = 0;
    idView.top = realNameView.bottom;
    idView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:idView];
    
    UILabel *lableIdTitle =  [[UILabel alloc] init];
    lableIdTitle.size  = [UIView getSize_width:100 height:realNameView.height];
    lableIdTitle.origin = [UIView getPoint_x:15 y:0];
    lableIdTitle.text = @"身份证号码";
    lableIdTitle.font = [UIFont defaultFontWithSize:16];
    [idView addSubview:lableIdTitle];
    
    self.userIdTextField = [[UITextField alloc]init];
    self.userIdTextField.size = [UIView getSize_width:ScreenWidth-12*2 height:realNameView.height];
    self.userIdTextField.top = 0;
    self.userIdTextField.left = lableNameTitle.right;
    self.userIdTextField.font = [UIFont defaultFontWithSize:14];
    self.userIdTextField.borderStyle = UITextBorderStyleNone;
    self.userIdTextField.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.userIdTextField.placeholder = @"请输入完整的身份证号码";
    [idView addSubview:self.userIdTextField];
    
    UILabel *lableLineId = [[UILabel alloc]init];
    lableLineId.backgroundColor = RGBFromColor(0xecedf1);
    lableLineId.left = 0;
    lableLineId.width = ScreenWidth;
    lableLineId.height = 1;
    lableLineId.top = idView.height-1;
    [idView addSubview:lableLineId];
    
    
    UILabel *lableTipOne =  [[UILabel alloc] init];
    lableTipOne.size  = [UIView getSize_width:ScreenWidth height:30];
    lableTipOne.origin = [UIView getPoint_x:15 y:idView.bottom + 15];
    lableTipOne.text = @"1.实名认证后，信息将不可更改。";
    lableTipOne.font = [UIFont defaultFontWithSize:14];
    [self.view addSubview:lableTipOne];
    
    
    UILabel *lableTipTwo =  [[UILabel alloc] init];
    lableTipTwo.origin = [UIView getPoint_x:15 y:lableTipOne.bottom];
    lableTipTwo.size  = [UIView getSize_width:ScreenWidth-lableTipTwo.width-30 height:40];

    lableTipTwo.numberOfLines = 2;
    lableTipTwo.lineBreakMode = NSLineBreakByCharWrapping;
    lableTipTwo.text = @"2.您有机会享受更多优惠服务。同时您的个人资料我们将严格保密。";
    lableTipTwo.font = [UIFont defaultFontWithSize:14];
    [self.view addSubview:lableTipTwo];
    
    self.btnBind = [[UIButton alloc]init];
    self.btnBind.tag = 101;
    [self.btnBind setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
    self.btnBind.size = [UIView getSize_width:ScreenWidth height:sizeScale(46)];
    self.btnBind.origin = [UIView getPoint_x:0 y:ScreenHeight - self.btnBind.height - KTabBarHeightOffset_New];
    [self.btnBind setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnBind.titleLabel.font = [UIFont defaultFontWithSize:22];
    
    [self.view addSubview:self.btnBind];
}

-(void)loadData{
    
    NSString *flag = [GlobalData sharedInstance].loginDataModel.relationFlag;
    if([flag isEqualToString:@"Y"]){
        
        [self.btnBind setTitle:@"已实名认证" forState:UIControlStateNormal];
        self.btnBind.backgroundColor = [UIColor grayColor];
        
        self.nickNameTextField.text = [GlobalData sharedInstance].loginDataModel.userName;
        self.nickNameTextField.textColor = [UIColor grayColor];

        self.userIdTextField.text = @"****************";
        self.userIdTextField.textColor = [UIColor grayColor];
        
        self.nickNameTextField.enabled = NO;
        self.userIdTextField.enabled = NO;
        self.btnBind.enabled = NO;
    }
    else{
        self.btnBind.enabled = YES;
        [self.btnBind setTitle:@"确定" forState:UIControlStateNormal];
        self.btnBind.backgroundColor = defaultMainColor;
        [self.btnBind addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (toBeString.length<=8) {
        _canedit =YES;
    }
    if (_canedit==NO) { //如果输入框内容大于20则弹出警告
        return NO;
    }
    return YES;
}

-(void)btnClcik:(UIButton *)btn{
    
    NSString *realName = self.nickNameTextField.text.trim;
    NSString *idNumber = self.userIdTextField.text.trim;
    
    if([realName isEqualToString:@""] || [idNumber isEqualToString:@""]){
        
        [self showFaliureHUD:@"姓名或身份证号不能为空！"];
        return;
    }
    
    NetWork_appuser_oauth *request = [[NetWork_appuser_oauth alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.userName = realName;
    request.idcard = idNumber;
    [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
        if(finished){
            [self showFaliureHUD:@"认证成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showFaliureHUD:msg];

        }
    }];

}

#pragma mark- textFiled的代理方法

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITextField * nickNameTextField = (UITextField *)[self.view viewWithTag:2222];
    [nickNameTextField resignFirstResponder];
}

@end
