//
//  ZJMessageViewController.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/8.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ZJMessageViewController.h"
#import "NetWork_ZJ_get_message_list.h"
#import "NetWork_ZJ_notifyRecords_delete.h"
#import "NetWork_ZJ_notifyRecords_clean.h"


@interface ZJMessageViewController ()

@end

@implementation ZJMessageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isHidentabBar){
        [self hiddentabBar:YES isAnimat:NO];
    }
    else{
        self.tabBar.top = [self getTabbarTop];    //  重新设置tabbar的高度
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}



/*
 *用户切换小区
 */
-(void)userCommunityChange:(id)sender{
    [self.tableView.mj_header beginRefreshing];
}

-(void)initNavTitle{
    
    self.isNavBackGroundHiden  = YES;
    
    UIView *viewNav = [[UIView alloc]init];
    viewNav.size = [UIView getSize_width:ScreenWidth height:kNavBarHeight_New];
    viewNav.origin = [UIView getPoint_x:0 y:0];
    viewNav.backgroundColor = defaultZjBlueColor;
    [self.view addSubview:viewNav];
    
    if(self.isShowBackBtn){
        UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLeft.frame = CGRectMake(17, 33, 20, 20);
        btnLeft.backgroundColor = [UIColor clearColor];
        [btnLeft setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
        [btnLeft addTarget:self action:@selector(LeftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewNav addSubview:btnLeft];
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.left = (viewNav.width - titleLabel.width)/2;
    titleLabel.top = (viewNav.height - titleLabel.height)/2+10;
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont defaultFontWithSize:18];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //titleLabel.text = @"消息";
    if([self.msgType isEqualToString:@"NOTIFY"]){
        titleLabel.text = @"公告";
    }
    else{
        titleLabel.text = @"我的消息";
    }
    
    [viewNav addSubview:titleLabel];
    
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.tag = 91;
    rightButton.size = [UIView getSize_width:70 height:44];
    rightButton.origin = [UIView getPoint_x:viewNav.width - rightButton.width y:titleLabel.top];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBFromColor(0xecedf1) forState:UIControlStateHighlighted];
    rightButton.titleLabel.font = [UIFont defaultFontWithSize:18];
    [rightButton setTitle:@"清空" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(btnClearClick) forControlEvents:UIControlEventTouchUpInside];
    [viewNav addSubview:rightButton];

    if([self.msgType isEqualToString:@"NOTIFY"]){ //公告，1.隐藏删除按钮。 2.标题订到左边儿。 3.增加浏览量
        rightButton.hidden = YES;
    }
}

-(void)setUpUI{
    NSInteger tableViewHeight = ScreenHeight-kNavBarHeight_New -kTabBarHeight_New;
    if(self.isHidentabBar){
        tableViewHeight = ScreenHeight - kTabBarHeight_New;
    }
    

    
    self.tableView.size = [UIView getSize_width:ScreenWidth height:tableViewHeight];
    self.tableView.origin = [UIView getPoint_x:0 y:kNavBarHeight_New];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = defaultBgColor; //RGBFromColor(0xecedf1);
    
    self.tableView.mj_header.mj_h = 30;
    //    self.tableView.mj_header.controllerState = @"tableView";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.backgroundColor = defaultBgColor;
    
    [self.tableView.mj_header beginRefreshing]; //刷新数据
}


-(void)refreshMsgList:(NSString*)pushType pushId:(NSString*)pushId{
    
    [self.tableView.mj_header beginRefreshing]; //刷新
    
    /*
    【Y】NOTIFY:通知公告;READ_METER:抄表;REPAIR:报修;SECURITY:安防巡检;EQUIPMENT:设备巡检;DECORATION:装修巡检;
     */
    
    if([pushType isEqualToString:@"NOTIFY"]){
        ZJMessageDetailViewController *messageDetailViewController = [[ZJMessageDetailViewController alloc] init];
        messageDetailViewController.noticeId = pushId;
        [self pushNewVC:messageDetailViewController animated:NO];
    }
    else if ([pushType isEqualToString:@"REPAIR"]){
        
        
        ZJMyRepairViewController *myRepairViewController = [[ZJMyRepairViewController alloc] init];
        [self pushNewVC:myRepairViewController animated:NO hideNav:NO];

    }
    else if ([pushType isEqualToString:@"SECURITY"]){
        ZJSecurityCheckViewController *securityCheckViewController = [[ZJSecurityCheckViewController alloc] init];
        [self pushNewVC:securityCheckViewController animated:NO hideNav:NO];
    }
    else if ([pushType isEqualToString:@"EQUIPMENT"]){
        ZJEquipmentCheckViewController *equipmentCheckViewController = [[ZJEquipmentCheckViewController alloc] init];
        [self pushNewVC:equipmentCheckViewController animated:NO hideNav:NO];
    }
    else if ([pushType isEqualToString:@"DECORATION"]){
        ZJRenovationCheckViewController *myRepairViewController = [[ZJRenovationCheckViewController alloc] init];
        [self pushNewVC:myRepairViewController animated:NO hideNav:NO];
    }
    
}

-(void)jumpNoticeWithId:(NSString*)noticeId{
    ZJMessageDetailViewController *messageDetailViewController = [[ZJMessageDetailViewController alloc] init];
    messageDetailViewController.noticeId = noticeId;
    [self pushNewVC:messageDetailViewController animated:YES];
}


- (void)addLeftBtn{
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectMake(0, 0, 20, 20);
    btnLeft.backgroundColor = [UIColor clearColor];
    [btnLeft setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(LeftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.backgroundColor = [UIColor redColor];
    
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
}

- (void)LeftBtnClicked:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - cellDelegate

- (void)btnClicked:(id)sender cell:(ZJMessageCell *)cell{
    
    //【Y】NOTIFY:通知公告;READ_METER:抄表;REPAIR:报修;SECURITY:安防巡检;EQUIPMENT:设备巡检;DECORATION:装修巡检;
    
    ZjGetMessageListModel *model = cell.listModel;
    model.readFlag = @"Y";
    [cell fillDataWithModel:model msgType:self.msgType]; //刷新cell 去掉未读状态
    
    if([model.type isEqualToString:@"NOTIFY"]){
        ZJMessageDetailViewController *messageDetailViewController = [[ZJMessageDetailViewController alloc] init];
        messageDetailViewController.noticeId = [NSString stringWithFormat:@"%@",cell.listModel.id];
        [self pushNewVC:messageDetailViewController animated:YES];
    }
    else{
        __weak __typeof (self) weakSelf = self;
        NetWork_ZJ_get_message_read *request = [[NetWork_ZJ_get_message_read alloc] init];
        request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
        request.id = [NSString stringWithFormat:@"%@",model.id];
        [request showWaitMsg:@"正在处理请稍后..." handle:self];
        [request startPostWithBlock:^(ZjGetMessageReadRespone *result, NSString *msg, BOOL finished) {
                if([model.type isEqualToString:@"REPAIR"]){ //报修
                    ZJMyRepairViewController *myRepairViewController = [[ZJMyRepairViewController alloc] init];
                    [self pushNewVC:myRepairViewController animated:YES hideNav:NO];
                }
                else if([model.type isEqualToString:@"READ_METER"]){//读表
                    ZJReadingsCheckSearchViewController *myRepairViewController = [[ZJReadingsCheckSearchViewController alloc] init];
                    [weakSelf pushNewVC:myRepairViewController animated:YES hideNav:NO];
                }
                else if([model.type isEqualToString:@"SECURITY"]){//安防巡检
                    ZJSecurityCheckViewController *securityCheckViewController = [[ZJSecurityCheckViewController alloc] init];
                    [weakSelf pushNewVC:securityCheckViewController animated:YES hideNav:NO];
                }
                else if([model.type isEqualToString:@"EQUIPMENT"]){//设备巡检
                    ZJEquipmentCheckViewController *equipmentCheckViewController = [[ZJEquipmentCheckViewController alloc] init];
                    [weakSelf pushNewVC:equipmentCheckViewController animated:YES hideNav:NO];
                }
                else if([model.type isEqualToString:@"DECORATION"]){//装修
                    
                    ZJRenovationCheckViewController *myRepairViewController = [[ZJRenovationCheckViewController alloc] init];
                    [weakSelf pushNewVC:myRepairViewController animated:YES hideNav:NO];
                }
        }];
    }
}

-(void)btnDeleteClick:(ZjGetMessageListModel*)model{
    
    self.deleModel = model;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您确定要删除么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 99;
    [alert show];
}

-(void)btnClearClick{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您确定要清空吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 98;
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        return;
    }
    if(alertView.tag == 99){
        if(self.deleModel){
            
            __weak __typeof(self) weakSelf = self;
            NetWork_ZJ_notifyRecords_delete *request = [[NetWork_ZJ_notifyRecords_delete alloc] init];
            request.id = [NSString stringWithFormat:@"%@",self.deleModel.id];
            request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
            [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
                //code
                if(finished){
                    NSInteger index = [weakSelf.listDataArray indexOfObject:self.deleModel];
                    [weakSelf.listDataArray removeObjectAtIndex:index];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                    [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                else{
                    [weakSelf showFaliureHUD:@"消息删除失败。"];
                }
            }];
        }
    }
    else if(alertView.tag == 98){
        NSLog(@"---------");
        __weak __typeof(self) weakSelf = self;
        NetWork_ZJ_notifyRecords_clean *request = [[NetWork_ZJ_notifyRecords_clean alloc] init];
        request.communityId = [GlobalData sharedInstance].findUserCommunityListModel.id;
        request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
        request.type = self.msgType;
        [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
            //code
            if(finished){
                [weakSelf.listDataArray removeAllObjects];
                //添加空数据页面
                [weakSelf refreshNoDataViewWithListCount:self.listDataArray.count];
                [weakSelf.tableView reloadData];
            }
            else{
                [self showFaliureHUD:@"消息删除失败。"];
            }
        }];

    }
}

#pragma mark - 数据加载代理

-(void)loadNewData{
    self.tableView.mj_footer.hidden = YES;
    self.currentPage = 0;
    [self initRequest];
}

#pragma 请求网络数据

-(void)initRequest{
    
    /*
     【Y】NOTIFY:通知公告;READ_METER:抄表;REPAIR:报修;SECURITY:安防巡检;EQUIPMENT:设备巡检;DECORATION:装修巡检;
     */
    __weak __typeof (self) weakSelf = self;
    NetWork_ZJ_get_message_list *request = [[NetWork_ZJ_get_message_list alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.communityId = [GlobalData sharedInstance].findUserCommunityListModel.id;
    request.page = [NSNumber numberWithInteger:self.currentPage + 1];
    request.pageSize = [NSNumber numberWithInt:20];
    request.type = self.msgType;
    [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
        NSLog(@"----------网络请求完成---------");
        if(finished){
            if (self.currentPage == 0 ) {
                [request removeCacheAllData:nil];
            }
        }
    } cacheBlock:^(id result) {
        
        if([result isKindOfClass:[NSDictionary class]]){
            NSArray *notifyList = [result objectForKey:@"data:notifyList"];
            //code
            NSLog(@"缓存加载成功");
            [weakSelf loadData:notifyList];
            
        }
    }];
}

-(void)loadData:(NSArray *)liatData{
    if (self.currentPage == 0 ) {
        self.listDataArray = [[NSMutableArray alloc]init];
        self.tableView.mj_footer.hidden = NO;
    }
    else{
        self.tableView.mj_header.hidden = NO;
    }
    
    [self.listDataArray addObjectsFromArray:liatData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    //添加空数据页面
    [self refreshNoDataViewWithListCount:self.listDataArray.count];
    [self.tableView reloadData];
}

-(void)loadMoreData{
    self.tableView.mj_header.hidden = YES;
    self.currentPage += 1;

    [self initRequest];
}


#pragma mark - 设置tabbleView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listDataArray.count;
}
//设置cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *activiteyIdentifier = @"ZJMessageCell";
    ZJMessageCell *cell = (ZJMessageCell *)[tableView dequeueReusableCellWithIdentifier:activiteyIdentifier];
    
    if(cell == nil){
        cell = [[ZJMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activiteyIdentifier];
        cell.delegate = self;
        cell.deleteDelegate = self;
    }
    
    if(indexPath.row == 0){
        cell.viewBg.top = ZJMessageCellSpace;
    }
    else{
        cell.viewBg.top = 0;
    }
    
    ZjGetMessageListModel *model = [self.listDataArray objectAtIndex:indexPath.row];
    [cell fillDataWithModel:model msgType:self.msgType];
    return cell;
}
//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        return ZJMessageCellHeight+ZJMessageCellSpace;
    }
    else{
        return ZJMessageCellHeight;
    }
}

//点击cell的触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
//设置组头部视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
//设置组底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

@end
