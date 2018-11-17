//
//  ZJBaseViewController.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/10.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ZJBaseViewController.h"

@interface ZJBaseViewController ()

@end

@implementation ZJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceResultPushVCAction:) name:NSNotificationXLVoiceResultPushVC object:nil];
}

-(void)initNavTitle{
    /*
     *重载父类中的方法，初始化NavTitle
     */
    [super initNavTitle];
    
    self.lableNavTitle.textColor = [UIColor blackColor];
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = RGBFromColor(0xd4d4d4);
    [self.navBackGround addSubview:lineView];
    
    [self.btnLeft setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateNormal];
    self.navBackGround.backgroundColor = [UIColor whiteColor];
    
//    [[UINavigationBar appearance] setBarTintColor:defaultZjBlueColor];
//    [[UINavigationBar appearance] setTranslucent:NO];
    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 100, 44)];
//    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
//    titleLabel.font = [UIFont defaultFontWithSize:18];  //设置文本字体与大小
//    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = titleLabel;
}

- (void)voiceResultPushVCAction:(NSNotification *)noti{
    
    if ([XLVoiceSingleTool sharedInstance].voiceFirstClick != 0) {
        return;
    }
    
    [XLVoiceSingleTool sharedInstance].voiceFirstClick ++;
    
    VoiceJumpModel *model = noti.object;
    
    UIViewController *vc = [[UIViewController alloc] init];
    
    if (model.nativeType == PushNativeTypeHTML) {// H5 页面
        vc = [[XLVoiceJumpViewController alloc] initWithModel:model];
    }
    else if (model.nativeType == PushNativeTypeMyCredit) {
        vc = [[MyCreditViewController alloc] init];
    } else if (model.nativeType == PushNativeTypeAuthentication) {
        vc = [[ReadNameAuthViewController alloc] init];
    } else if (model.nativeType == PushNativeTypeSetting) {
        vc = [[SettingViewController alloc] init];
    } else if (model.nativeType == PushNativeTypeMyIntegral) {
        vc = [[MyIntegralViewController alloc] init];
    } else if (model.nativeType == PushNativeTypePersonalInformation) {
        vc = [[PersonalInformationViewController alloc] init];
    } else if (model.nativeType == PushNativeTypeModifyPassword) {
        vc = [[ModifyPasswordViewController alloc] init];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}



- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



@end
