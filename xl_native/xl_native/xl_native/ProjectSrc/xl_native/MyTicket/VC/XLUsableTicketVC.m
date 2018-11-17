//
//  XLUsableTicketVC.m
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLUsableTicketVC.h"
#import "XLMyWelfareTicketDetailVC.h"

#import "NetWork_consume_list.h"

@interface XLUsableTicketVC ()

@end

@implementation XLUsableTicketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNavBackGroundHiden  = YES;
    
    [self setupTable];
}
- (void)setupTable{
    
    [self.view addSubview:self.tableView];
    
    NSInteger tableViewHeight = ScreenHeight -kNavBarHeight_New - 52;
    
    self.tableView.size = [UIView getSize_width:ScreenWidth height:tableViewHeight];
    self.tableView.origin = [UIView getPoint_x:0 y:0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = defaultBgColor; //RGBFromColor(0xecedf1);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.backgroundColor = defaultBgColor;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 数据加载代理
-(void)loadNewData{
    [self initRequest];
}

-(void)initRequest{
    
    
    if([self.isused.trim isEqualToString:@"-1"]){
        NetWork_consume_list *request = [[NetWork_consume_list alloc] init];
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        [request startPostWithBlock:^(MyWelfareTicketRespone *result, NSString *msg, BOOL finished) {
            if (finished) {
                NSArray *arr = result.data;
                
                for (MyWelfareTicketModel *model in arr) {
                    model.isused = self.isused;
                    [self.mainDataArr addObject:model];
                }
                [self loadData:result];
            }
        }];
    }
    else{
        
        NetWork_myWelfareTicket *request = [[NetWork_myWelfareTicket alloc] init];
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        request.isused = self.isused;
        [request startPostWithBlock:^(MyWelfareTicketRespone *result, NSString *msg, BOOL finished) {
            if (finished) {
                NSArray *arr = result.data;
                
                for (MyWelfareTicketModel *model in arr) {
                    model.isused = self.isused;
                    [self.mainDataArr addObject:model];
                }
                [self loadData:result];
            }
        }];
    }
}

-(void)loadData:(MyWelfareTicketRespone *)queryFollowedResponse{
    [self.tableView.mj_header endRefreshing];
    
    if(self.currentPage == 0){
        [self.mainDataArr removeAllObjects];
    }
    [self.mainDataArr addObjectsFromArray:queryFollowedResponse.data];
    [self refreshNoDataViewWithListCount:self.mainDataArr.count];
    [self.tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.mainDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyWelfareTicketModel *model = self.mainDataArr[indexPath.row];
    
    MyWelfareTicketCell_temp *cell = [tableView dequeueReusableCellWithIdentifier:[MyWelfareTicketCell_temp cellId]];
    if(!cell){
        cell = [[MyWelfareTicketCell_temp alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MyWelfareTicketCell cellId] ];
    }
    [cell dataBind:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ///< -1，可兑换，0使用过，1未使用过，2过期
    if([self.isused.trim isEqualToString:@"-1"]){
        NSLog(@"兑换券");
    }
    else if([self.isused.trim isEqualToString:@"1"]){ //可使用
        
        MyWelfareTicketModel *model = self.mainDataArr[indexPath.row];
        XLMyWelfareTicketDetailVC *vc = [[XLMyWelfareTicketDetailVC alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([self.isused.trim isEqualToString:@"1"]){ //可使用
        NSLog(@"已使用");
    }
    else if([self.isused.trim isEqualToString:@"2"]){ //可使用
        NSLog(@"已过期");
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MyWelfareTicketCellHeight;
}



@end
