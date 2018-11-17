//
//  MBPlaySmartVideoViewController.m
//  SmartVideo
//
//  Created by songleilei on 17/1/5.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import "SwitchPlayerViewController.h"
#import "XLUserInfoVC.h"
#import "TopicViewController.h"
#import "XLCommentListView.h"


#import "NetWork_topicComment.h"
#import "Network_topicCommentReply.h"

//tag 标签
#import "NetWork_findhomepageTagList.h" //获取首页标签
#import "NetWork_findHotTagList.h" //获取热门标签
#import "NetWork_findFollowTagList.h" //获取关注标签

//视频列表
#import "NetWork_classifyVideo_list.h"  //首页视频列表
#import "NetWork_followVideo_list.h"    //关注视频列表
#import "NetWork_video_list.h"    //热门视频列表

#import "NetWork_mt_home_list.h" //面条视频列表

@interface SwitchPlayerViewController ()

@property (strong, nonatomic) XLCommentView *commentView;
@property (assign, nonatomic) CGFloat kbH;
@property (strong, nonatomic) XLCommentListView *commentListView;
@property (strong, nonatomic)  HomeListModel *loginModel;

//选择标签
@property (nonatomic, strong)UIButton* titleBtn;
@property (nonatomic,strong)UILabel* titleLable;
@property (nonatomic,strong)UIImageView* titleImg;
@property (nonatomic, assign)BOOL isShowTagView;


@end

@implementation SwitchPlayerViewController


- (UILabel *)titleLable{
    
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont defaultBoldFontWithSize:17];
        _titleLable.textColor = [UIColor whiteColor];
    }
    return _titleLable;
}

- (UIImageView *)titleImg{
    
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithImage:[BundleUtil getCurrentBundleImageByName:@"title_arrow"]];
    }
    return _titleImg;
}

- (UIButton *)titleBtn{

    if (!_titleBtn) {
        
        CGFloat btnHeight = 35.0f;
        
        self.titleLable.text = self.currTagModel.tagName;//@"选择标签";
        [self.titleLable sizeToFit];
        self.titleLable.top = (btnHeight - self.titleLable.height)/2;
        
        self.titleImg.size = [UIView getSize_width:12 height:8];
        self.titleImg.top = (btnHeight - self.titleImg.height)/2;
        
         CGFloat btnWidth = self.titleLable.width + self.titleImg.width +20;
        self.titleLable.left = (btnWidth-self.titleLable.width)/2 - self.titleImg.width/2;
        self.titleImg.left = self.titleLable.right+2;
        
        _titleBtn = [[UIButton alloc] init];
        _titleBtn.size = [UIView getSize_width:btnWidth height:btnHeight];
        _titleBtn.origin = [UIView getPoint_x:(ScreenWidth-_titleBtn.width)/2 y:36];
        [_titleBtn addTarget:self action:@selector(btnSelectTagClick:) forControlEvents:UIControlEventTouchUpInside];
        _titleBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        _titleBtn.layer.shadowOpacity = 0.8;
        _titleBtn.layer.shadowColor =  [UIColor blackColor].CGColor;

        [_titleBtn addSubview:self.titleLable];
        [_titleBtn addSubview:self.titleImg];
    }
    return _titleBtn;
}

- (SwitchPlayerScrollView *)playerScrollView{
    if (!_playerScrollView) {
        _playerScrollView = [[SwitchPlayerScrollView alloc] initWithFrame:self.view.bounds];
        _playerScrollView.playerDelegate = self;
        _playerScrollView.index = self.index;
    }
    return _playerScrollView;
}

- (SwitchPlayerSelectTagView *)selectTagView{
    if (!_selectTagView) {
        
        __weak __typeof(self) weakSelf = self;
        CGRect frame = CGRectMake(0,0, ScreenWidth, ScreenHeight);
        _selectTagView = [[SwitchPlayerSelectTagView alloc]initWithFrame:frame];
        _selectTagView.hidden = !self.isShowTagView;
        [_selectTagView setSelectBlockClcik:^(FindAllTagDataModel *item) {
            
            weakSelf.currTagModel = item;
            weakSelf.titleLable.text = weakSelf.currTagModel.tagName;
            weakSelf.isShowTagView = NO;
            weakSelf.selectTagView.hidden = !weakSelf.isShowTagView;
            [weakSelf.dataList removeAllObjects];
            [weakSelf reloadVideo];

            //调整箭头和文字的位置
            [weakSelf.titleLable sizeToFit];
            CGFloat btnWidth = weakSelf.titleLable.width + weakSelf.titleImg.width +20;
            weakSelf.titleBtn.width = btnWidth;
            weakSelf.titleLable.left = (btnWidth-weakSelf.titleLable.width)/2 - weakSelf.titleImg.width/2;
            weakSelf.titleImg.left = weakSelf.titleLable.right+2;

            //旋转右侧箭头
            [UIView animateWithDuration:0.4 animations:^{
                if (weakSelf.isShowTagView) {
                    weakSelf.titleImg.transform = CGAffineTransformMakeRotation(M_PI);
                } else {
                    weakSelf.titleImg.transform  = CGAffineTransformIdentity;
                }
            }];
            
        }];
    }
    return _selectTagView;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = YES; //隐藏一呼即有按钮
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = NO;//显示一呼即有按钮

}

