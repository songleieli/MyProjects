//
//  TopicViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/26.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//
#import "TopicViewController.h"
#import "TopicCell.h"
#import "TopicDetailViewController.h"
#import "UIView+TTFramePopupView.h"//第三方
#import "UserInfoHeader.h"
#import "TopicHeader.h"

#import "XLMenuView.h"
#import "XLAddressBookVC.h"

//网络请求
#import "Network_hotTopicList.h"
#import "NetWork_findAllTagList.h"
#import "NetWork_topicPraise.h"
#import "DeliverArticleViewController.h"

//播放器
#import "PlayerViewController.h"
#import "SwitchPlayerViewController.h"

@interface TopicViewController ()<UITableViewDelegate,UITableViewDataSource,ClickDelegate>{
//    BOOL _isSelectOriginalPhoto;
}

@property(nonatomic,strong) NSMutableArray *listDataArray;
@property(nonatomic,strong) TopicCell *cell;

@property(nonatomic,strong) NSMutableArray *selectedPhotos;
@property(nonatomic,strong) NSMutableArray *selectedAssets;
@property (strong, nonatomic) UserInfoHeader *userInfoHeader;
@property (strong, nonatomic) TopicHeader *topicHeader;

@end


@implementation TopicViewController


- (UIButton *)maskView{

    if (!_maskView) {
        _maskView = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskView.top = 0;
        _maskView.left = 0.0;
        _maskView.width = ScreenWidth;
        _maskView.height = ScreenHeight;
        _maskView.backgroundColor = RGBAlphaColor(0, 0, 0, 0.5);
        [_maskView addTarget:self action:@selector(hideMaskView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_maskView];
        
        [self.view bringSubviewToFront:_maskView];
        _maskView.hidden = YES;
    }
    return _maskView;
}

- (XLFlollowUserView *)flollowUserView{
    if (!_flollowUserView) {
        CGRect frame = CGRectMake(20, 40, self.maskView.width-40, self.maskView.height - 100);
        _flollowUserView = [[XLFlollowUserView alloc] initWithFrame:frame];
        _flollowUserView.layer.cornerRadius = 6.0f;
        [self.maskView addSubview:_flollowUserView];
        
        __weak __typeof(self) weakSelf = self;
        [_flollowUserView setDidSelectUserBlock:^(NSMutableArray *selectArray) {
            
            //选择关注用户的ids
            NSMutableString *userIds = [[NSMutableString alloc] init];
            for(int i=0;i<selectArray.count;i++){
                UserModel *model = [selectArray objectAtIndex:i];
                if(i== selectArray.count -1){
                    [userIds appendString:model.id];
                }
                else{
                    [userIds appendString:[NSString stringWithFormat:@"%@,",model.id]];
                }
            }
            
            //关注关注成功后隐藏
            NetWork_addFollow *request = [[NetWork_addFollow alloc] init];
            request.followedId = userIds;
            request.token = [GlobalData sharedInstance].loginDataModel.token;
            [request showWaitMsg:@"正在加载，请稍后..." handle:weakSelf];
            [request startPostWithBlock:^(AddFollowResponse *result, NSString *msg, BOOL finished) {                
                if(finished){
                    weakSelf.maskView.hidden = YES;
                }
            }];
        }];
    }
    return _flollowUserView;
}

-(void)locationClick{
    self.currentPage = 0;
    [self initRequest];
}

-(void)sendClick{
    
    [self showFaliureHUD:@"发布成功"];
    self.currentPage = 0;
    [self initRequest];
}


-(void)initNavTitle{
    
    self.isNavBackGroundHiden  = NO;
    self.navBackGround.backgroundColor = [UIColor whiteColor];
    self.lableNavTitle.textColor = [UIColor blackColor];

    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = XLColorCutLine;
    [self.navBackGround addSubview:lineView];
    
    if (self.topicViewControllerType == TopicViewControllerTypeUserInfo) {
        self.isNavBackGroundHiden  = NO;
        self.title = @"个人主页";
        [self.btnLeft setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateNormal];
        
    } else if (self.topicViewControllerType == TopicViewControllerTypeHotTopic) {
        self.isNavBackGroundHiden  = NO;
        self.title = @"群组主页";
        [self.btnLeft setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateNormal];
    } else {
        
        UIButton *buttonHot = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonHot.tag = 92;
        buttonHot.size = [UIView getSize_width:100 height:28];
        buttonHot.top = self.navBackGround.height - buttonHot.height - 5;
        buttonHot.left = self.navBackGround.width/2 - buttonHot.width - 5;
        buttonHot.layer.cornerRadius = 14;
        buttonHot.layer.borderWidth = 1.0f;
        buttonHot.layer.masksToBounds = YES;
        [buttonHot setTitle:@"热门" forState:UIControlStateNormal];
        //正常
        [buttonHot setTitleColor:XLColorMainLableAndTitle forState:UIControlStateNormal];
        [buttonHot setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
        //选中
        buttonHot.layer.borderColor = XLColorMainPart.CGColor;
        [buttonHot setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [buttonHot setBackgroundColor:XLColorMainPart forState:UIControlStateSelected];
        buttonHot.titleLabel.font = [UIFont defaultFontWithSize:16];
        [buttonHot addTarget:self action:@selector(topBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navBackGround addSubview:buttonHot];
        buttonHot.selected = YES;
        self.topicType = @"hot"; //默认热门

        
        UIButton *buttonFollow = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFollow.tag = 93;
        buttonFollow.size = [UIView getSize_width:100 height:28];
        buttonFollow.top = self.navBackGround.height - buttonHot.height - 5;
        buttonFollow.left = self.navBackGround.width/2 + 5;
        buttonFollow.layer.cornerRadius = 14;
        buttonFollow.layer.borderWidth = 1.0f;
        buttonFollow.layer.masksToBounds = YES;
        [buttonFollow setTitle:@"关注" forState:UIControlStateNormal];
        
        [buttonFollow setTitleColor:XLColorMainLableAndTitle forState:UIControlStateNormal];
        [buttonFollow setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
        //选中
        buttonFollow.layer.borderColor = XLColorMainLableAndTitle.CGColor;
        [buttonFollow setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [buttonFollow setBackgroundColor:XLColorMainPart forState:UIControlStateSelected];
        
        buttonFollow.titleLabel.font = [UIFont defaultFontWithSize:16];
        [buttonFollow addTarget:self action:@selector(topBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navBackGround addSubview:buttonFollow];
        buttonFollow.selected = NO;
        
        
        UIButton *rightButton = [[UIButton alloc]init];
        rightButton.tag = 91;
        rightButton.size = [UIView getSize_width:20 height:20];
        rightButton.origin = [UIView getPoint_x:ScreenWidth - 40 y:self.navBackGround.height - 32 ];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"public_navgationgItem"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
        [self.navBackGround addSubview:rightButton];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    
//    /*四个一级页面判断需要登录，我爱我乡没有游客模式*/
//    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
//    } cancelBlock:nil isAnimat:YES];
    
    if (self.topicViewControllerType == TopicViewControllerTypeHotTopic || self.topicViewControllerType == TopicViewControllerTypeUserInfo) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.tabBar.top = ScreenHeight + kTabBarHeight_New;    //  重新设置tabbar的高度
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForRemoteNotification];//注册通知
    [self setupUI]; //设置UI
    
    if([GlobalData sharedInstance].hasLogin){
        [self.tableView.mj_header beginRefreshing];
    }
}


-(void)registerForRemoteNotification{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess)
                                                 name:NSNotificationUserLoginSuccess
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(afterPublish:)
                                                 name:NSNotificationPublishState
                                               object:nil];
    
    
//    //点赞
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationClick) name:@"zan" object:nil];
//    //发布话题
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendClick) name:@"send" object:nil];
    
    
}

-(void)afterPublish:(id)sender{
    self.currentPage = 0;
    [self initRequest];
}

-(void)changeUserState:(id)sender{
    self.currentPage = 0;
    [self initRequest];
}

-(void)setupUI{
    
    if (self.topicViewControllerType == TopicViewControllerTypeUserInfo || self.topicViewControllerType == TopicViewControllerTypeHotTopic) {
        self.tableView.size = [UIView getSize_width:ScreenWidth height:ScreenHeight - KViewStartTopOffset_New];
        self.tableView.origin = [UIView getPoint_x:0 y:self.navBackGround.height];
    } else {
        self.tableView.size = [UIView getSize_width:ScreenWidth height:ScreenHeight -kNavBarHeight_New - kTabBarHeight_New];
        self.tableView.origin = [UIView getPoint_x:0 y:self.navBackGround.height];
    }
    
    self.tableView.backgroundColor = XLColorBackgroundColor;
    self.tableView.mj_header.backgroundColor = XLColorBackgroundColor;
    self.tableView.mj_footer.backgroundColor = XLColorBackgroundColor;
    self.tableView.mj_header.mj_h = 30;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.topicViewControllerType == TopicViewControllerTypeUserInfo) {
        self.tableView.tableHeaderView = self.userInfoHeader;
    } else if (self.topicViewControllerType == TopicViewControllerTypeHotTopic) {
        self.tableView.tableHeaderView = self.topicHeader;
    } else {
        UIView *viewHead = [[UIView alloc]init];
        viewHead.size = [UIView getSize_width:self.tableView.width height:10];
        viewHead.origin = [UIView getPoint_x:0 y:0];
        viewHead.backgroundColor = XLColorBackgroundColor;
        self.tableView.tableHeaderView = viewHead;
    }
    [self.view addSubview:self.tableView];
}

