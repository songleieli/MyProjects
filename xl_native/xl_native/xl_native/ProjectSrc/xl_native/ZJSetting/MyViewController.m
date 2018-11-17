//
//  ZJMessageViewController.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/8.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "MyViewController.h"
#import "UserInfoHeader.h"
#import "XLAddressBookVC.h"
#import "XLMyWelfareTicketVC.h"

@interface MyViewController ()

@property (strong, nonatomic) UserInfoHeader *userInfoHeader;

@end

@implementation MyViewController


- (NSMutableArray *)firstSectionSource{
    
    if (!_firstSectionSource) {
        _firstSectionSource = [[NSMutableArray alloc]init];
        int count = 5;
        for (int i =0 ; i<count; i ++) {
            MyViewTableViewCellModel* model =  [[MyViewTableViewCellModel alloc] init];
            
            switch (i) {
                case 0:
                    model.titleStr = @"我的积分";
                    model.imageStr = @"my_photovoltaic";
                    break;
                case 1:
                    model.titleStr = @"我的卡券";
                    model.imageStr = @"my_ticket";
                    break;
                case 2:
                    model.titleStr = @"我的信用";
                    model.imageStr = @"my_credit";
                    break;
                case 3:
                    model.titleStr = @"我的订单";
                    model.imageStr = @"my_order";
                    break;
                case 4:
                    model.titleStr = @"实名认证";
                    model.imageStr = @"my_realname";
                    break;
                default:
                    break;
            }
            
            if (i==(count-1)) {
                model.isShowLine = NO;
            }else{
                model.isShowLine = YES;
            }
            NSString* str = [NSString stringWithFormat:@"10%d",(i+9)];
            NSInteger strIn = [str integerValue];
            model.cellTag = strIn;
            
            [_firstSectionSource addObject:model];
        }
    }
    return _firstSectionSource;
}

- (NSMutableArray *)secondSectionSource{
    
    if (!_secondSectionSource) {
        _secondSectionSource = [[NSMutableArray alloc]init];
        int count = 1;
        for (int i =0 ; i<count; i ++) {
            MyViewTableViewCellModel* model =  [[MyViewTableViewCellModel alloc] init];
            
            switch (i) {
                case 0:
                    model.titleStr = @"个人设置";
                    model.imageStr = @"my_setting";
                    break;
                default:
                    break;
            }
            
            if (i==(count-1)) {
                model.isShowLine = NO;
            }else{
                
                model.isShowLine = YES;
            }
            NSString* str = [NSString stringWithFormat:@"10%d",i];
            NSInteger strIn = [str integerValue];
            model.cellTag = strIn;
            [_secondSectionSource addObject:model];
        }
    }
    return _secondSectionSource;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    /*四个一级页面判断需要登录，我爱我乡没有游客模式*/
//    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
//    } cancelBlock:nil isAnimat:YES];

    self.tabBar.top = [self getTabbarTop];    //  重新设置tabbar的高度
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)initNavTitle{
    self.isNavBackGroundHiden  = YES;
}


-(void)setUpUI{
    [self displayHeaderStatus];
    
    NSInteger tableViewHeight = ScreenHeight -kTabBarHeight_New - KViewStartTopOffset_New;
    
    self.tableView.size = [UIView getSize_width:ScreenWidth height:tableViewHeight];
    self.tableView.origin = [UIView getPoint_x:0 y:KViewStartTopOffset_New];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = defaultBgColor; //RGBFromColor(0xecedf1);
    
//    self.tableView.mj_header.mj_h = 30;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.backgroundColor = defaultBgColor;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.tableHeaderView = self.userInfoHeader;
    self.tableView.tableFooterView = [self getFooterView];

    [self.view addSubview:self.tableView];
}

/*
-(UIView*)getHeadView{
    
    self.viewHeadBg = [[UIView alloc] init];
    self.viewHeadBg.size = [UIView getSize_width:ScreenWidth height:sizeScale(184)];
    self.viewHeadBg.origin = [UIView getPoint_x:0 y:kNavBarHeight_New];
    
    // 背景
    UIImageView * bgiConView = [[UIImageView alloc]init];
    bgiConView.size = [UIView getSize_width:ScreenWidth height:sizeScale(184)];
    bgiConView.origin = [UIView getPoint_x:0 y:0];
    [self.viewHeadBg addSubview:bgiConView];
    
    [bgiConView sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].adminLoginDataModel.userIcon]
                       placeholderImage:[UIImage imageNamed:@"user_default_icon"]]; //用户头像
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // blur view
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = bgiConView.bounds;
    [bgiConView addSubview:visualEffectView];
    
    
    UIView *spaceView = [[UIView alloc]init];
    spaceView.size = [UIView getSize_width:ScreenWidth height:10];
    spaceView.origin = [UIView getPoint_x:0 y:bgiConView.bottom];
    spaceView.backgroundColor = defaultBgColor;
    [self.viewHeadBg addSubview:spaceView];
    
    
    //头像
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.size = [UIView getSize_width:sizeScale(55) height:sizeScale(55)];
    self.iconImageView.left = sizeScale(20);
    self.iconImageView.top = (bgiConView.height - self.iconImageView.size.height)/2;
    self.iconImageView.image = [UIImage imageNamed:@"user_default_icon"];
    [bgiConView addSubview:self.iconImageView];
    
    //圆角
    CALayer * imageViewLayer = [self.iconImageView layer];
    [imageViewLayer setMasksToBounds:YES];
    [imageViewLayer setCornerRadius:self.iconImageView.width/2];
    self.iconImageView.userInteractionEnabled = YES;
    
    
    self.labelName = [[UILabel alloc]init];
    self.labelName.size = [UIView getSize_width:150 height:20];
    self.labelName.origin = [UIView getPoint_x:self.iconImageView.right+15 y:self.iconImageView.top+15];
    self.labelName.font = [UIFont defaultFontWithSize:20];
    self.labelName.textColor = [UIColor whiteColor];
    [bgiConView addSubview:self.labelName];
    
    
    self.labelDetail = [[UILabel alloc]init];
    self.labelDetail.size = [UIView getSize_width:200 height:20];
    self.labelDetail.origin = [UIView getPoint_x:self.labelName.left y:self.labelName.bottom+5];
    self.labelDetail.font = [UIFont defaultFontWithSize:16];
    self.labelDetail.textColor = [UIColor whiteColor];
    [bgiConView addSubview:self.labelDetail];
    
    [self displayHeaderStatus];
    
    return self.viewHeadBg;
}
*/

