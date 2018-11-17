//
//  NickNameViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "IntroduceViewController.h"
#import "NetWork_updateUser.h"
@interface IntroduceViewController ()<UITextFieldDelegate>{
    
    BOOL _canedit;
    
}

/** 昵称textField */
@property(nonatomic,strong) UITextField * nickNameTextField;

@end

@implementation IntroduceViewController

-(void)initNavTitle{
    [super initNavTitle];
    self.title = @"介绍";
    
    //保存按钮
    UIButton * rightBarButton = [[UIButton alloc]init];
    rightBarButton.size = [UIView getSize_width:50 height:50];
    [rightBarButton setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont defaultFontWithSize:17];
    rightBarButton.titleLabel.textColor = RGBFromColor(0x464952) ;
    rightBarButton.enabled = YES;
    [rightBarButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightBarButton addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
    self.btnRight = rightBarButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)creatUI{
    
// 昵称的View
    UIView * nickNameView = [[UIView alloc]init];
    nickNameView.size = [UIView getSize_width:ScreenWidth height:63];
    nickNameView.left = 0;
    nickNameView.top = 12+self.navBackGround.bottom;
    nickNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickNameView];
    
    self.nickNameTextField = [[UITextField alloc]init];
    self.nickNameTextField.size = [UIView getSize_width:ScreenWidth-12*2 height:20];
    self.nickNameTextField.tag = 2222;
    self.nickNameTextField.top = (nickNameView.height - self.nickNameTextField.height)/2;
    self.nickNameTextField.left = 12;
    self.nickNameTextField.font = [UIFont defaultFontWithSize:14];
    self.nickNameTextField.borderStyle = UITextBorderStyleNone;
    self.nickNameTextField.clearButtonMode =UITextFieldViewModeWhileEditing;
    self.nickNameTextField.placeholder = @"填写一句话介绍";
    
    [nickNameView addSubview:self.nickNameTextField];
    self.nickNameTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.nickNameTextField];

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
-(void)textFiledEditChanged:(NSNotification*)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    BOOL isEmoj = [self stringContainsEmoji:toBeString];
    NSString * _showStr;
    toBeString = [self disable_emoji:toBeString];
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            if(toBeString.length > 8) {
                
                textField.text = [toBeString substringToIndex:8];
                
                _showStr = [toBeString substringToIndex:8];
            }
        }
        //有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if(toBeString.length > 8) {
            textField.text= [toBeString substringToIndex:8];
            _showStr = [toBeString substringToIndex:8];
        }
    }
    
    if (isEmoj) {
        
        [self showFaliureHUD:@"不支持表情符号输入"];
        if ([_showStr length]) {
            
            textField.text = _showStr;
            
        }else{
            textField.text = toBeString;
        }
        
    }
    
}


- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}
#pragma Mark   ---  过滤表情

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
//========================================================




//-(void)updateUserNickName{
//    if ([GlobalData sharedInstance].userAccount.nickName == nil) {
//
//    }else{
//        self.nickNameTextField.text =[GlobalData sharedInstance].userAccount.nickName;
// }
//}

-(void)btnClcik:(UIButton *)btn{
    
//    [GlobalFunc event:@"event_submit_new_nickname"];
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        [self showFaliureHUD:@"没有网络,请先检查网络设置"];
        return;
    }
    
//    0-8个字符，只能是数字，字母，中文。
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]{0,7}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if([pred evaluateWithObject: self.nickNameTextField.text]){
        btn.enabled = NO;
        __weak __typeof(self) weakSelf = self;
        NetWork_updateUser * updateUser = [[NetWork_updateUser alloc]init];
        updateUser.mobile = [GlobalData sharedInstance].loginDataModel.mobile;
        updateUser.nickName = self.nickNameTextField.text.trim;
        updateUser.token = [GlobalData sharedInstance].loginDataModel.token;
        [updateUser showWaitMsg:@"" handle:self];
        [updateUser startPostWithBlock:^(updateUserRespone *result, NSString *msg, BOOL finished) {
            if ([result.status isEqualToString:@"1"]) {
                
                NSString *dicStr = [[GlobalData sharedInstance].loginDataModel generateJsonStringForProperties];
                LoginDataModel *modelTemp = [[LoginDataModel alloc]initWithDictionary:[dicStr objectFromJSONString]];
                modelTemp.selfIntroduction = weakSelf.nickNameTextField.text.trim;
                [GlobalData sharedInstance].loginDataModel = modelTemp;
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationUserStateChange
//                                                                    object:nil];
                
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self showFaliureHUD:msg];
            }
        }];

        
    }
    else{
        [self showFaliureHUD:@"昵称格式不正确"];
    }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