- (void)publish{
    
    XLMenuView *menuView = [[XLMenuView alloc] init];
    menuView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    menuView.select = ^(NSInteger num) {
        if (num == 1) {
            [self publishTopic];
        } else if (num == 2) {
            
            InvitationViewController *invitationViewController = [[InvitationViewController alloc] init];
            [self pushNewVC:invitationViewController animated:YES];
            
            
            
//            XLAddressBookVC *vc = [[XLAddressBookVC alloc] init];
//            vc.vcType = 1;
//            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    [self presentViewController:menuView animated:NO completion:nil];
}

#pragma -mark  ------  网络请求  ----------

-(void)initRequest{
    if (self.topicViewControllerType == TopicViewControllerTypeUserInfo) {
        [self getAppUserInfo];
    } else if (self.topicViewControllerType == TopicViewControllerTypeHotTopic) {
        [self hotTopicDetail];
    }
    
    if(self.userId.length > 0){
        [self initHotRequest];
    }
    else{
        if([self.topicType.trim isEqualToString:@"hot"]){
            [self initHotRequest];
        }
        else{
            [self initFollowRequest];
        }
    }
}

- (void)hotTopicDetail{
    NetWork_hotTopic *detail = [[NetWork_hotTopic alloc] init];
    detail.typeId = self.hotTopicId;
    [detail startPostWithBlock:^(allTopicListLoginResponse *result, NSString *msg, BOOL finished) {
        if (finished) {
            NSDictionary *dict = (NSDictionary *)result.data;
            NSString *tagName = dict[@"tagName"];
            NSInteger topicNum = [dict[@"topicNum"] integerValue];
            NSInteger userNumber = [dict[@"userNumber"] integerValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.topicHeader.topic.text = [NSString stringWithFormat:@"#%@",tagName];
                self.topicHeader.total.text = userNumber > 99999 ? @"10万+" : [NSString stringWithFormat:@"参与数: %ld",userNumber] ;
                self.topicHeader.num.text = [NSString stringWithFormat:@"发帖数: %ld",topicNum];
            });
        }
    }];
}

-(void)initHotRequest {
    
    /* 热门话题列表 */
    __weak __typeof (self) weakSelf = self;
    Network_hotTopicList * alltoplist = [[Network_hotTopicList alloc] init];
    
    alltoplist.longitude = @([[GlobalData sharedInstance].longitude floatValue]);
    alltoplist.latitude = @([[GlobalData sharedInstance].latitude floatValue]);
    if(self.userId.length > 0){
        alltoplist.publishId = self.userId;
    }
    alltoplist.pageNo = [NSNumber numberWithInteger:self.currentPage+1];
    alltoplist.token = [GlobalData sharedInstance].loginDataModel.token;
    alltoplist.pageSize = @(10);

    [alltoplist showWaitMsg:@"" handle:self];
    [alltoplist startPostWithBlock:^(id result, NSString *msg) {
        /*
         *暂时先不考虑缓存的问题
         */
    } finishBlock:^(allTopicListLoginResponse *result, NSString *msg, BOOL finished) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (finished) {
            [weakSelf loadTopicData:result isCash:NO];
            NSLog(@"---------");
        }else{
            [weakSelf showFaliureHUD:msg];
            self.tableView.mj_footer.hidden = YES;
            sleep(1);
            self.tableView.mj_footer.hidden = NO;
            self.tableView.mj_header.hidden = NO;
        }
    }];
    
    
}

