//
//  XLBreedingPlanVC.m
//  xl_native
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLBreedingPlanVC.h"
#import "XLHomePlanCell.h"

@interface XLBreedingPlanVC ()

@property (assign, nonatomic) int page;

@end

@implementation XLBreedingPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNewData];
    [self setupTable];
}
- (void)loadData
{
    NetWork_homePlan *request = [[NetWork_homePlan alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.page = [NSNumber numberWithInt:self.page];
    request.pagesize = @(20);
    request.type = 2;
    
    [request startPostWithBlock:^(HomePlanRespone *result, NSString *msg, BOOL finished) {
        
        if (finished) {
            NSDictionary *dict = result.data;
            if (self.totallBlock) {
                self.totallBlock(result.totall);
            }
            NSArray *arr = dict[@"animalList"];
            for (NSDictionary *dic in arr) {
                HomePlanModel *model = [HomePlanModel yy_modelWithDictionary:dic];
                [self.mainDataArr addObject:model];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }        
    }];
}
- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XLHomePlanCell class]) bundle:nil] forCellReuseIdentifier:homePlanCellID];
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - kNavBarHeight_New - kTabBarHeight_New - 52 - 46);
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
    
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
- (void)initNavTitle {
    self.isNavBackGroundHiden = YES;
}

@end
