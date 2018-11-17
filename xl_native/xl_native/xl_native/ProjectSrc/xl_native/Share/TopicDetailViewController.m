//
//  TopicDetailViewController.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicCell.h"
#import "ClassifyViewController.h"
#import "ZJLoginService.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UITextFeildCustrom.h"
//#import "NetWork_integralAdd.h"//增加积分

//网络请求
#import "NetWork_topicCommentList.h"
#import "NetWork_topicComment.h"
#import "NetWork_deleteReply.h"
#import "NetWork_deleteComment.h"


#import "PublishSuccessView.h"//成功的窗口
#import "UIView+TTFramePopupView.h"//第三方

@interface TopicDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ClickDelegate,UITextViewDelegate>

@property(nonatomic,strong) UITableView * tableViewTopicDetail;
@property(nonatomic,strong) TopicCommentModel * topicCommentData;
@property(nonatomic,strong) UITextView * textFiledComment;
@property(nonatomic,strong) UIView * viewComment;
@property(nonatomic,strong) UIButton * sendBtn;

@property(nonatomic,strong) NSMutableArray *commentDataArray;
@property (nonatomic,assign) NSInteger num;
@property(nonatomic,strong) TopicCell *cell;
@property (nonatomic, strong)PublishSuccessView*  publishSuccessView;
@property(nonatomic,strong) UILabel * placeHoldelLebel;

@property(nonatomic,assign) CGRect keyBoardFrame;

@end

@implementation TopicDetailViewController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    self.sendBtn.enabled = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

-(void)initNavTitle{
    self.title = @"话题详情";
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
    self.keyBoardFrame = CGRectZero; //初始化键盘frame
    
    [self setupUI];
    [self.tableView.mj_header beginRefreshing];
}

-(void)reachabilityChanged:(NSNotification *)note{
    
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        self.tableView.mj_footer.hidden = YES;
    }
    else{
        if (self.totalCount == self.commentDataArray.count) {
            self.tableView.mj_footer.hidden = YES;
        }
        else{
            self.tableView.mj_footer.hidden = NO;
        }
    }
}



- (PublishSuccessView *)publishSuccessView{
    
    if (!_publishSuccessView) {
        _publishSuccessView = [[PublishSuccessView alloc] init];
        _publishSuccessView.layer.cornerRadius = MasScale_1080(10);
    }
    return _publishSuccessView;
}

- (void)publishSuccessViewF{
    
    [_publishSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(MasScale_1080(535));
        make.height.mas_equalTo(MasScale_1080(256));
    }];
    
}


