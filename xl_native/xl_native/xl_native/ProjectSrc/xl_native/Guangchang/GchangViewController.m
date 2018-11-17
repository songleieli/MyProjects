//
//  FirstFunctionViewController.m
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "GchangViewController.h"
#import "NetWork_uploadApi.h"
#import "NetWork_voice_order_add.h"

@interface GchangViewController ()

@property (copy, nonatomic) NSString *myCallBack;

@end

@implementation GchangViewController

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    /*四个一级页面判断需要登录，我爱我乡没有游客模式*/
    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
    } cancelBlock:nil isAnimat:YES];
    
    self.tabBar.top = [self getTabbarTop];    //  重新设置tabbar的高度
}

-(void)initNavTitle{
    
    self.title = @"乡邻广场";
    
    self.lableNavTitle.textColor = XLColorMainLableAndTitle;
    self.navBackGround.backgroundColor = [UIColor whiteColor];
    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = XLColorCutLine;
    [self.navBackGround addSubview:lineView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reLoadHomeUrl];
}

-(void)reLoadHomeUrl{
    
    NSString *url = [WCBaseContext sharedInstance].h5Server;
    url = [NSString stringWithFormat:@"%@/H5/countySquer.html",url];
    self.homeUrl = url;
    [self.webDefault loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.homeUrl]]];
}

- (void)voicePurchase:(NSString*)myCallBack
{
    CMPZjLifeMobileRootViewController *vc = (CMPZjLifeMobileRootViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [vc.suspensionBtn voiceSingleClick:VoiceSingleClickTypePurchase];
//   
//    __weak __typeof(self) weakSelf = self;
//    
//    vc.suspensionBtn.voiceResultAction = ^(VoiceJumpModel *model) {
//        if (model.voiceSingleClickType == 1) {// 语音购买
//            [weakSelf voiceCallBack:model.filePathMp3 voiceContent:model.voiceText myCallBack:myCallBack];
//        } else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"voiceResultPushVC" object:model];
//        }
//    };
}
#pragma -mark  -----重写父类中的方法 实现tabar隐藏后的操作------------
-(void)tabBarDidHide:(BOOL)hidden
{
    if(hidden){
        self.navBackGround.hidden = YES;
        self.webDefault.frame = CGRectMake(0, KStatusBarHeight_New, ScreenWidth, ScreenHeight - KTabBarHeightOffset_New - KStatusBarHeight_New);
    }
    else{
        self.navBackGround.hidden = NO;
        self.webDefault.frame = CGRectMake(0, kNavBarHeight_New, ScreenWidth, ScreenHeight - kNavBarHeight_New - kTabBarHeight_New);
    }
}


@end
