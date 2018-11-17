//
//  YCCustomViewController.m
//  YCBuddy
//
//  Created by bita on 15/5/26.
//  Copyright (c) 2015年 bita. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "UIView+Hierarchy.h"
#import "UIButton+Create.h"
#import "GlobalFunc.h"
//#import "CMPLjhMobileAppDelegate.h"

#import "BaseNavigationController.h"

/*
 *有与升级Xcode9.0 后，发现第一次加载不显示 leftBarButtonItem 的问题，需要重写Navigatio
 */
#define isIOS9 ([[UIDevice currentDevice].systemVersion intValue]>=9?YES:NO)
#define isIOS10 ([[UIDevice currentDevice].systemVersion intValue]>=10?YES:NO)


@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray    *muArrRequest;//网络请求数组，这是需要开启控件的数组
@property (nonatomic, strong) MBProgressHUD     *progressHUD;//等待控件
@property (nonatomic, assign) NSInteger         topvalue;

@property (nonatomic, strong) NSMutableArray *arrayShowNotice;

@end

@implementation BaseViewController

+ (instancetype)classViewController {
    
    return [[[self class] alloc] init];
}

- (UIView *)navBackGround{
    
    if (!_navBackGround) {
        _navBackGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kNavBarHeight_New)];
        _navBackGround.backgroundColor = navBackgroundColor;
        
        [self.view addSubview:_navBackGround];
    }
    return _navBackGround;
}

- (UILabel *)lableNavTitle{
    
    if (!_lableNavTitle) {
        _lableNavTitle = [[UILabel alloc] init];
        _lableNavTitle.width = self.navBackGround.width*0.64;
        _lableNavTitle.height = 50;
        _lableNavTitle.left = (self.navBackGround.width-_lableNavTitle.width)/2; //title水平居中
        _lableNavTitle.bottom = self.navBackGround.height;
        _lableNavTitle.font = [UIFont defaultFontWithSize:17];
        _lableNavTitle.textAlignment = NSTextAlignmentCenter;
        _lableNavTitle.textColor = [UIColor whiteColor];
        [self.navBackGround addSubview:_lableNavTitle];
        
    }
    return _lableNavTitle;
}

- (void)setTitle:(NSString *)title {
    self.lableNavTitle.text = title;
}

- (void)setTitleNavView:(UIView *)titleNavView{
    
    if(titleNavView){
        [_titleNavView removeFromSuperview];
        _titleNavView = nil;
        _titleNavView = titleNavView;
        
        titleNavView.bottom = self.navBackGround.height;
        titleNavView.left = (self.navBackGround.width - titleNavView.width)/2;
        
        [self.navBackGround addSubview:titleNavView];
    }
}

-(void)setIsNavBackGroundHiden:(BOOL)isNavBackGroundHiden{
    _isNavBackGroundHiden = isNavBackGroundHiden;
    self.navBackGround.hidden = isNavBackGroundHiden;
}


-(void)setBtnRight:(UIButton *)btnRight{
    if(btnRight){
        [_btnRight removeFromSuperview];
        _btnRight = nil;
        
        btnRight.bottom = self.navBackGround.height;
        btnRight.left = self.navBackGround.width - btnRight.width;
        [self.navBackGround addSubview:btnRight];
    }
}

-(void)setBtnLeft:(UIButton *)btnLeft{
    if(btnLeft){
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
//        self.btnLeft.size = CGSizeMake(50, 50 );
        _btnLeft.left = 0;
        _btnLeft.top = self.navBackGround.height - btnLeft.height;
        [self.navBackGround addSubview:btnLeft];
    }
}


#pragma mark - 进入下一页面
- (void)pushNewVC:(UIViewController *)newViewController
         animated:(BOOL)animated{
    //默认显示
    [self pushNewVC:newViewController animated:animated hideNav:NO];
}

- (void)pushNewVC:(UIViewController *)newViewController
         animated:(BOOL)animated
          hideNav:(BOOL)hideNav{
    [self pushNewVC:newViewController enableVC:nil animated:animated hideNav:hideNav];
}