-(void)initFollowRequest{
    /* 热门话题列表 */
    __weak __typeof (self) weakSelf = self;
    Network_followTopicList * alltoplist = [[Network_followTopicList alloc] init];
    
    alltoplist.longitude = @([[GlobalData sharedInstance].longitude floatValue]);
    alltoplist.latitude = @([[GlobalData sharedInstance].latitude floatValue]);
    
    alltoplist.pageNo = [NSNumber numberWithInteger:self.currentPage+1];
    alltoplist.token = [GlobalData sharedInstance].loginDataModel.token;
    alltoplist.pageSize = @(10);
    
    [alltoplist showWaitMsg:@"" handle:self];
    [alltoplist startPostWithBlock:^(id result, NSString *msg) {
        /*
         *暂时先不考虑缓存的问题
         */
    } finishBlock:^(allTopicListLoginResponse *result, NSString *msg, BOOL finished) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (finished) {
            if(result.data.exists){
                [weakSelf loadTopicData:result isCash:NO];
            }
            else{
                [weakSelf showFollow:result.data.listUsers]; //显示关注用户列表
            }
            NSLog(@"---------");
        }else{
            [weakSelf showFaliureHUD:msg];
            self.tableView.mj_footer.hidden = YES;
            sleep(1);
            self.tableView.mj_footer.hidden = NO;
            self.tableView.mj_header.hidden = NO;
        }
    }];
}

