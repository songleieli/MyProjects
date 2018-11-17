//
//  NickNameViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "NetWork_integral_query.h"


@interface MyIntegralViewController ()<UITextFieldDelegate>{
    
    BOOL _canedit;
    
}

/** 昵称textField */
@property(nonatomic,strong) UITextField * nickNameTextField;

@end

@implementation MyIntegralViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

-(void)initNavTitle{
    [super initNavTitle];
    self.title = @"我的积分";
}
- (void)viewDidLoad {
    self.isNavBackGroundHiden = NO;
    [super viewDidLoad];
    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self updateIntegral];
    self.fd_prefersNavigationBarHidden = YES;
}

-(void)updateIntegral{
    
    /*
    NetWork_integral_query *request = [[NetWork_integral_query alloc] init];
    request.month = @"201809";
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    [request startGetWithBlock:^(id result, NSString *msg, BOOL finished) {
        NSLog(@"-------------");
    } cacheBlock:^(id result) {
        
    }];
    */
}

-(void)creatUI{
    self.view.backgroundColor = RGBFromColor(0xf6f6f6);

    // 昵称的View
    UIView * viewTopBackground = [[UIView alloc]init];
    viewTopBackground.size = [UIView getSize_width:ScreenWidth height:MasScale(200)];
    viewTopBackground.left = 0;
    viewTopBackground.top = self.navBackGround.bottom;
    viewTopBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewTopBackground];
    
    
    
    
    
    UIImageView *viewImage = [[UIImageView alloc] init];
    viewImage.size = [UIView getSize_width:53*1.6 height:60];
    viewImage.origin = [UIView getPoint_x:(viewTopBackground.width-viewImage.width)/2 y:(viewTopBackground.height-viewImage.height)/2];
    viewImage.image = [UIImage imageNamed:@"my_integral"];
    [viewTopBackground addSubview:viewImage];
    
    
    UILabel *lableTitle =  [[UILabel alloc] init];
    lableTitle.size  = [UIView getSize_width:ScreenWidth height:30];
    lableTitle.origin = [UIView getPoint_x:(viewTopBackground.width - lableTitle.width)/2 y:viewImage.bottom + 15];
    lableTitle.textAlignment = NSTextAlignmentCenter;
//    lableTitle.text = @"您目前积分：";
    lableTitle.font = [UIFont defaultFontWithSize:16];
    [viewTopBackground addSubview:lableTitle];
    
    
    NSString *str = [NSString stringWithFormat:@"您目前的积分: %@",[GlobalData sharedInstance].loginDataModel.integralBalance];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:RGBAlphaColor(238, 160, 62, 1)
                    range:NSMakeRange(8, str.length-8)];
    
    lableTitle.attributedText = attrStr;
    
    
//    self.nickNameTextField = [[UITextField alloc]init];
//    self.nickNameTextField.size = [UIView getSize_width:ScreenWidth-12*2 height:20];
//    self.nickNameTextField.tag = 2222;
//    self.nickNameTextField.top = (nickNameView.height - self.nickNameTextField.height)/2;
//    self.nickNameTextField.left = 12;
//    self.nickNameTextField.font = [UIFont defaultFontWithSize:14];
//    self.nickNameTextField.borderStyle = UITextBorderStyleNone;
//    self.nickNameTextField.clearButtonMode =UITextFieldViewModeWhileEditing;
//    self.nickNameTextField.placeholder = @"填写昵称";
//
//    [nickNameView addSubview:self.nickNameTextField];
//    self.nickNameTextField.delegate = self;
    
    
    /*
     *暂时屏蔽确定按钮
     */
    
//    self.btnBind = [[UIButton alloc]init];
//    self.btnBind.tag = 101;
//    self.btnBind.backgroundColor = defaultMainColor;
//    [self.btnBind setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
//    self.btnBind.size = [UIView getSize_width:ScreenWidth height:sizeScale(46)];
//    self.btnBind.origin = [UIView getPoint_x:0 y:ScreenHeight - self.btnBind.height];
//    [self.btnBind setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.btnBind.titleLabel.font = [UIFont defaultFontWithSize:22];
//    //[self.btnBind addTarget:self action:@selector(btnClck:) forControlEvents:UIControlEventTouchUpInside];
//    [self.btnBind setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.view addSubview:self.btnBind];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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
    

}

#pragma mark- textFiled的代理方法

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
