//
//  PersonalInformationViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonalInformationViewController.h"
#import "XLAboutViewController.h"

@interface SettingViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong) UILabel * labelLoginIcon;
@property(nonatomic,strong) UIImageView * loginIconImageView;
@property(nonatomic,strong) UIImageView * nicknameArrowImageView;
@property(nonatomic,strong) UIScrollView * scrollBg;

@end

@implementation SettingViewController

-(void)dealloc{
    NSLog(@"---------------%@ dealloc ",NSStringFromClass([self class]));
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initNavTitle{
    [super initNavTitle];
    self.title = @"设置";
}

- (void)viewDidLoad {
    
    self.isNavBackGroundHiden = NO;
    
    [super viewDidLoad];
    [self creatUI];
}

-(void)creatUI{
    self.view.backgroundColor = RGBFromColor(0xecedf1);
    
    self.scrollBg = [[UIScrollView alloc] init];
    self.scrollBg.size = [UIView getSize_width:ScreenWidth height:ScreenHeight - kTabBarHeight_New];
    self.scrollBg.origin = [UIView getPoint_x:0 y:self.navBackGround.bottom];
    self.scrollBg.showsVerticalScrollIndicator = NO;
    self.scrollBg.contentSize = CGSizeMake(self.scrollBg.width, ScreenHeight);
    [self.view addSubview:self.scrollBg];
    
    
    //编辑资料
    UIView * viewEditInfo = [[UIView alloc]init];
    viewEditInfo.size   =[UIView getSize_width:ScreenWidth height:sizeScale(66)];
    viewEditInfo.origin =[UIView getPoint_x:0 y:0];
    viewEditInfo.backgroundColor = [UIColor whiteColor];
    [self.scrollBg addSubview:viewEditInfo];
    
    UILabel * lablescan = [[UILabel alloc]init];
    lablescan.font = [UIFont defaultFontWithSize:sizeScale(14)];
    lablescan.textColor = RGBFromColor(0x464952);
    lablescan.text = @"编辑资料";
    lablescan.left = 21;
    lablescan.top = 0;
    lablescan.size = [UIView getSize_width:100 height:viewEditInfo.height];
    [viewEditInfo addSubview:lablescan];
    
    UIImageView * scanArrowImageView = [[UIImageView alloc]init];
    scanArrowImageView.size = [UIView getSize_width:5 height:10];
    scanArrowImageView.top = (viewEditInfo.height - scanArrowImageView.height)/2;
    scanArrowImageView.left = viewEditInfo.width - 21 - scanArrowImageView.width;
    scanArrowImageView.image = [UIImage imageNamed:@"command_left"];
    [viewEditInfo addSubview:scanArrowImageView];
    
    UIButton * btnEditInfo = [[UIButton alloc]init];
    btnEditInfo.size = [UIView getSize_width:viewEditInfo.width height:viewEditInfo.height];
    btnEditInfo.origin = [UIView getPoint_x:0 y:0];
    btnEditInfo.tag = 9010;
    [btnEditInfo addTarget:self action:@selector(buttonClcik:) forControlEvents:UIControlEventTouchUpInside];
    [viewEditInfo addSubview:btnEditInfo];
    
    UILabel * lableLineEditInfo = [[UILabel alloc]init];
    lableLineEditInfo.backgroundColor = RGBFromColor(0xecedf1);
    lableLineEditInfo.left = 0;
    lableLineEditInfo.width = ScreenWidth;
    lableLineEditInfo.height = 1;
    lableLineEditInfo.top = viewEditInfo.height-1;
    [viewEditInfo addSubview:lableLineEditInfo];
    
    
    //修改密码
    UIView * viewModifyPassword = [[UIView alloc]init];
    viewModifyPassword.size   =[UIView getSize_width:ScreenWidth height:sizeScale(66)];
    viewModifyPassword.origin =[UIView getPoint_x:0 y:viewEditInfo.bottom];
    viewModifyPassword.backgroundColor = [UIColor whiteColor];
    [self.scrollBg addSubview:viewModifyPassword];
    
    UILabel * lableModify = [[UILabel alloc]init];
    lableModify.font = [UIFont defaultFontWithSize:sizeScale(14)];
    lableModify.textColor = RGBFromColor(0x464952);
    lableModify.text = @"修改登录密码";
    lableModify.left = 21;
    lableModify.top = 0;
    lableModify.size = [UIView getSize_width:200 height:viewModifyPassword.height];

    [viewModifyPassword addSubview:lableModify];
    //
    UIImageView * modifyPasswordGuide = [[UIImageView alloc]init];
    modifyPasswordGuide.size = [UIView getSize_width:5 height:10];
    modifyPasswordGuide.top = (viewModifyPassword.height - modifyPasswordGuide.height)/2;
    modifyPasswordGuide.left = viewModifyPassword.width - 21 - modifyPasswordGuide.width;
    modifyPasswordGuide.image = [UIImage imageNamed:@"command_left"];
    [viewModifyPassword addSubview:modifyPasswordGuide];
    
    
    UIButton * buttonModifyClear = [[UIButton alloc]init];
    buttonModifyClear.size = [UIView getSize_width:ScreenWidth height:viewModifyPassword.height];
    buttonModifyClear.origin = [UIView getPoint_x:0 y:0];
    buttonModifyClear.tag = 9020;
    [buttonModifyClear addTarget:self action:@selector(buttonClcik:) forControlEvents:UIControlEventTouchUpInside];
    [viewModifyPassword addSubview:buttonModifyClear];
    
    
    UILabel * lableLineModifyPassword = [[UILabel alloc]init];
    lableLineModifyPassword.backgroundColor = RGBFromColor(0xecedf1);
    lableLineModifyPassword.left = 0;
    lableLineModifyPassword.width = ScreenWidth;
    lableLineModifyPassword.height = 1;
    lableLineModifyPassword.top = viewModifyPassword.height-1;
    [viewModifyPassword addSubview:lableLineModifyPassword];
    //test
//    lableLineModifyPassword.backgroundColor = [UIColor redColor];
    
    
    //修改密码
    UIView * viewAbout = [[UIView alloc]init];
    viewAbout.size   =[UIView getSize_width:ScreenWidth height:sizeScale(66)];
    viewAbout.origin =[UIView getPoint_x:0 y:viewModifyPassword.bottom];
    viewAbout.backgroundColor = [UIColor whiteColor];
    [self.scrollBg addSubview:viewAbout];
    
    UILabel * lableAbout = [[UILabel alloc]init];
    lableAbout.font = [UIFont defaultFontWithSize:sizeScale(14)];
    lableAbout.textColor = RGBFromColor(0x464952);
    lableAbout.text = @"关于我爱我乡";
    lableAbout.left = 21;
    lableAbout.top = 0;
    lableAbout.size = [UIView getSize_width:200 height:viewAbout.height];
    [viewAbout addSubview:lableAbout];
    
    UIImageView * imgAbout = [[UIImageView alloc]init];
    imgAbout.size = [UIView getSize_width:5 height:10];
    imgAbout.top = (viewAbout.height - imgAbout.height)/2;
    imgAbout.left = viewAbout.width - 21 - imgAbout.width;
    imgAbout.image = [UIImage imageNamed:@"command_left"];
    [viewAbout addSubview:imgAbout];
    
    
    UIButton * btnAbout = [[UIButton alloc]init];
    btnAbout.size = [UIView getSize_width:ScreenWidth height:viewAbout.height];
    btnAbout.origin = [UIView getPoint_x:0 y:0];
    btnAbout.tag = 9030;
    [btnAbout addTarget:self action:@selector(buttonClcik:) forControlEvents:UIControlEventTouchUpInside];
    [viewAbout addSubview:btnAbout];
    
    
    UILabel * lableLineAbout = [[UILabel alloc]init];
    lableLineAbout.backgroundColor = RGBFromColor(0xecedf1);
    lableLineAbout.left = 0;
    lableLineAbout.width = ScreenWidth;
    lableLineAbout.height = 1;
    lableLineAbout.top = viewAbout.height-1;
    [viewAbout addSubview:lableLineAbout];
    
    // 检测新版本
    UIView * viewVersion = [[UIView alloc]init];
    viewVersion.size   =[UIView getSize_width:ScreenWidth height:sizeScale(66)];
    viewVersion.origin =[UIView getPoint_x:0 y:viewAbout.bottom];
    viewVersion.backgroundColor = [UIColor whiteColor];
    [self.scrollBg addSubview:viewVersion];
    
    UILabel * lableVersion = [[UILabel alloc]init];
    lableVersion.font = [UIFont defaultFontWithSize:sizeScale(14)];
    lableVersion.textColor = RGBFromColor(0x464952);
    lableVersion.text = @"检测新版本";
    lableVersion.left = 21;
    lableVersion.top = 0;
    lableVersion.size = [UIView getSize_width:200 height:viewVersion.height];
    [viewVersion addSubview:lableVersion];
    
    UIImageView * imgVersion = [[UIImageView alloc]init];
    imgVersion.size = [UIView getSize_width:5 height:10];
    imgVersion.top = (viewVersion.height - imgVersion.height)/2;
    imgVersion.left = viewVersion.width - 21 - imgVersion.width;
    imgVersion.image = [UIImage imageNamed:@"command_left"];
    [viewVersion addSubview:imgVersion];
    
    
    UIButton * btnVersion = [[UIButton alloc]init];
    btnVersion.size = [UIView getSize_width:ScreenWidth height:viewVersion.height];
    btnVersion.origin = [UIView getPoint_x:0 y:0];
    btnVersion.tag = 9050;
    [btnVersion addTarget:self action:@selector(buttonClcik:) forControlEvents:UIControlEventTouchUpInside];
    [viewVersion addSubview:btnVersion];
    
    
    UILabel * lableLineVersion = [[UILabel alloc]init];
    lableLineVersion.backgroundColor = RGBFromColor(0xecedf1);
    lableLineVersion.left = 0;
    lableLineVersion.width = ScreenWidth;
    lableLineVersion.height = 1;
    lableLineVersion.top = viewVersion.height-1;
    [viewVersion addSubview:lableLineVersion];
    
    [self thirdBinding:viewVersion];
}


-(void)buttonClcik:(UIButton *)btn{
    
    if(btn.tag == 9010){ //编辑资料
        
        NSLog(@"------------");
        
        PersonalInformationViewController *personalInformationViewController = [[PersonalInformationViewController alloc] init];
        [self pushNewVC:personalInformationViewController animated:YES];
        
    }
    else if (btn.tag == 9020){ //修改登录密码
        
        ModifyPasswordViewController *modifyPasswordViewController = [[ModifyPasswordViewController alloc] init];
        [self pushNewVC:modifyPasswordViewController animated:YES];
        
    }
    else if(btn.tag == 9030){//关于我爱我乡
        [self.navigationController pushViewController:[[XLAboutViewController alloc] init] animated:YES];
    }
    else if(btn.tag == 9040){ //退出
        
        [GlobalData cleanAccountInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationUserLoginSuccess
                                                            object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(btn.tag == 9050){ // 检测新版本
        [self checkVersion];
    }
}

- (void)checkVersion {
    [SVProgressHUD showErrorWithStatus:@"App Store应用地址缺失"];
/*
    NSString *urlString = @"http://itunes.apple.com/lookup?id=1295166"; //自己应用在App Store里的地址

    NSURL *url = [NSURL URLWithString:urlString];//这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。

    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];

    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];

    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    NSArray *array = json[@"results"];
    for (NSDictionary *dic in array) {
        NSString *newVersion =[dic valueForKey:@"version"]; // appStore 的版本号
    }
    */
}

- (void)thirdBinding:(UIView*)lastview{
    
    //  微信绑定
    UIView * wechatView = [[UIView alloc]init];
    wechatView.size   =[UIView getSize_width:ScreenWidth height:sizeScale(46)];
    wechatView.origin =[UIView getPoint_x:0 y:lastview.bottom+12];
    wechatView.backgroundColor = [UIColor whiteColor];
    [self.scrollBg addSubview:wechatView];
    
    UILabel * lableModify = [[UILabel alloc]init];
    lableModify.font = [UIFont defaultFontWithSize:sizeScale(14)];
    lableModify.textColor = RGBFromColor(0x464952);
    lableModify.text = @"退出";
    
    CGSize lableModifySize = [lableModify.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:lableModify.font,NSFontAttributeName, nil]];
    lableModify.size = [UIView getSize_width:lableModifySize.width height:lableModifySize.height];
    lableModify.left = (wechatView.width - lableModify.width)/2;
    lableModify.top = (wechatView.height - lableModify.height)/2;
    [wechatView addSubview:lableModify];
    
    
    UIButton * btnExit = [[UIButton alloc]init];
    btnExit.size = [UIView getSize_width:ScreenWidth height:wechatView.height];
    btnExit.origin = [UIView getPoint_x:0 y:0];
    btnExit.tag = 9040;
    [btnExit addTarget:self action:@selector(buttonClcik:) forControlEvents:UIControlEventTouchUpInside];
    [wechatView addSubview:btnExit];
    
//    btnExit.backgroundColor = [UIColor redColor];
}






@end