-(UIView*)getFooterView{
    UIView *viewFooter = [[UIView alloc] init];
    viewFooter.size = [UIView getSize_width:ScreenWidth height:30];
    viewFooter.backgroundColor = defaultJawBgColor;
    return viewFooter;
}

-(void)displayHeaderStatus {
    
    if([GlobalData sharedInstance].hasLogin) {
        
        NetWork_himInfo *info = [[NetWork_himInfo alloc] init];
        info.token = [GlobalData sharedInstance].loginDataModel.token;
        info.userId = [GlobalData sharedInstance].loginDataModel.userId;
        [info startPostWithBlock:^(HimInfoRespone *result, NSString *msg, BOOL finished) {
            if (finished) {
                HimInfoModel *model = (HimInfoModel *)result.data;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.userInfoHeader setupUI:model];
                });
            }
        }];
    }
}

#pragma mark - 数据加载代理
-(void)loadNewData{
    [self.tableView.mj_header endRefreshing];
}


#pragma mark - 设置tabbleView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = defaultJawBgColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MasScale_1080(30) ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0){
        return self.firstSectionSource.count;
    }
    else if (section == 1){
        return self.secondSectionSource.count;
    }
    else{
        return 1;
    }
}
//设置cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyViewTableViewCell cellId]];
    if(!cell){
        cell = [[MyViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyViewTableViewCell cellId] ];
    }
        if (indexPath.section == 0) {
            MyViewTableViewCellModel* model = [self.firstSectionSource objectAtIndex:indexPath.row];
            [cell dataBind:model];
        }
        else  if (indexPath.section == 1) {
            MyViewTableViewCellModel* model = [self.secondSectionSource objectAtIndex:indexPath.row];
            [cell dataBind:model];
        }
        return cell;

}
//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MyViewTableViewCellHeight;
}


//点击cell的触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self cellClick:indexPath];
}

#pragma - mark cell 点击事件

-(void)cellClick:(NSIndexPath *)indexPath{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    if(indexPath.section ==0){
        if(indexPath.row == 0){//我的积分
            MyIntegralViewController *myIntegralViewController = [[MyIntegralViewController alloc] init];
            [self pushNewVC:myIntegralViewController animated:YES];
        }
        else if(indexPath.row == 1){//我的卡券
            XLMyWelfareTicketVC *vc = [[XLMyWelfareTicketVC alloc] init];
            [self pushNewVC:vc animated:YES];
        }
        else if(indexPath.row == 2){//我的信用
            MyCreditViewController *myCreditViewController = [[MyCreditViewController alloc] init];
            [self pushNewVC:myCreditViewController animated:YES];
        }
        else if(indexPath.row == 3){//我的订单
            
            NSString *url = [NSString stringWithFormat:@"%@/H5/manageOrder.html",[WCBaseContext sharedInstance].h5Server];
            XLProjectWkWebViewController *webViewController = [[XLProjectWkWebViewController alloc] init];
            webViewController.topNav.hidden = NO;
            webViewController.webDefault.size = [UIView getSize_width:ScreenWidth height:ScreenHeight];
            webViewController.webDefault.origin = [UIView getPoint_x:0 y:KStatusBarHeight_New];
            [webViewController reloadWebWithUrl:url msg:@""];
            [self pushNewVC:webViewController animated:YES];
        }
        else if(indexPath.row == 4){//我的实名认证
            ReadNameAuthViewController *readNameAuthViewController = [[ReadNameAuthViewController alloc] init];
            [self pushNewVC:readNameAuthViewController animated:YES];
        }
    }
    else if(indexPath.section ==1){
        if(indexPath.row == 0){//个人设置
            SettingViewController *settingViewController = [[SettingViewController alloc] init];
            [self pushNewVC:settingViewController animated:YES];
        }
    }
}

- (UserInfoHeader *)userInfoHeader {
    
    if (!_userInfoHeader) {
        __weak __typeof(self) weakSelf = self;
        _userInfoHeader = [UserInfoHeader shareView];
        _userInfoHeader.frame = CGRectMake(0, KViewStartTopOffset_New, ScreenWidth, 202);
        [_userInfoHeader setFansClickBlock:^{
            
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            MyFansViewController *fansViewController = [[MyFansViewController alloc] init];
            fansViewController.userId = [GlobalData sharedInstance].loginDataModel.userId;
            [weakSelf pushNewVC:fansViewController animated:YES];
        }];
        [_userInfoHeader setFollowListClickBlock:^{
            
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

            MyAttentionViewController *myAttentionViewController = [[MyAttentionViewController alloc] init];
            myAttentionViewController.userId = [GlobalData sharedInstance].loginDataModel.userId;
            [weakSelf pushNewVC:myAttentionViewController animated:YES];
        }];
    }
    return _userInfoHeader;
}

@end