//empire state of mine
#pragma -mark ----------- CustomMethod -------------

-(void)loginSuccess{
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)countCellHeight:(NSArray *)modelList{
    
    NSInteger i = 0;
    
    for(ListLoginModel *listLoginModel in modelList){
        
        NSLog(@"-----------------i=%ld",i);
        
        //名字
        NSString * nameString = [[NSString alloc] init];
        if ([listLoginModel.publisher isEqualToString:@""]) {
            nameString = @"暂无昵称";
        }else{
            nameString = listLoginModel.publisher;
        }
        CGRect nameLabelSize = [nameString boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.0],NSFontAttributeName, nil] context:nil];
        listLoginModel.labelContectW = nameLabelSize.size.width;
        //类型
        CGRect typeLabelSize = [listLoginModel.typeName boundingRectWithSize:CGSizeMake(1000, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0],NSFontAttributeName, nil] context:nil];
        listLoginModel.typelabelContectW = typeLabelSize.size.width;
        
        //时间
        CGRect timeLabelSize = [listLoginModel.showTime boundingRectWithSize:CGSizeMake(1000, 12) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0],NSFontAttributeName, nil] context:nil];
        listLoginModel.timelabelContectW = timeLabelSize.size.width + 1;
        
        
        if(listLoginModel.typeName.length > 0){
            listLoginModel.topicContent = [NSString stringWithFormat:@"#%@#%@",listLoginModel.typeName,listLoginModel.topicContent];
        }
        //内容
        CGFloat labelContectW = ScreenWidth - 91;
        CGRect contentLabelSize = [listLoginModel.topicContent boundingRectWithSize:CGSizeMake(labelContectW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont defaultFontWithSize:14],NSFontAttributeName, nil] context:nil];
        CGFloat labelContectH = contentLabelSize.size.height;
        
        listLoginModel.heightBgTopBgView = 68;
        listLoginModel.heightBgBottomView = 50;
        listLoginModel.heightContentLable = contentLabelSize.size.height + 10;
        listLoginModel.widthContentLable = ScreenWidth - 90;
        //locationlabelContectW 位置宽度 （ScreenWidth - 91）内容最大宽度
        listLoginModel.locationlabelContectW = ScreenWidth - 91 - listLoginModel.timelabelContectW;

        
        
        NSInteger height;
        
        /* 乡邻没有缩略图的服务，暂时先屏蔽这个功能。
         //计算collectionView的宽度
         for(ImagesLoginModel *modelImage in listLoginModel.images){ //将缩略图变成真正的缩略图，以宽为准，等比例缩放
         modelImage.breviaryUrl = [NSString stringWithFormat:@"%@@400w_400h",modelImage.breviaryUrl];
         }
         */
        
        if([listLoginModel.topicType.trim isEqualToString:@"video"]){
            for(ImagesLoginModel *modelImage in listLoginModel.medias){
                
                modelImage.breviaryUrl = [NSString stringWithFormat:@"%@@thumb.jpg",modelImage.breviaryUrl];
                
            }
        }
        
        if (listLoginModel.medias.count == 4) {
            if ([UIScreen mainScreen].bounds.size.width > 320 && [UIScreen mainScreen].bounds.size.width <= 375) {
                listLoginModel.widthFourColloctionView = labelContectW - 108;
                
            }else if([UIScreen mainScreen].bounds.size.width > 375){
                listLoginModel.widthFourColloctionView = labelContectW - 122;
            }
            else{
                listLoginModel.widthFourColloctionView = labelContectW - 89;
            }
            
        }else if (listLoginModel.medias.count == 1){
            
            ImagesLoginModel *imageModel = listLoginModel.medias[0];
            UIImageView * imageView = [[UIImageView alloc] init];
            __block CGFloat H;
            __block CGFloat W;
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            UIImage *image = [[manager imageCache] imageFromDiskCacheForKey:[NSURL URLWithString:imageModel.breviaryUrl].absoluteString];
            if (image) {
                NSLog(@"----------------2.1.1 图片存在-------------%@--",imageModel.breviaryUrl.trim);
                imageView.image = [[manager imageCache] imageFromDiskCacheForKey:[NSURL URLWithString:imageModel.breviaryUrl].absoluteString];
                H = imageView.image.size.height;
                W = imageView.image.size.width;
            }
            else{
                NSLog(@"----------------2.1.1 图片不存在-------------%@",imageModel.breviaryUrl.trim);
                /*
                 *如果图片不存在，默认图片大小，因为如果图片缓存不存在，那么在线获取图片宽高会卡死，所以通过默认值来设置第一次加载图片的kuan'gao
                 */
                if([listLoginModel.topicType.trim isEqualToString:@"video"]){
                    H = 640.0f;
                    W = 480.0f;
                }
                else{
                    H = 75.0f;
                    W = 100.0f;
                }
            }
            NSLog(@"----------------2.2 图片宽高计算完成---------------");
            
            CGFloat width;
            width = (128 * W)/H;
            
            if (width > listLoginModel.widthContentLable) {
                width = listLoginModel.widthContentLable;
            }
            if (width < 216/3) {
                width = 216/3;
            }
            
            listLoginModel.widthColloctionView = width;
            listLoginModel.widthOneImg = width;
        }
        else{
            listLoginModel.widthColloctionView = labelContectW - 17;
        }
        
        /*
         *计算collocationView 的高度
         */
        if (listLoginModel.medias.count>0) {
            listLoginModel.margin = 4;
            listLoginModel.colCount = 3;
            listLoginModel.rowCount = (listLoginModel.medias.count)/listLoginModel.colCount;
            listLoginModel.marginOne = 16;
            
            NSInteger modular = (listLoginModel.medias.count)%listLoginModel.colCount;
            listLoginModel.rowCount = (listLoginModel.medias.count)/listLoginModel.colCount;
            if(modular > 0){
                listLoginModel.rowCount = listLoginModel.rowCount + 1;
            }
            
            if (listLoginModel.medias.count == 4) {
                
                listLoginModel.itemWH = ((listLoginModel.widthFourColloctionView -
                                          3*listLoginModel.margin));
                height =listLoginModel.margin + listLoginModel.margin*2 +  listLoginModel.itemWH;
                
            }else if (listLoginModel.medias.count == 1){
                
                height = 128;
                listLoginModel.heightForOneImage = height;
                
            }
            else{
                listLoginModel.itemWH = ((listLoginModel.widthColloctionView -
                                          2*listLoginModel.margin -
                                          (listLoginModel.colCount - 1)*2*listLoginModel.margin))/listLoginModel.colCount;
                height = (listLoginModel.rowCount - 1)*listLoginModel.margin + listLoginModel.margin*2 + listLoginModel.rowCount * listLoginModel.itemWH;
            }
            
            
            listLoginModel.heightColloctionView = height;
        }else{
            listLoginModel.heightColloctionView = 0;
            listLoginModel.marginOne = 0;
        }
        
        listLoginModel.heightCell = listLoginModel.heightBgTopBgView +
        labelContectH +
        listLoginModel.marginOne +
        listLoginModel.heightColloctionView +
        listLoginModel.heightBgBottomView +
        12;
        
        i++;
    }
    
    NSLog(@"-----------------end");
}