-(void)setupUI{
    
    [self createViewDiscuss];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:@"UITextViewTextDidChangeNotification" object:self.textFiledComment];
    [self layeroutCommentFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tableViewGesture];
    
    [self.view addSubview:self.tableView];
    
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
}
- (void)commentTableViewTouchInSide{
    [self.textFiledComment resignFirstResponder];
}
-(void)setupCommentData{
    
    __weak __typeof (self) weakSelf = self;
    NetWork_topicCommentList * topicComment = [[NetWork_topicCommentList alloc]init];
    topicComment.topicId = self.loginModel.id;
    topicComment.pageSize = @10;
    topicComment.pageNo = [NSNumber numberWithInteger:self.currentPage+1];
    [topicComment startPostWithBlock:^(id result, NSString *msg) {
        /*
         *处理缓存
         */
    } finishBlock:^(id result, NSString *msg, BOOL finished) {
        
        if (finished) {
            [weakSelf loadTopicData:result isCash:NO];
        }else{
            [weakSelf showFaliureHUD:msg];
            self.tableView.mj_footer.hidden = YES;
            sleep(1);
            self.tableView.mj_footer.hidden = NO;
            self.tableView.mj_header.hidden = NO;
            
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


-(void)loadTopicData:(TopicCommentListResponse *)topicCommentListResponse  isCash:(BOOL)isCash{
    
    self.totalCount = [topicCommentListResponse.data.count integerValue];
    if (self.currentPage == 0 ) {
        self.self.commentDataArray = [[NSMutableArray alloc]init];
        if (isCash == NO) {
            self.tableView.mj_footer.hidden = NO;
        }
    }
    else{
        if (isCash == NO) {
            self.tableView.mj_header.hidden = NO;
        }
    }
    
    [self countCellHeight:topicCommentListResponse.data.list];
    [self.commentDataArray addObjectsFromArray:topicCommentListResponse.data.list];
    if (isCash == NO) {
        self.currentPage += 1;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView reloadData];
}

-(void)countCellHeight:(NSArray *)modelList{
    
    for(TopicCommentListModel *model in modelList ){
        
        CGFloat cellSpace = 21 + 16;
        CGFloat cellIconHeight= 60;
        
        CGFloat labelContectW = CommentCellContentWith;
        CGRect contentLabelSize = [model.content boundingRectWithSize:CGSizeMake(labelContectW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont defaultFontWithSize:14],NSFontAttributeName, nil] context:nil];
        
        model.cellHeight = cellSpace + cellIconHeight +contentLabelSize.size.height;
        model.topicContentHeight = contentLabelSize.size.height;
        
        //计算回复的高度，暂时先定60，然后再慢慢细化
        CGFloat replyHeight= 0.0f;
        for(int i=0;i<model.replies.count;i++){
            
            TopicReplyModel *replyModel = [model.replies objectAtIndex:i];
            
            CGRect replyContentLabelSize = [replyModel.content boundingRectWithSize:CGSizeMake(CommentCellContentWith, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:ReplyContentFont,NSFontAttributeName, nil] context:nil];
            
            replyModel.replyBodyHeight = VerticalSpace+ReplyTitleHeight+VerticalSpace+replyContentLabelSize.size.height;
            replyModel.replyContentHeight = replyContentLabelSize.size.height;
            
            replyHeight+=replyModel.replyBodyHeight;
        }
        model.cellHeight += replyHeight;
        model.replyBodyHeight = replyHeight+2*VerticalSpace;
    }
}

#pragma mark - 数据加载代理

-(void)loadNewData{
    self.tableView.mj_footer.hidden = YES;
    
    self.currentPage = 0;
    [self setupCommentData];
    
    
}

-(void)loadMoreData{
    self.tableView.mj_header.hidden = YES;
    
    [self setupCommentData];
    
    if (self.totalCount == self.commentDataArray.count) {
//        [self showFaliureHUD:@"暂无更多数据"];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.tableView.mj_footer.hidden = YES;
    }
}


-(void)createViewDiscuss{
    
    self.viewComment = [[UIView alloc]init];
    self.viewComment.size = [UIView getSize_width:ScreenWidth height:40];
    self.viewComment.origin = [UIView getPoint_x:0 y:ScreenHeight - kNavBarHeight_New - self.viewComment.height];
    self.viewComment.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self.view addSubview:self.viewComment];
    
    
    self.textFiledComment = [[UITextView alloc] initWithFrame:CGRectMake(20, 5, ScreenWidth - 40, 30)];
    self.textFiledComment.returnKeyType = UIReturnKeySend;
    self.textFiledComment.delegate = self;
    self.textFiledComment.font = [UIFont defaultFontWithSize:14];
    [self.textFiledComment.layer setCornerRadius:10];
    self.textFiledComment.showsVerticalScrollIndicator = NO;
    self.textFiledComment.showsHorizontalScrollIndicator = NO;
    self.textFiledComment.scrollEnabled = NO;//禁止滚动
    
    
    [self.viewComment addSubview:self.textFiledComment];
    
    
    UILabel * placeHoldelLebel = [[UILabel alloc]init];
    placeHoldelLebel.tag = 99;
    placeHoldelLebel.frame = [UIView getScaleFrame_x:5 y:0 width:self.textFiledComment.width height:self.textFiledComment.height];
    placeHoldelLebel.top = (self.textFiledComment.height - placeHoldelLebel.height)/2;
    placeHoldelLebel.text = @"写评论...";
    placeHoldelLebel.textColor = RGBFromColor(0xaaaaaa);
    placeHoldelLebel.font = [UIFont defaultFontWithSize:14];
    [self.textFiledComment addSubview:placeHoldelLebel];
    self.placeHoldelLebel = placeHoldelLebel;

    
    
//    //test
//    placeHoldelLebel.backgroundColor = [UIColor blueColor];
//    self.textFiledComment.backgroundColor = [UIColor redColor];
    
    
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 55, 6, 50, 40)];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendBtn setBackgroundColor:RGBAlphaColor(239, 239, 243, 1) forState:UIControlStateHighlighted];
    [self.sendBtn setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.sendBtn.hidden = YES;
    [self.sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.viewComment addSubview:self.sendBtn];
    
    if ([self.status isEqualToString:@"commentBtn"]) {
        [self.textFiledComment becomeFirstResponder];
        [self performSelector:@selector(keyboardDelayMethod) withObject:nil afterDelay:0.5];
        
    }else{
        
        
    }
    

    [self registerForRemoteNotification];
    
}
-(void)registerForRemoteNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeUserState:)
                                                 name:NSNotificationUserLoginSuccess
                                               object:nil];
    
    
    //增加监听，当键盘将要出现出发通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键盘已经出现出发通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    //增加监听，当键将要退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //增加监听，当键已经退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
    
}