#pragma mark - 到指定页面处理
- (void)pushNewVC:(UIViewController *)newViewController
         enableVC:(NSString *)enableViewControllerName
         animated:(BOOL)animated{
    //默认显示
    [self pushNewVC:newViewController enableVC:enableViewControllerName animated:animated hideNav:NO];
}

- (void)pushNewVC:(UIViewController *)newViewController
         enableVC:(NSString *)enableViewControllerName
         animated:(BOOL)animated
          hideNav:(BOOL)hideNav{
    
    if (newViewController == nil) {
        return;
    }
    
    NSMutableArray *muArrVC = [self.navigationController.viewControllers mutableCopy];
    if (enableViewControllerName) {
        for (int i = 0; i < muArrVC.count; ++i) {
            UIViewController *tempVC = (UIViewController *)muArrVC[i];
            if ([tempVC isKindOfClass:NSClassFromString(enableViewControllerName)]) {
                /*
                 如果需要删除的长度为0，那么不需要删除，直接返回。 add by songlei , IOS 7 上点击返回没有反应。
                 */
                
                NSInteger count = muArrVC.count-i-1;
                if(count > 0){
                    NSRange range = NSMakeRange(i+1, muArrVC.count-i-1);
                    [muArrVC removeObjectsInRange:range];
                    break;
                }
            }
        }
    }
    
    if (muArrVC.count == self.navigationController.viewControllers.count) {
        newViewController.fd_prefersNavigationBarHidden = hideNav;
        [self.navigationController pushViewController:newViewController animated:animated];
    } else {
        [muArrVC addObject:newViewController];
        newViewController.fd_prefersNavigationBarHidden = hideNav;
        [self.navigationController setViewControllers:muArrVC animated:animated];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.muArrRequest = [NSMutableArray array];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];

    //返回按钮
    if ([self.navigationController.viewControllers firstObject] != self){
        [self addLeftBtn];
    }
    [self initNavTitle];
}

- (void)initNavTitle{
    //do nothing 在子类中重载该方法。
}

- (void)addLeftBtn{
    
    _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLeft.size = CGSizeMake(50, 50 );
    _btnLeft.left = 0;
    _btnLeft.top = self.navBackGround.height -self.btnLeft.height;
   _btnLeft.backgroundColor = [UIColor clearColor];
    [_btnLeft setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [_btnLeft addTarget:self action:@selector(LeftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBackGround addSubview:_btnLeft];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]init];
}

-(void)setExclusiveTouchForButtons:(UIView *)myView{
    
    for (UIView * v in [myView subviews]) {
        if([v isKindOfClass:[UIButton class]])
            [((UIButton *)v) setExclusiveTouch:YES];
        else if ([v isKindOfClass:[UIView class]]){
            [self setExclusiveTouchForButtons:v];
        }
    }
}

- (void)LeftBtnClicked:(UIButton *)sender{
    
    [self.view endEditing:YES];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    if (self.presentingViewController) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

#pragma -mark WCServiceJrLoanDelegate

- (void)startWithCursor:(NSString*)msg{
    
    NSString *selfName = NSStringFromClass([self class]);
    
    [self startWithCursor:msg interfaceName:selfName];
    
}

- (void)stopWatiCursor{
    
    NSString *selfName = NSStringFromClass([self class]);
    
    [self stopWatiCursor:selfName];
}

- (void)startWithCursor:(NSString*)msg interfaceName:(NSString *)interfaceName{
    if(![msg isKindOfClass:[NSString class]] || msg.trim.length == 0 || [msg.trim isEqualToString:@""]){
        return;
    }
    
    if(self.arrayShowNotice == nil){
        self.arrayShowNotice = [[NSMutableArray alloc]init];
    }
    [self.arrayShowNotice addObject:interfaceName];
    
    
    if([msg isKindOfClass:[NSString class]] && msg.trim.length > 0 && self.showNotice == nil){
        self.showNotice = [ShowNotice showView:self.view frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) msg:msg];
    }
    [self.showNotice setNoticeMsg:msg];
}
- (void)stopWatiCursor:(NSString*)interfaceName{
    [self.arrayShowNotice removeObject:interfaceName];
    if(self.arrayShowNotice.count == 0 && self.showNotice != nil){
        [self.showNotice hideNoticeAnimated:YES];
        self.showNotice = nil;
    }
}