-(void)loadTopicData:(allTopicListLoginResponse *)topicListLoginResponse  isCash:(BOOL)isCash{
    
    self.totalCount = [topicListLoginResponse.data.count integerValue] ;
    if (self.currentPage == 0 ) {
        self.listDataArray = [[NSMutableArray alloc]init];
        
        [self refreshNoDataViewWithListCount: topicListLoginResponse.data.list.count];
        //    第二次从网络求情第一页数据的时候打开。
        if (isCash == NO) {
            self.tableView.mj_footer.hidden = NO;
        }
    }
    else{
        if (isCash == NO) {
            self.tableView.mj_header.hidden = NO;
        }
    }
    
    [self countCellHeight:topicListLoginResponse.data.list];
    
    [self.listDataArray addObjectsFromArray:topicListLoginResponse.data.list];
    if (isCash == NO) {
        self.currentPage += 1;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }
    [self.tableView reloadData];
}

-(void)showFollow:(NSArray*)userList{
    
    self.maskView.hidden = NO;
    [self.flollowUserView dataBind:userList];
}

-(void)publishTopic{
    DeliverArticleViewController * deliverArticel = [[DeliverArticleViewController alloc] init];
    [self pushNewVC:deliverArticel animated:YES];
}

-(void)topBtnCLick:(UIButton*)btn{
    
    if(btn.selected){
        return;
    }
    
    UIButton *buttonHot  = [self.navBackGround viewWithTag:92];
    UIButton *buttonFollow  = [self.navBackGround viewWithTag:93];
    
    if(btn == buttonHot){
        buttonFollow.selected = NO;
        buttonFollow.layer.borderColor = XLColorMainLableAndTitle.CGColor;
        buttonHot.layer.borderColor = XLColorMainPart.CGColor;
        
        //加载热门数据
        self.topicType = @"hot";
    }
    else{
        buttonHot.selected = NO;
        buttonHot.layer.borderColor = XLColorMainLableAndTitle.CGColor;
        buttonFollow.layer.borderColor = XLColorMainPart.CGColor;
        //加载关注数据
        self.topicType = @"follow";

    }
    btn.selected = !btn.selected;
    [self.tableView.mj_header beginRefreshing];
}

