//
//  FirstFunctionViewController.m
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "TBOrderViewController.h"
#import "Callback_token.h"
#import "XLOrderListCell.h"
#import "XLVoiceOrderView.h"

@interface TBOrderViewController ()

@property (assign, nonatomic) NSInteger page;

@end

@implementation TBOrderViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*四个一级页面判断需要登录，我爱我乡没有游客模式*/
    [[TBLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
    } cancelBlock:nil isAnimat:YES];

    self.tabBar.top = [self getTabbarTop];    //  重新设置tabbar的高度
}

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"乡邻订单";
    [self addNavigationItem];
    [self addSearchBar];
    
    [self loadNewData];
    [self setupTable];
}

- (void)loadData
{
    NetWork_orderList *request = [[NetWork_orderList alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.page = [NSNumber numberWithInteger:self.page];
    request.pagesize = @(20);
    [request startPostWithBlock:^(OrderListRespone *result, NSString *msg, BOOL finished) {
        
        if (finished) {
            NSArray *arr = result.data;
            [self.mainDataArr addObjectsFromArray:arr];
            
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    }];
}
- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XLOrderListCell class]) bundle:nil] forCellReuseIdentifier:orderListCellID];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.navBackGround.frame) + 46, ScreenWidth, ScreenHeight - kNavBarHeight_New - kTabBarHeight_New - 46);
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = self.mainDataArr[indexPath.row];
    
    XLOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:orderListCellID];
    cell.model = model;
    cell.voiceBtnclick = ^{
        XLVoiceOrderView *voice = [[XLVoiceOrderView alloc] init];
        voice.modalPresentationStyle = UIModalPresentationOverFullScreen;
        voice.model = model;
        voice.reloadTable = ^{
            [self loadNewData];
        };
        [self presentViewController:voice animated:YES completion:nil];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = self.mainDataArr[indexPath.row];

    XLVoiceOrderView *voice = [[XLVoiceOrderView alloc] init];
    voice.modalPresentationStyle = UIModalPresentationOverFullScreen;
    voice.model = model;
    voice.reloadTable = ^{
        [self loadNewData];
    };
    [self presentViewController:voice animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void) loadNewData{
    self.page = 1;
    [self.mainDataArr removeAllObjects];
    [self loadData];
}
- (void)loadMoreData {
    self.page ++;
    [self loadData];
}

@end
