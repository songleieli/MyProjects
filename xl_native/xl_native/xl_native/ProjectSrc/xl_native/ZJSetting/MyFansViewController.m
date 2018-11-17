//
//  NickNameViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "MyFansViewController.h"
#import "NetWork_queryFollower.h" //粉丝列表

@interface MyFansViewController ()<UITextFieldDelegate>{
    BOOL _canedit;
}

/** 真实姓名 */
@property(nonatomic,strong) UITextField * nickNameTextField;
@property(nonatomic,strong) UITextField * userIdTextField;

@end

@implementation MyFansViewController

- (NSMutableArray *)listDataArray{
    
    if (!_listDataArray) {
        _listDataArray = [[NSMutableArray alloc] init];
    }
    return _listDataArray;
}

-(void)initNavTitle{
    
    self.title = @"粉丝列表";
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

#pragma mark - 数据加载代理
-(void)loadNewData{
    //[self.tableView.mj_header endRefreshing];
    
    [self initRequest];
}

-(void)initRequest{
    
    NetWork_queryFollower *request = [[NetWork_queryFollower alloc] init];
    request.page = [NSNumber numberWithInteger:self.currentPage+1];
    request.pageSize = @(10);
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.uid = self.userId;
    [request startPostWithBlock:^(id result, NSString *msg) {
        /*
         *处理缓存
         */
    } finishBlock:^(id result, NSString *msg, BOOL finished) {
        NSLog(@"--------");
        
        if(finished){
            [self loadTopicData:result];
        }
        else{
            [self showFaliureHUD:msg];
        }
    }];
}


-(void)loadTopicData:(QueryFollowedResponse *)queryFollowedResponse{
    [self.tableView.mj_header endRefreshing];

    if(self.currentPage == 0){
        [self.listDataArray removeAllObjects];
    }
    
    [self.listDataArray addObjectsFromArray:queryFollowedResponse.data.followList];
    
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
    
    MyFansCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyFansCell cellId]];
    if(!cell){
        cell = [[MyFansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyFansCell cellId] ];
    }
    QueryFollowedModel* model = [self.listDataArray objectAtIndex:indexPath.row];
    [cell dataBind:model];
    
    return cell;
    
}

//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MyFansCellHeight;
}

//点击cell的触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