-(void)hideMaskView{
    self.maskView.hidden = YES;
}

#pragma mark - 数据加载代理
-(void)loadNewData{
    
    self.tableView.mj_footer.hidden = YES;
    self.currentPage = 0;
    [self initRequest];
}

-(void)loadMoreData{
    self.tableView.mj_header.hidden = YES;
    [self initRequest];
    if (self.totalCount == self.listDataArray.count) {
        [self showFaliureHUD:@"暂无更多数据"];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.tableView.mj_footer.hidden = YES;
    }
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
    
    NSString *activiteyIdentifier = @"TopicCell";
    _cell = (TopicCell *)[tableView dequeueReusableCellWithIdentifier:activiteyIdentifier];
    
    for (UIView *view in _cell.contentView.subviews) {
        if ([view isKindOfClass:[ImageButton class]] ) {
            [view removeFromSuperview];
        }
    }
    for (UIView *view in _cell.maskView.subviews) {
        if ([view isKindOfClass:[ButtonMaskView class]] ) {
            [view removeFromSuperview];
        }
    }
    
    if(_cell == nil){
        _cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activiteyIdentifier];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        _cell.commentDelegate = self;
        _cell.clickDelegate = self;
//        _cell.viewBgDelegate = self;
    }
    _cell.listLoginModel = [self.listDataArray objectAtIndex:indexPath.row];
    
    return _cell;
}