#pragma mark -
- (void)dealloc {
    [_playerView destroyPlayer];
    [[NSNotificationCenter defaultCenter ] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [self.view addSubview:self.selectTagView];
    [self.view addSubview:self.titleBtn];
//
    [self loadTagData]; //加载标签数据
    [self reloadVideo]; //加载当前选择标签数据，如果是点击进来的话，加载的是点击视频所属标签。
}

-(void)loadTagData{
    
    if(self.videoType == VideoTypeHome){ //请求首页标签数据
        
        NetWork_findhomepageTagList *requestHomeTag = [[NetWork_findhomepageTagList alloc] init];
        requestHomeTag.token = [GlobalData sharedInstance].loginDataModel.token;
        [requestHomeTag startPostWithBlock:^(FindAllTagListResponse *result, NSString *msg) {
            //暂时先不考虑缓存
        } finishBlock:^(FindHomepageTagListResponse * result, NSString *msg, BOOL finished) {
            
            if(finished){
                NSMutableArray *arrayTags = [[NSMutableArray alloc]initWithArray:result.data];
                [self.selectTagView reloadWithSource:arrayTags selectModel:self.currTagModel];
            }
            else{
                //[self showFaliureHUD:msg];
            }
        }];
    }
    else if(self.videoType == VideoTypeHot){ //热门标签数据
        
        NetWork_findHotTagList *request = [[NetWork_findHotTagList alloc] init];
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        [request     startPostWithBlock:^(FindAllTagListResponse *result, NSString *msg) {
            //暂时先不考虑缓存
        } finishBlock:^(FindHomepageTagListResponse * result, NSString *msg, BOOL finished) {
            
            if(finished){
                NSMutableArray *arrayTags = [[NSMutableArray alloc]initWithArray:result.data];
                [self.selectTagView reloadWithSource:arrayTags selectModel:self.currTagModel];
            }
            else{
                //[self showFaliureHUD:msg];
            }
        }];
        
    }
    else if(self.videoType == VideoTypeFollow){ //关注标签数据
        NetWork_findFollowTagList *request = [[NetWork_findFollowTagList alloc] init];
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        [request startPostWithBlock:^(FindAllTagListResponse *result, NSString *msg) {
            //暂时先不考虑缓存
        } finishBlock:^(FindHomepageTagListResponse * result, NSString *msg, BOOL finished) {
            
            if(finished){
                NSMutableArray *arrayTags = [[NSMutableArray alloc]initWithArray:result.data];
                [self.selectTagView reloadWithSource:arrayTags selectModel:self.currTagModel];
            }
            else{
                //[self showFaliureHUD:msg];
            }
        }];
    }
    
}

-(void)reloadVideo{
    
    if(self.playerView){
        [self.playerView destroyPlayer];
        [self.playerView removeAllSubviews];
        [self.playerView removeFromSuperview];
        self.playerView = nil;
    }
    
    if(self.playerScrollView){
        [self.playerScrollView removeAllSubviews];
        [self.playerScrollView removeFromSuperview];
        self.playerScrollView = nil;
    }
    
    [self.view addSubview:self.playerScrollView];
    [self loadVideoData];
    [self.view bringSubviewToFront:self.selectTagView];
    [self.view bringSubviewToFront:self.titleBtn];
}

-(void)loadVideoData{
    
    if(self.videoType == VideoTypeHome){ //首页视频列表 和 热门视频列表
        
        
            NetWork_mt_home_list *request = [[NetWork_mt_home_list alloc] init];
            request.pageNo = @"1";
            request.pageSize = @"10";
            [request startGetWithBlock:^(HomeListResponse *result, NSString *msg) {
                /*
                 缓存暂时先不用考虑
                 */
            } finishBlock:^(HomeListResponse *result, NSString *msg, BOOL finished) {
                NSLog(@"----");
                
                [self.dataList addObjectsFromArray:result.obj];
                [self.playerScrollView updateForLives:self.dataList withCurrentIndex:self.index];
                [self addPlayToScrollAndPlay];
            }];
        
        
//        NetWork_classifyVideo_list *request = [[NetWork_classifyVideo_list alloc] init];
//        request.pageNo = [NSNumber numberWithInteger:1];
//        request.pageSize = @(20);
//        request.token = [GlobalData sharedInstance].loginDataModel.token;
//        request.typeId = self.currTagModel.id;
//        [request startPostWithBlock:^(id result, NSString *msg) {
//            //先不考虑缓存
//        } finishBlock:^(ClassifyVideoRespone *result, NSString *msg, BOOL finished) {
//            if(finished && result.data.list){
//
//                [self.dataList addObjectsFromArray:result.data.list];
//
//                //for(ImagesLoginModel *imageModel in self.dataList){
//                for(int i=0;i<self.dataList.count;i++){
//                    ListLoginModel *listLoginModel = [self.dataList objectAtIndex:i];
//                    if([self.clickItem.id.trim isEqualToString:listLoginModel.id.trim]){ //放到第一个播放，点击的那个视频
//                        [self.dataList exchangeObjectAtIndex:i withObjectAtIndex:0];
//                        break;
//                    }
//                }
//                [self.playerScrollView updateForLives:self.dataList withCurrentIndex:self.index];
//                [self addPlayToScrollAndPlay];
//            }
//            else{
//
//            }
//        }];
        
    }
    else if(self.videoType == VideoTypeHot){ //热门视频列表
        
        NetWork_video_list *request = [[NetWork_video_list alloc] init];
        request.pageNo = [NSNumber numberWithInteger:1];
        request.pageSize = @(20);
        request.typeIds = self.currTagModel.id;
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        [request startPostWithBlock:^(id result, NSString *msg) {
            //先不考虑缓存
        } finishBlock:^(ClassifyVideoRespone *result, NSString *msg, BOOL finished) {
            if(finished && result.data.list){
                
                [self.dataList addObjectsFromArray:result.data.list];
                
                for(int i=0;i<self.dataList.count;i++){
                    ListLoginModel *listLoginModel = [self.dataList objectAtIndex:i];
//                    if([self.clickItem.id.trim isEqualToString:listLoginModel.id.trim]){ //放到第一个播放，点击的那个视频
//                        [self.dataList exchangeObjectAtIndex:i withObjectAtIndex:0];
//                        break;
//                    }
                }
                [self.playerScrollView updateForLives:self.dataList withCurrentIndex:self.index];
                [self addPlayToScrollAndPlay];
            }
            else{
                
            }
        }];
    }
    else if(self.videoType == VideoTypeFollow){ //关注视频列表
        
        NetWork_followVideo_list *request = [[NetWork_followVideo_list alloc] init];
        request.pageNo = [NSNumber numberWithInteger:1];
        request.pageSize = @(20);
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        request.typeId = self.currTagModel.id;
        [request startPostWithBlock:^(id result, NSString *msg) {
            //先不考虑缓存
        } finishBlock:^(ClassifyVideoRespone *result, NSString *msg, BOOL finished) {
            if(finished && result.data.list){
                
                [self.dataList addObjectsFromArray:result.data.list];
                
                //for(ImagesLoginModel *imageModel in self.dataList){
                for(int i=0;i<self.dataList.count;i++){
//                    ListLoginModel *listLoginModel = [self.dataList objectAtIndex:i];
//                    if([self.clickItem.id.trim isEqualToString:listLoginModel.id.trim]){ //放到第一个播放，点击的那个视频
//                        [self.dataList exchangeObjectAtIndex:i withObjectAtIndex:0];
//                        break;
//                    }
                }
                [self.playerScrollView updateForLives:self.dataList withCurrentIndex:self.index];
                [self addPlayToScrollAndPlay];
            }
            else{
                
            }
        }];
        
    }
    
}

-(void)addPlayToScrollAndPlay{
    
    if(self.dataList.count>0){
        
        HomeListModel *listModel = [self.dataList objectAtIndex:0];
        listModel.videoUrl = @"http://192.168.180.130/miantiao/video/20181115/987654321087654326.mp4";
//        ImagesLoginModel *imageModel = [listLoginModel.medias objectAtIndex:0];
        
        CGRect frame = CGRectMake(0, ScreenHeight, self.view.width, self.view.height);
        self.playerView = [[SwitchPlayerView alloc] initWithFrame:frame listLoginModel:listModel];
        _playerView.url = [NSURL URLWithString:listModel.videoUrl];//视频地址
        [_playerView playVideo];//播放
        
        
        __weak __typeof(self) weakSelf = self;
        [self.playerView setBackBlock:^{
            [weakSelf back];
        }];
        _playerView.pushUserInfo = ^{
            
//            TopicViewController *vc = [[TopicViewController alloc] init];
//            vc.topicViewControllerType = TopicViewControllerTypeUserInfo;
//            vc.userId = listLoginModel.publishId;
//            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _playerView.commentClick = ^{
            [weakSelf.view addSubview:weakSelf.commentListView];
            [weakSelf.view addSubview:weakSelf.commentView];
        };
        _playerView.hideCommentClick = ^{
            [weakSelf.commentView removeFromSuperview];
            weakSelf.commentView = nil;
            [weakSelf.commentListView removeFromSuperview];
            weakSelf.commentListView = nil;
        };
        [self.playerScrollView addSubview:self.playerView];
    }

}

#pragma mark --------- PlayerScrollViewDelegate ----------

- (void)playerScrollView:(SwitchPlayerScrollView *)playerScrollView currentPlayerIndex:(NSInteger)index{
    
    NSLog(@"current index from delegate:%ld  %s",(long)index,__FUNCTION__);
    if (self.index == index) {
        return;
    } else {
        [self reloadPlayerWithLive:self.dataList[index]];
        self.index = index;
    }
    
    [self.commentView removeFromSuperview];
    self.commentView = nil;
    [self.commentListView removeFromSuperview];
    self.commentListView = nil;
}

- (void)reloadPlayerWithLive:(HomeListModel *)listLoginModel{

    [self.playerView pausePlay]; //暂停视频
    [self.playerView removeFromSuperview];
    
    
     CGRect frame = CGRectMake(0, ScreenHeight, self.view.width, self.view.height);
    listLoginModel.videoUrl = @"http://192.168.180.130/miantiao/video/20181115/987654321087654326.mp4";

    
    self.playerView = [[SwitchPlayerView alloc] initWithFrame:frame listLoginModel:listLoginModel];
    NSString *userId = @"";
    if(listLoginModel.videoUrl.length > 0){
//        ImagesLoginModel *imageModel = [listLoginModel.medias objectAtIndex:0];
//        userId = imageModel.id;
        //视频地址
        _playerView.url = [NSURL URLWithString:listLoginModel.videoUrl];
        //播放
        [_playerView playVideo];
    }
    __weak __typeof(self) weakSelf = self;
    [self.playerView setBackBlock:^{
        [weakSelf back];
    }];
    
    _playerView.pushUserInfo = ^{
        
        TopicViewController *vc = [[TopicViewController alloc] init];
        vc.topicViewControllerType = TopicViewControllerTypeUserInfo;
//        vc.userId = listLoginModel.publishId;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    _playerView.commentClick = ^{
        [weakSelf.view addSubview:weakSelf.commentListView];
        [weakSelf.view addSubview:weakSelf.commentView];
    };
    _playerView.hideCommentClick = ^{
        [weakSelf.commentView removeFromSuperview];
        weakSelf.commentView = nil;
        [weakSelf.commentListView removeFromSuperview];
        weakSelf.commentListView = nil;
    };
    [self.playerScrollView addSubview:self.playerView];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (XLCommentView *)commentView {
    __weak typeof(self) weakSelf = self;
    
    if (!_commentView) {
        _commentView = [XLCommentView shareView];
        _commentView.frame = CGRectMake(0, ScreenHeight - 40 - KTabBarHeightOffset_New, ScreenWidth, 40);
        _commentView.viewHeight = ^(CGFloat viewH) {
            [weakSelf commentViewH:viewH];
        };
        _commentView.sendBtnClickBlock = ^{
            [weakSelf sendBtnClick];
        };
    }
    return _commentView;
}
- (XLCommentListView *)commentListView {
    __weak typeof(self) weakSelf = self;

    if (!_commentListView) {
        _commentListView = [XLCommentListView shareView];
        _commentListView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight - 40 - KTabBarHeightOffset_New - 150);
        
        HomeListModel *model = self.dataList[self.index];
//        _commentListView.commentId = model.id;
//        [_commentListView setupCommentData:model.id];
        self.loginModel = model;
        
        _commentListView.replyClickBlock = ^(NSString * _Nonnull placeStr, BOOL isShowKeyboard) {
            if (isShowKeyboard) {
                [weakSelf.commentView.text becomeFirstResponder];
                weakSelf.commentView.paceText.text = placeStr;

            } else {
                [weakSelf.commentView.text resignFirstResponder];
            }
        };
        
        [UIView animateWithDuration:0.25 animations:^{
            _commentListView.y = 150;
        }];
    }
    return _commentListView;
}
#pragma mark - 评论
-(void)btnSelectTagClick:(UIButton*)btn{
    self.isShowTagView = !self.isShowTagView;
    
    //旋转右侧箭头
    [UIView animateWithDuration:0.4 animations:^{
        if (self.isShowTagView) {
            self.titleImg.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.titleImg.transform  = CGAffineTransformIdentity;
        }
    }];
    
    self.selectTagView.hidden = !self.isShowTagView;
}

- (void)sendBtnClick
{
    if(self.commentView.text.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"内容不能为空！"];
        return;
    }
    
    if(self.commentListView.commintModel == nil && self.commentListView.replyModel == nil){ //评论主题
        [self commentBtnRequest];
    }
    else{
        [self replyBtnRequest];
    }
}
-(void)commentBtnRequest {
    
//    __weak __typeof(self) weakSelf = self;
//    NetWork_topicComment * topicComment = [[NetWork_topicComment alloc]init];
//    topicComment.token = [GlobalData sharedInstance].loginDataModel.token;
//    topicComment.content = self.commentView.text.text;
//    topicComment.topicId = self.loginModel.id;
//    [topicComment showWaitMsg:@"" handle:self];
//    [topicComment startPostWithBlock:^(TopicCommentResponse * result, NSString *msg, BOOL finished) {
//
//        if(finished){
//            [[AddIntegralTool sharedInstance] addIntegral:nil code:@"10011"];
//
//            [self.commentView.text resignFirstResponder];
//            self.commentListView.currentPage = 0;
//            [weakSelf.commentListView setupCommentData:self.loginModel.id];
//            self.commentView.text.text = @"";
//            weakSelf.commentView.paceText.text = @"写评论...";
//            _commentView.height = 40;
//            _commentView.text.height = 30;
//            _commentView.y = ScreenHeight - _commentView.height - KTabBarHeightOffset_New;
//        }
//
//        else{
//            [SVProgressHUD showErrorWithStatus:msg];
//        }
//    }];
}