-(void)changeUserState:(id)sender{
    
    self.currentPage = 0;
    [self setupCommentData];
    [self.testCell.zanBtn setImage:[UIImage imageNamed:@"neighbour_zan_selected"] forState:UIControlStateNormal];
    
    
    
}
//点击列表页出现键盘
- (void)keyboardDelayMethod{
    
    [self.textFiledComment becomeFirstResponder];
    
    self.sendBtn.hidden = NO;
    self.sendBtn.enabled = YES;
    
//    [UIView animateWithDuration:0.2 animations:^{
//        self.sendBtn.hidden = NO;
//        self.sendBtn.enabled = YES;
//        
//    }];
}


//键盘消失
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.textFiledComment resignFirstResponder];
        [self sendBtnClick];
        return NO;
    }
    return YES;
}


#pragma -mark -------------------keyboard 相关------------

//当键盘将要出现时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    self.keyBoardFrame = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.textFiledComment.width = ScreenWidth - 80;
    self.sendBtn.hidden = NO;
    [self layeroutCommentFrame];
}

//当键盘将要退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    self.keyBoardFrame = CGRectZero;
    
    self.textFiledComment.width = ScreenWidth-40;
    self.sendBtn.hidden = YES;
    [self layeroutCommentFrame];
}


//当键盘已经出现后调用
- (void)keyboardDidShow:(NSNotification *)aNotification{
    self.iskeyBordShow = YES;
}

//当键盘已经退出时调用
- (void)keyboardDidHide:(NSNotification *)aNotification{
    
    self.iskeyBordShow = NO;
    self.commintModel = nil;
    self.replyModel = nil;
    
    self.placeHoldelLebel.text = @"写评论...";

}

- (void)textViewDidChange:(UITextView *)textView{
    
    if(textView.text.length > 0){
        self.placeHoldelLebel.hidden = YES;
    }
    else{
        self.placeHoldelLebel.hidden = NO;
    }
    
    //UITextView 自适应高度
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    
    self.viewComment.height = textView.height + 10;
    [self layeroutCommentFrame];
}



-(void)textViewDidEndEditing:(UITextView *)textView{
    
    [self.view endEditing:YES];
    
    [self.textFiledComment resignFirstResponder];
    if (textView.text.length == 0) {
        self.placeHoldelLebel.hidden = NO;
    }
}
//表情问题
-(void)textViewEditChanged:(NSNotification*)obj{
    UITextView *textView = (UITextView *)obj.object;
    
    NSString *toBeString = textView.text;
    
    BOOL isEmoj = [self stringContainsEmoji:toBeString];
    NSString * _showStr;
    toBeString = [self disable_emoji:toBeString];
    
    
    if (isEmoj) {
        
        [self showFaliureHUD:@"不支持表情符号输入"];
        if ([_showStr length]) {
            
            textView.text = _showStr;
            
        }else{
            textView.text = toBeString;
        }
        
    }
    
}
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}
#pragma Mark   ---  过滤表情

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}



#pragma -mark ---------------------Custom Method---------------

-(void)layeroutCommentFrame{
    
    /*
     *KTabBarHeightOffset_New 适配IPhoneX 将评论框上移 KTabBarHeightOffset_New
     */
    if(self.keyBoardFrame.size.height == 0){//键盘隐藏
        self.viewComment.top = ScreenHeight - self.keyBoardFrame.size.height - self.viewComment.height-KTabBarHeightOffset_New;
    }
    else{//键盘显示
        self.viewComment.top = ScreenHeight - self.keyBoardFrame.size.height - self.viewComment.height;
        
    }
    self.tableView.size = [UIView getSize_width:ScreenWidth height:ScreenHeight - self.viewComment.height - kNavBarHeight_New - self.keyBoardFrame.size.height];
    self.tableView.origin = [UIView getPoint_x:0 y:self.navBackGround.bottom];
}

