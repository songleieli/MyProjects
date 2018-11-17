//
//  NickNameViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "SelectAreaController.h"

#import "RegisterViewController.h"


@interface SelectAreaController ()<UITextFieldDelegate>{
}

/** 真实姓名 */
@property(nonatomic,strong) UITextField * nickNameTextField;
@property(nonatomic,strong) UITextField * userIdTextField;

@end

@implementation SelectAreaController

- (NSMutableArray *)listDataArray{
    
    if (!_listDataArray) {
        _listDataArray = [[NSMutableArray alloc] init];
    }
    return _listDataArray;
}



-(void)initNavTitle{
    
    self.title = @"选择区域";
    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = RGBFromColor(0xd4d4d4);
    [self.navBackGround addSubview:lineView];
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
    
    [self.view addSubview:self.tableView];
    
    //    [self.tableView.mj_header beginRefreshing];
    
}



#pragma mark - 数据加载代理
-(void)loadNewData{
    [self.tableView.mj_header endRefreshing];
    
    [self initRequest];
}

-(void)initRequest{
    
    NetWork_getSonElement *request = [[NetWork_getSonElement alloc] init];
    if(self.parentModel){
        request.id = self.parentModel.id;
    }
    //request.token = [GlobalData sharedInstance].loginDataModel.token;
    [request startPostWithBlock:^(id result, NSString *msg) {
        /*
         *处理缓存
         */
    } finishBlock:^(SonElementRespone *result, NSString *msg, BOOL finished) {
        NSLog(@"--------");
        
        if(finished){
            [self loadTopicData:result];
        }
        else{
            [self showFaliureHUD:msg];
        }
    }];
}


-(void)loadTopicData:(SonElementRespone *)sonElementRespone{
    [self.tableView.mj_header endRefreshing];
    
    if(self.currentPage == 0){
        [self.listDataArray removeAllObjects];
    }
    
    [self.listDataArray addObjectsFromArray:sonElementRespone.data];
    
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
    
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:[AreaCell cellId]];
    if(!cell){
        cell = [[AreaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[AreaCell cellId] ];
    }
    SonElementModel* model = [self.listDataArray objectAtIndex:indexPath.row];
    [cell dataBind:model];
    
    return cell;
}

//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AreaCellHeight;
}

//点击cell的触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SonElementModel* model = [self.listDataArray objectAtIndex:indexPath.row];
    NetWork_getSonElement *request = [[NetWork_getSonElement alloc] init];
    request.id = model.id;
    [request showWaitMsg:@"请稍后" handle:self];
    [request startPostWithBlock:^(SonElementRespone *result, NSString *msg, BOOL finished) {
        if(finished){
            
            RegisterViewController *vc = nil;
            NSArray *pushVCAry=[self.navigationController viewControllers];
            if(pushVCAry.count > 1){
                vc = [pushVCAry objectAtIndex:1]; //注册页面
                [vc.listSelectArea addObject:model];
            }
            
            if(result.data.count>0){
                
                SelectAreaController *registerViewController = [[SelectAreaController alloc] init];
                [registerViewController.listDataArray addObjectsFromArray:result.data];
                registerViewController.parentModel = model;
                [self.navigationController pushViewController:registerViewController animated:YES];
            }
            else{
                
                
                    NSLog(@"-----最后一级------");
                if(vc){
                    [vc didSelectArea]; //处理选择的字符串，为注册准备。
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
        else{
            [self showFaliureHUD:msg];
        }
    }];
}

@end