-(void)replyBtnRequest
{
    if(self.commentListView.commintModel == nil){
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    Network_topicCommentReply *request = [[Network_topicCommentReply alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.content = self.commentView.text.text;
    
    if(self.commentListView.replyModel == nil){ //回复评论
        request.replyId = self.commentListView.commintModel.id;
        request.commentId = self.commentListView.commintModel.id;
    }
    
    if(self.commentListView.replyModel != nil){ //回复回复
        request.replyId = self.commentListView.replyModel.id; //回复回复时使用id
        request.commentId = self.commentListView.commintModel.id;
    }
    [request showWaitMsg:@"" handle:self];
    [request startPostWithBlock:^(TopicCommentResponse * result, NSString *msg, BOOL finished) {
        
        if(finished){
            [[AddIntegralTool sharedInstance] addIntegral:nil code:@"10011"];
            
            weakSelf.commentListView.currentPage = 0;
            
            [weakSelf.commentView.text resignFirstResponder];
            weakSelf.commentView.text.text = @"";
            weakSelf.commentView.paceText.text = @"写评论...";
            _commentView.height = 40;
            _commentView.text.height = 30;
            _commentView.y = ScreenHeight - _commentView.height - KTabBarHeightOffset_New;

//            [weakSelf.commentListView setupCommentData:self.loginModel.id];
        }
        
        else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
}


- (void)commentViewH:(CGFloat)viewH
{
    _commentView.height = viewH + 10;
    _commentView.y = ScreenHeight - self.kbH - viewH - 10;
}
#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)noti
{
    CGFloat kbH = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.kbH = kbH;
    
    double duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        _commentView.y = ScreenHeight - kbH - _commentView.height;
    }];
    self.commentListView.iskeyBordShow = YES;
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    double duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        _commentView.y = ScreenHeight - _commentView.height - KTabBarHeightOffset_New;
    }];
    self.commentListView.iskeyBordShow = NO;

}


@end