-(void)sendBtnClick{
    
    
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        [self showFaliureHUD:@"没有网络,请先检查网络设置"];
        return;
    }
    if(self.textFiledComment.text.trim.length == 0){
        [self showFaliureHUD:@"内容不能为空！"];
        return;
    }
    
    if(self.commintModel == nil && self.replyModel == nil){ //评论主题
        NSLog(@"----------------评论主题------------");
        [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
            [self commentBtnRequest];
        } cancelBlock:^{
            
        }showMsgTarget:self isAnimat:YES];
    }
    else{
        [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
            [self replyBtnRequest];
        } cancelBlock:^{
            
        }showMsgTarget:self isAnimat:YES];
    }
}

-(void)commentBtnRequest{
    
    __weak __typeof(self) weakSelf = self;
    NetWork_topicComment * topicComment = [[NetWork_topicComment alloc]init];
    topicComment.token = [GlobalData sharedInstance].loginDataModel.token;
    topicComment.content = _textFiledComment.text;
    topicComment.topicId = self.loginModel.id;
    [topicComment showWaitMsg:@"" handle:self];
    [topicComment startPostWithBlock:^(TopicCommentResponse * result, NSString *msg, BOOL finished) {
        
        if(finished){
            [[AddIntegralTool sharedInstance] addIntegral:self code:@"10011"];

            [_textFiledComment resignFirstResponder];
            self.currentPage = 0;
            [weakSelf setupCommentData];
            self.textFiledComment.text = @"";
            self.loginModel.commentNum = @(self.totalCount + 1);
            
                PublishSuccessViewModel* model =  [[PublishSuccessViewModel alloc] init];
                model.integral = result.data.integralResult.credits;
                model.title = @"评论成功";
                  if ([result.data.integralResult.returnCode isEqualToString:@"0"]) {
                     model.publishSuccessType = PublishSuccessHasintegral;
                  }else{
                        model.publishSuccessType = PublishSuccessNointegral;
                  }
                
                [self.publishSuccessView dataBind:model];
                
                [self.view ttPresentFramePopupView:self.publishSuccessView animationType:TTFramePopupViewAnimationFade dismissed:^{
                    NSLog(@"我要消失了");
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
                
                
                [self publishSuccessViewF];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.view ttDismissPopupViewControllerWithanimationType:TTFramePopupViewAnimationFade];
                    
                });
                
            }
      
        else{
            [self showFaliureHUD:msg];
        }
    }];
}

-(void)replyBtnRequest{
    

    if(self.commintModel == nil){
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    Network_topicCommentReply *request = [[Network_topicCommentReply alloc]init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.content = _textFiledComment.text;
    
    if(self.replyModel == nil){ //回复评论
        NSLog(@"----------------回复评论------------");
        request.replyId = self.commintModel.id;
        request.commentId = self.commintModel.id;
    }
    
    if(self.replyModel != nil){ //回复回复
        NSLog(@"----------------回复回复------------");
        request.replyId = self.replyModel.id; //回复回复时使用id
        request.commentId = self.commintModel.id;
    }
    [request showWaitMsg:@"" handle:self];
    [request startPostWithBlock:^(TopicCommentResponse * result, NSString *msg, BOOL finished) {
        
        if(finished){
            [[AddIntegralTool sharedInstance] addIntegral:self code:@"10011"];

            weakSelf.currentPage = 0;
            
            //viewComment 发送完成评论View的frame 设定
            [_textFiledComment resignFirstResponder];
            weakSelf.textFiledComment.text = @"";
            weakSelf.textFiledComment.height = 30;
            weakSelf.viewComment.height = 40;
            [weakSelf layeroutCommentFrame];
            
            weakSelf.loginModel.commentNum = @(self.totalCount + 1);

            [weakSelf setupCommentData]; //刷新数据
        }
        
        else{
            [weakSelf showFaliureHUD:msg];
        }
    }];
}





/* 积分暂时屏蔽
//增加积分
- (void)addintegral{
    
    
    
    NetWork_integralAdd* request = [[NetWork_integralAdd alloc] init];
    
    request.token = [GlobalData sharedInstance].loginModel.token;
    
    
    request.type = @"A0008";
    
    
    
    
    
    [request startPostWithBlock:^(NetWork_integralAddResponse* result, NSString *msg, BOOL finished) {
        
        //        if (finished) {
        //
        //
        //        }else{
        //
        //
        //            [self showFaliureHUD:msg];
        //
        //        }
        //        //
        
        
    }];
    
    
    
}
*/





#pragma -mark ----------------------UITableView 相关----------------------

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
        
    }else{
        return self.commentDataArray.count;
        
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSString *activiteyIdentifier = @"TopicTopCell";
        _cell = (TopicCell *)[tableView dequeueReusableCellWithIdentifier:activiteyIdentifier];
        if(_cell == nil){
            _cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activiteyIdentifier];
            [_cell.viewBg setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        _cell.listLoginModel =  self.loginModel;//主题内容
        _cell.delegate = self;
        
        return _cell;
    }else{
        
        NSString *activiteyIdentifier = @"TopicBottomCell";
        CommentCell *commentCell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:activiteyIdentifier];
        if(commentCell == nil){
            commentCell  = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activiteyIdentifier];
            commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            commentCell.replyDelegate = self;
        }
        commentCell.topicCommentListModel = [self.commentDataArray objectAtIndex:indexPath.row];
        commentCell.viewBottomLine.hidden = YES;
        return commentCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }else{
        return 0.01;
    }
}
//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return self.loginModel.heightCell - 12;
    }
    else{
        TopicCommentListModel * topicCommentListModel = [self.commentDataArray objectAtIndex:indexPath.row];
        
        return topicCommentListModel.cellHeight;
    }
}

