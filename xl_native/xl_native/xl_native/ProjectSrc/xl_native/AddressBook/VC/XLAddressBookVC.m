//
//  XLAddressBookVC.m
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLAddressBookVC.h"
#import "AddressBookCell.h"

@interface XLAddressBookVC ()

@property (assign, nonatomic) int page;

@end

static NSString *const addressBookCellID = @"addressBookCellID";

@implementation XLAddressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    [self loadData:YES];
    [self setupTableView];
}
- (void)initNavTitle {
    if (self.vcType == 1) {
        self.title = @"邀请好友";
    } else if (self.vcType == 2) {
        self.title = @"我的粉丝";
    }
}
- (void)setupTableView
{
    [self.mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddressBookCell class]) bundle:nil] forCellReuseIdentifier:addressBookCellID];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavBarHeight_New);
        make.bottom.equalTo(self.view).offset(-KTabBarHeightOffset_New);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.vcType == 1) {
        AaddressBookModel *model = self.mainDataArr[indexPath.row];
        
        AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:addressBookCellID];
        cell.model = model;
       
        cell.inviteUser = ^(NSString *userId) {
            [self inviteUser:userId];
        };
        
        return cell;
    }
    
    MyFansListModel *fansModel = self.mainDataArr[indexPath.row];

    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:addressBookCellID];
    cell.fansModel = fansModel;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.vcType == 2) {
        MyFansListModel *model = self.mainDataArr[indexPath.row];

    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
/*
#pragma mark - tableView索引
//添加TableView头视图标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    NSDictionary *dict = self.mainDataArr[section];
    NSString *title = @"g";//dict[@"firstLetter"];
    return title;
}


//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *resultArray =[NSMutableArray arrayWithObject:UITableViewIndexSearch];
    for (NSDictionary *dict in self.mainDataArr) {
        NSString *title = @"f";//dict[@"firstLetter"];
        [resultArray addObject:title];
    }
    return resultArray;
}
//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch])
    {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    }
    else
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 添加了搜索标识
    }
}
*/
- (void)loadData:(BOOL)isLoadNew
{
    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
        
        if (isLoadNew) {
            self.page = 1;
            [self.mainDataArr removeAllObjects];
        } else {
            self.page ++;
        }
        
        if (self.vcType == 1) {
            NetWork_addressBookList *request = [[NetWork_addressBookList alloc] init];
            request.token = [GlobalData sharedInstance].loginDataModel.token;
            request.page = [NSNumber numberWithInt:self.page];;
            request.pageSize = @(20);
            
            [request startPostWithBlock:^(AddressBookRespone *result, NSString *msg, BOOL finished) {
                if(finished){
                    NSArray *dataArr = (NSArray *)result.data;
                    
                    for (AaddressBookModel *model in dataArr) {
                        [self.mainDataArr addObject:model];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.mainTableView reloadData];
                    });
                } else {
                    if (isLoadNew) {
                        
                    } else {
                        self.page --;
                    }
                }
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer endRefreshing];
            }];
        } else if (self.vcType == 2) {
            NetWork_myFansList *request = [[NetWork_myFansList alloc] init];
            request.token = [GlobalData sharedInstance].loginDataModel.token;
            request.page = [NSNumber numberWithInt:self.page];;
            request.pageSize = @(20);
            request.uid = [GlobalData sharedInstance].loginDataModel.userId;
            
            [request startPostWithBlock:^(MyFansListRespone *result, NSString *msg, BOOL finished) {
                if(finished){
                    NSDictionary *dict = (NSDictionary *)result.data;
                    NSArray *dataArr = dict[@"followList"];
                    for (NSDictionary *dict in dataArr) {
                        MyFansListModel *model = [MyFansListModel yy_modelWithDictionary:dict];
                        [self.mainDataArr addObject:model];
                    }

                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.mainTableView reloadData];
                    });
                } else {
                    if (isLoadNew) {
                        
                    } else {
                        self.page --;
                    }
                }
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer endRefreshing];
            }];
        }
        
    } cancelBlock:^{
    } isAnimat:YES];
}
- (void)headerRereshing
{
    [self loadData:YES];
}
- (void)footerRereshing
{
    [self loadData:NO];
}
- (void)inviteUser:(NSString *)userId
{
    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
        
        NetWork_inviteNewUser *request = [[NetWork_inviteNewUser alloc] init];
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        request.userId = userId;
        
        [request startPostWithBlock:^(InviteNewUserRespone *result, NSString *msg, BOOL finished) {
            if(finished){
                [SVProgressHUD showErrorWithStatus:@"邀请成功"];
                [self loadData:YES];
            } else {
                [SVProgressHUD showErrorWithStatus:msg];
            }
        }];
    } cancelBlock:^{
    } isAnimat:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


@end