- (void)handleTokenOverdue:(NSString *)msg{
    /*
     *处理token 过期，清空账号信息，弹出登录页面。
     */
    [GlobalData cleanAccountInfo];
//    [[ZJLoginService sharedInstance] authenticateWithCompletion:nil cancelBlock:nil isAnimat:YES];
}

#pragma mark - 等待控件

- (BOOL)createHUD{  //alloc一个等待控件出来
    
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.navigationController.view addSubview:_progressHUD];
    return YES;
}

- (void)showFaliureHUD:(NSString *)message{
    
    dispatch_async(dispatch_get_main_queue(), ^{

    
    if(message != nil && message.trim.length > 0){
        [self createHUD];
        _progressHUD.mode = MBProgressHUDModeCustomView;
        _progressHUD.detailsLabelText = message;
        
        [_progressHUD show:YES];
        [_progressHUD hide:YES afterDelay:1.5];
    }
    
    });

}

- (void)hideHUDWaitView:(BOOL)animation{
    [_progressHUD hide:animation];
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - touches delegeate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg{
    [self showAlertWithTitle:title msg:msg cancelBtn:@"取消" otherBtn:@"确定" delegate:self tag:0];
}

- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg cancelBtn:(NSString *)cacel otherBtn:(NSString *)other delegate:(id<UIAlertViewDelegate>)del tag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:del cancelButtonTitle:cacel otherButtonTitles:other, nil];
    [alert setTag:tag];
    [alert show];
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

//iOS 6.0以下
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//- (void)voiceResultPushVCAction:(NSNotification *)noti
//{
//    if ([XLVoiceSingleTool sharedInstance].voiceFirstClick != 0) {
//        return;
//    }
//
//    [XLVoiceSingleTool sharedInstance].voiceFirstClick ++;
//
//    VoiceJumpModel *model = noti.object;
//
//    UIViewController *vc = [[UIViewController alloc] init];
//
//    if (model.nativeType == PushNativeTypeHTML) {// H5 页面
//        vc = [[XLVoiceJumpViewController alloc] initWithModel:model];
//    }
//    else if (model.nativeType == PushNativeTypeMyCredit) {
//        vc = [[MyCreditViewController alloc] init];
//    } else if (model.nativeType == PushNativeTypeAuthentication) {
//        vc = [[ReadNameAuthViewController alloc] init];
//    } else if (model.nativeType == PushNativeTypeSetting) {
//        vc = [[SettingViewController alloc] init];
//    } else if (model.nativeType == PushNativeTypeMyIntegral) {
//        vc = [[MyIntegralViewController alloc] init];
//    } else if (model.nativeType == PushNativeTypePersonalInformation) {
//        vc = [[PersonalInformationViewController alloc] init];
//    } else if (model.nativeType == PushNativeTypeModifyPassword) {
//        vc = [[ModifyPasswordViewController alloc] init];
//    }
//
//    [self.navigationController pushViewController:vc animated:YES];
//}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -  main UITableView

/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)mainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.estimatedRowHeight = 100;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.tableFooterView = [[UIView alloc] init];
        _mainTableView.scrollsToTop = YES;
        
        // 头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        _mainTableView.mj_header = header;
        
        // 底部刷新
        _mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    return _mainTableView;
}
#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)headerRereshing
{
    
}

-(void)footerRereshing
{
    
}
- (NSMutableArray *)mainDataArr {
    if (!_mainDataArr) {
        _mainDataArr = [[NSMutableArray alloc] init];
    }
    return _mainDataArr;
}

@end