-(void)clickPraiseDelegate:(NSString *)topicId andCell:(UITableViewCell *)cell{
//    [GlobalFunc event:@"event_click_like_from_market_detail"];
    self.testCell = (TopicCell *)cell;
    if(![[Reachability reachabilityForInternetConnection] isReachable])
    {
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
            }
            
            if (finished) {
                
                if (finished) {
                    NSInteger zanCount = [_cell.listLoginModel.praiseNum integerValue];
                    zanCount += 1;
                    _cell.listLoginModel.praiseNum = [NSNumber numberWithInteger:zanCount];
                    _cell.listLoginModel.praiseFlag = YES;
                    _cell.listLoginModel = _cell.listLoginModel;
                }
                
                //test
                [[NSNotificationCenter defaultCenter]postNotificationName:@"zan" object:nil userInfo:nil];
                //======================
                
                NSLog(@"%@",result);
                
            }
            
        }];
        
    } cancelBlock:^{
    }showMsgTarget:self isAnimat:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"评论";
    }else{
        return @"";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

#pragma -mark UIscrollView 相关


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    if([self.direction isEqualToString:@"down"]){
        
        if (scrollView.contentOffset.y > scrollView.contentSize.height-scrollView.height + 50 ) {
            [self.textFiledComment becomeFirstResponder];
        }
    }
    else{
        [self.textFiledComment resignFirstResponder];
    }
    
}
//滑动到最底部
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    [super scrollViewDidScroll:scrollView];
    
    if(self.tempLocationY == 0){
        self.tempLocationY = scrollView.contentOffset.y;
        return;
    }
    if(scrollView.contentOffset.y - self.tempLocationY > 0){
        self.direction = @"down";
        
    }
    else if(scrollView.contentOffset.y - self.tempLocationY < 0){
        
        self.direction = @"up";
    }
    self.tempLocationY = scrollView.contentOffset.y;
    
}

#pragma -mark ReplyClickDelegate 回复Delegate

//回复评论
-(void)replyClick:(TopicCommentListModel *)commintModel replyModel:(TopicReplyModel*)replyModel{
    if(!self.iskeyBordShow){
        [self.textFiledComment becomeFirstResponder];
        self.commintModel = commintModel;
        self.replyModel = replyModel;
        
        NSString *placeStr = @"";
        if(replyModel == nil){//回复评论
            placeStr = commintModel.userName.trim.length == 0?@"暂无昵称":commintModel.userName;
        }
        else{//回复回复
            placeStr = replyModel.replyFrom.trim.length == 0?@"暂无昵称":replyModel.replyFrom;
        }
        
        self.placeHoldelLebel.text = [NSString stringWithFormat:@"回复%@",placeStr];
    }
}


//删除评论
-(void)commentDeleteClick:(TopicCommentListModel *)commentModel{
    
    __weak __typeof(self) weakSelf = self;
    NetWork_deleteComment *request = [[NetWork_deleteComment alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.id = commentModel.id;
    [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
        if(finished){
            weakSelf.currentPage = 0;
            [weakSelf setupCommentData];
        }
        else{
            [weakSelf showFaliureHUD:msg];
        }
    }];
}

//删除评论
-(void)replyDeleteClick:(TopicReplyModel*)replyModel{
    
    __weak __typeof(self) weakSelf = self;
    NetWork_deleteReply *request = [[NetWork_deleteReply alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.id = replyModel.id;
    [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
        if(finished){
            weakSelf.currentPage = 0;
            [weakSelf setupCommentData];
        }
        else{
            [weakSelf showFaliureHUD:msg];
        }
    }];

    
}

@end