//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ListLoginModel *model = [self.listDataArray objectAtIndex:indexPath.row];
    return model.heightCell - MasScale_1080(10);
}

//设置组头部视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
//设置组底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


#pragma mark ------- 设置topicCell的代理  ------
/*点击播放视频*/
-(void)clickPlayVedio:(ListLoginModel*)listLoginModel{
    
    if(self.userId.length == 0){ //在个人主页面暂时不能播放视频
        
        if(listLoginModel.medias.count > 0){
            
            FindAllTagDataModel *tagModel = [[FindAllTagDataModel alloc] init];
            tagModel.id = listLoginModel.typeId;
            tagModel.tagName = listLoginModel.typeName;
            
            SwitchPlayerViewController *playVC =[[SwitchPlayerViewController alloc] init];
            if([self.topicType isEqualToString:@"hot"]){
                playVC.videoType = VideoTypeHot;
            }
            else{
                playVC.videoType = VideoTypeFollow;
            }
            playVC.currTagModel = tagModel;
            playVC.clickItem = listLoginModel;
            [self.navigationController pushViewController:playVC animated:YES];
        }
    }
}

/*点击tag*/
-(void)clickTag:(ListLoginModel*)listLoginModel{
    
    if(self.userId.length == 0){ //在个人主页面，暂时不能查看标签
        
        TopicViewController *vc = [[TopicViewController alloc] init];
        vc.topicViewControllerType = TopicViewControllerTypeHotTopic;
        vc.hotTopicId = listLoginModel.typeId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//列表页点赞
-(void)clickPraiseDelegate:(NSString *)topicId andCell:(TopicCell *)cell{
    
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        [self showFaliureHUD:@"没有网络,请先检查网络设置"];
        return;
    }
    
    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
        NetWork_topicPraise * topicPraise = [[NetWork_topicPraise alloc]init];
        topicPraise.token = [GlobalData sharedInstance].loginDataModel.token;
        topicPraise.topicId = topicId;
        [topicPraise showWaitMsg:@"" handle:self];
        [topicPraise startPostWithBlock:^(TopicPraiseResponse * result, NSString *msg, BOOL finished) {
            
            if ([msg isEqualToString:@"已点赞，请勿重复点赞"]) {
                [self showFaliureHUD:@"已点赞，请勿重复点赞"];
                return;
            }
            if (finished) {
                NSInteger zanCount = [cell.listLoginModel.praiseNum integerValue];
                zanCount += 1;
                cell.listLoginModel.praiseNum = [NSNumber numberWithInteger:zanCount];
                cell.listLoginModel.praiseFlag = YES;
                cell.listLoginModel = cell.listLoginModel;
                
                [[AddIntegralTool sharedInstance] addIntegral:self code:@"10008"];
            }
        }];
    } cancelBlock:^{
    }showMsgTarget:self isAnimat:YES];
}

