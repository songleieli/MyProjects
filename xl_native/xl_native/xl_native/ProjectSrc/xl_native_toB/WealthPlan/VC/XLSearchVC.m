//
//  XLSearchVC.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLSearchVC.h"
#import "XLHomePlanCell.h"
#import "XLOrderListCell.h"
#import "XLVoiceOrderView.h"

@interface XLSearchVC () <UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *search;
@property (assign, nonatomic) int page;
@property (copy, nonatomic) NSString *keywords;

@end

@implementation XLSearchVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isNavBackGroundHiden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    [self setupTable];
    self.mainTableView.hidden = YES;
}
- (void)setupSearchBar
{
    UISearchBar *search = [[UISearchBar alloc] init];
    search.showsCancelButton = YES;
    search.delegate = self;
    search.tintColor = [UIColor blackColor];
    [self.view addSubview:search];
    self.search = search;
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(KStatusBarHeight_New );
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.search endEditing:YES];
    self.keywords = searchBar.text;
    
    if (self.keywords) {
        self.mainTableView.hidden = NO;
        [self headerRereshing];
    } else {
        self.mainTableView.hidden = YES;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText {
    if (searchText.length == 0) {
        [self.mainDataArr removeAllObjects];
        [self.mainTableView reloadData];
        self.mainTableView.hidden = YES;
    }
}
- (void)loadUserListData
{
    NetWork_userList *request = [[NetWork_userList alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.page = [NSNumber numberWithInteger:self.page];
    request.pagesize = @(20);
    request.condition = self.keywords;
    
    [request startPostWithBlock:^(UserListRespone *result, NSString *msg, BOOL finished) {
        
        //        if (finished) {
        NSArray *arr = result.data;
        [self.mainDataArr addObjectsFromArray:arr];
        
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView reloadData];
        //        }
    }];
}
- (void)loadOrderListData
{
    NetWork_orderList *request = [[NetWork_orderList alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.page = [NSNumber numberWithInteger:self.page];
    request.pagesize = @(20);
    request.condition = self.keywords;
    
    [request startPostWithBlock:^(OrderListRespone *result, NSString *msg, BOOL finished) {
        
        if (finished) {
            NSArray *arr = result.data;
            [self.mainDataArr addObjectsFromArray:arr];
            [self.mainTableView reloadData];
        }
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

- (void)loadHomeData:(NSInteger)type
{
    NSString *dictKey = @"";
    
    if (type == 1) {
        dictKey = @"plantList";
    } else if (type == 2) {
        dictKey = @"animalList";
    } else if (type == 3) {
        dictKey = @"workList";
    }
    NetWork_homePlan *request = [[NetWork_homePlan alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.page = [NSNumber numberWithInt:self.page];
    request.keywords = self.keywords;
    request.pagesize = @(20);
    request.type = type;
    
    [request startPostWithBlock:^(HomePlanRespone *result, NSString *msg, BOOL finished) {
        
        if (finished) {
            NSDictionary *dict = result.data;
           
            NSArray *arr = dict[dictKey];
            for (NSDictionary *dic in arr) {
                HomePlanModel *model = [HomePlanModel yy_modelWithDictionary:dic];
                [self.mainDataArr addObject:model];
            }
            [self.mainTableView reloadData];
        }
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}
- (void)setupTable
{
    [self.mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XLOrderListCell class]) bundle:nil] forCellReuseIdentifier:orderListCellID];
    [self.mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XLHomePlanCell class]) bundle:nil] forCellReuseIdentifier:homePlanCellID];
    self.mainTableView.frame = CGRectMake(0, 50 + KStatusBarHeight_New, ScreenWidth, ScreenHeight - 50 - KStatusBarHeight_New);
    [self.view addSubview:self.mainTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([XLTBSingleTool sharedInstance].tabBarIndex == 1) {// 乡邻订单
        OrderListModel *model = self.mainDataArr[indexPath.row];

        XLOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:orderListCellID];
        cell.model = model;
        cell.voiceBtnclick = ^{
            XLVoiceOrderView *voice = [[XLVoiceOrderView alloc] init];
            voice.modalPresentationStyle = UIModalPresentationOverFullScreen;
            voice.model = model;
            voice.reloadTable = ^{
                [self loadOrderListData];
            };
            [self presentViewController:voice animated:YES completion:nil];
        };
        return cell;
    } else if ([XLTBSingleTool sharedInstance].tabBarIndex == 2) {// 乡邻档案
        UserListModel *model = self.mainDataArr[indexPath.row];
        
        XLOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:orderListCellID];
        cell.userListModel = model;
        return cell;
    }
    
    // 财富计划
    HomePlanModel *model = self.mainDataArr[indexPath.row];
    
    XLHomePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:homePlanCellID];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePlanModel *model = self.mainDataArr[indexPath.row];
    
    XLPlanDetailVC *vc = [[XLPlanDetailVC alloc] init];
    vc.planId = model.id;
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)headerRereshing
{
    self.page = 1;
    [self.mainDataArr removeAllObjects];
    
    if ([XLTBSingleTool sharedInstance].tabBarIndex == 1) {// 乡邻订单
        [self loadOrderListData];
    } else if ([XLTBSingleTool sharedInstance].tabBarIndex == 2) {// 乡邻档案
        [self loadUserListData];
    } else {// 财富计划
        [self loadHomeData:[XLTBSingleTool sharedInstance].searchType];
    }
}

-(void)footerRereshing
{
    self.page ++;
    
    if ([XLTBSingleTool sharedInstance].tabBarIndex == 1) {// 乡邻订单
        [self loadOrderListData];
    } else if ([XLTBSingleTool sharedInstance].tabBarIndex == 2) {// 乡邻档案
        [self loadUserListData];
    } else {// 财富计划
        [self loadHomeData:[XLTBSingleTool sharedInstance].searchType];
    }
}

@end
