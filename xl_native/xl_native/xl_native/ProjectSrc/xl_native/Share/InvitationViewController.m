//
//  NickNameViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "InvitationViewController.h"
//#import "NetWork_queryFollower.h" //粉丝列表

@interface InvitationViewController ()<UITextFieldDelegate>{
    BOOL _canedit;
}

/** 真实姓名 */
@property(nonatomic,strong) UITextField * nickNameTextField;
@property(nonatomic,strong) UITextField * userIdTextField;

@end

@implementation InvitationViewController

- (NSMutableArray *)listDataArray{
    
    if (!_listDataArray) {
        _listDataArray = [[NSMutableArray alloc] init];
    }
    return _listDataArray;
}

-(void)initNavTitle{
    
    self.title = @"邀请好友";
    self.lableNavTitle.textColor = [UIColor blackColor];
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = RGBFromColor(0xd4d4d4);
    [self.navBackGround addSubview:lineView];
    
    [self.btnLeft setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateNormal];
    self.navBackGround.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    self.isNavBackGroundHiden = NO;
    [super viewDidLoad];
    [self creatUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)creatUI{
    
    [self.view addSubview:self.tableView];
    
    NSInteger tableViewHeight = ScreenHeight -kNavBarHeight_New;
    
    self.tableView.size = [UIView getSize_width:ScreenWidth height:tableViewHeight];
    self.tableView.origin = [UIView getPoint_x:0 y:kNavBarHeight_New];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = defaultBgColor; //RGBFromColor(0xecedf1);
    
    //    self.tableView.mj_header.mj_h = 30;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.backgroundColor = defaultBgColor;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)inviteUser:(NSString *)userId{
    
    NetWork_inviteNewUser *request = [[NetWork_inviteNewUser alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.userId = userId;
    
    [request startPostWithBlock:^(InviteNewUserRespone *result, NSString *msg, BOOL finished) {
        if(finished){
            [self showFaliureHUD:@"邀请成功"];
            [self.tableView.mj_header beginRefreshing]; //刷新数据
        } else {
            [self showFaliureHUD:msg];
        }
    }];
}

#pragma mark - 数据加载代理
-(void)loadNewData{
    //[self.tableView.mj_header endRefreshing];
    
    [self initRequest];
}

-(void)initRequest{
    
    NetWork_addressBookList *request = [[NetWork_addressBookList alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    //request.page = [NSNumber numberWithInt:self.page];;
    request.pageSize = @(20);
    [request showWaitMsg:@"加载中..." handle:self];
    [request startPostWithBlock:^(AddressBookRespone *result, NSString *msg, BOOL finished) {
        
        if(finished){
            [self loadTopicData:result];
        }
        else{
            [self showFaliureHUD:msg];
        }
    }];
}


-(void)loadTopicData:(AddressBookRespone *)queryFollowedResponse{
    [self.tableView.mj_header endRefreshing];

    if(self.currentPage == 0){
        [self.listDataArray removeAllObjects];
    }
    
    [self.listDataArray addObjectsFromArray:queryFollowedResponse.data];
    
    [self refreshNoDataViewWithListCount:self.listDataArray.count];

    
    [self.tableView reloadData];
}

#pragma mark - 设置tabbleView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = defaultJawBgColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listDataArray.count;
}
//设置cell的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:[InvitationCell cellId]];
    if(!cell){
        cell = [[InvitationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[InvitationCell cellId] ];
        cell.inviteUser = ^(NSString *userId) {
            [self inviteUser:userId];
        };
    }
    AaddressBookModel* model = [self.listDataArray objectAtIndex:indexPath.row];
    [cell dataBind:model];
    
    return cell;
    
}

//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return InvitationCellHeight;
}

//点击cell的触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