/*点击评论按钮*/
-(void)clickCommentDelegate:(ListLoginModel *)listLoginModel{
    
    TopicDetailViewController * topicDetail = [[TopicDetailViewController alloc] init];
    topicDetail.status = @"commentBtn";
    topicDetail.loginModel = listLoginModel;
    
    [self pushNewVC:topicDetail animated:YES];
}

-(void)clickViewBgDelegate:(ListLoginModel *)listLoginModel{
    
    TopicDetailViewController * topicDetail = [[TopicDetailViewController alloc] init];
    topicDetail.loginModel = listLoginModel;
    [self pushNewVC:topicDetail animated:YES];
}

/*点击用户头像*/
-(void)clickUserIcon:(ListLoginModel *)listLoginModel{
    
    if(self.userId.length == 0){ //在个人主页页面不能再查看个人中心
        TopicViewController *vc = [[TopicViewController alloc] init];
        vc.topicViewControllerType = TopicViewControllerTypeUserInfo;
        vc.userId = listLoginModel.publishId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ----- 个人主页相关操作-----

- (void)getAppUserInfo{
    
    NetWork_himInfo *info = [[NetWork_himInfo alloc] init];
    info.token = [GlobalData sharedInstance].loginDataModel.token;
    info.userId = self.userId;
    [info startPostWithBlock:^(HimInfoRespone *result, NSString *msg, BOOL finished) {
        if (finished) {
            HimInfoModel *model = (HimInfoModel *)result.data;

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.userInfoHeader setupUI:model ];
            });
        }
    }];
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSNotificationUserLoginSuccess
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSNotificationPublishState
                                                  object:nil];
}

- (UserInfoHeader *)userInfoHeader {
    if (!_userInfoHeader) {
        
        __weak __typeof(self) weakSelf = self;
        _userInfoHeader = [UserInfoHeader shareView];
        _userInfoHeader.frame = CGRectMake(0, KViewStartTopOffset_New, ScreenWidth, 202);
        [_userInfoHeader setFansClickBlock:^{
            if(weakSelf.userId.length > 0){
                MyFansViewController *fansViewController = [[MyFansViewController alloc] init];
                fansViewController.userId = weakSelf.userId;
                [weakSelf pushNewVC:fansViewController animated:YES];
                
            }
        }];
        [_userInfoHeader setFollowListClickBlock:^{
            if(weakSelf.userId.length > 0){
                MyAttentionViewController *myAttentionViewController = [[MyAttentionViewController alloc] init];
                myAttentionViewController.userId = weakSelf.userId;
                [weakSelf pushNewVC:myAttentionViewController animated:YES];
            }
        }];
    }
    return _userInfoHeader;
}
- (TopicHeader *)topicHeader {
    if (!_topicHeader) {
        _topicHeader = [TopicHeader shareView];
        _topicHeader.frame = CGRectMake(0, KViewStartTopOffset_New, ScreenWidth, 130);
    }
    return _topicHeader;
}

@end
