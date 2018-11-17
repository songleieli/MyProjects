//
//  XLCommentListView.m
//  xl_native
//
//  Created by MAC on 2018/10/8.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLCommentListView.h"
#import "NetWork_topicCommentList.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "NetWork_deleteComment.h"
#import "NetWork_deleteReply.h"

@implementation XLCommentListView

+ (instancetype)shareView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"XLCommentListView" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = YES;

    self.currentPage = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
}
- (void)headerRereshing
{
    self.currentPage = 0;
    [self.dataArr removeAllObjects];
    self.isLoadMoreData = NO;
    [self setupCommentData:self.commentId];
}
- (void)footerRereshing
{
    self.currentPage ++;
    self.isLoadMoreData = YES;
    [self setupCommentData:self.commentId];
}
-(void)setupCommentData:(NSString *)commentId {
    
    NetWork_topicCommentList * topicComment = [[NetWork_topicCommentList alloc]init];
    topicComment.topicId = commentId;
    topicComment.pageSize = @20;
    topicComment.pageNo = [NSNumber numberWithInteger:self.currentPage+1];
    [topicComment startPostWithBlock:^(id result, NSString *msg) {
        /*
         *处理缓存
         */
    } finishBlock:^(TopicCommentListResponse *result, NSString *msg, BOOL finished) {
        if (finished) {
            [self countCellHeight:result.data.list];
            [self.dataArr addObjectsFromArray:result.data.list];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *activiteyIdentifier = @"TopicBottomCell";
    CommentCell *commentCell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:activiteyIdentifier];
    if(commentCell == nil){
        commentCell  = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activiteyIdentifier];
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        commentCell.replyDelegate = self;
    }
    commentCell.topicCommentListModel = [self.dataArr objectAtIndex:indexPath.row];
    commentCell.viewBottomLine.hidden = YES;
    return commentCell;
}
//设置每一组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCommentListModel * topicCommentListModel = [self.dataArr objectAtIndex:indexPath.row];
    
    return topicCommentListModel.cellHeight;
}

#pragma -mark ReplyClickDelegate 回复Delegate

//回复评论
-(void)replyClick:(TopicCommentListModel *)commintModel replyModel:(TopicReplyModel*)replyModel {
    if(!self.iskeyBordShow){

        self.commintModel = commintModel;
        self.replyModel = replyModel;
        
        NSString *placeStr = @"";
        if(replyModel == nil){//回复评论
            placeStr = commintModel.userName.trim.length == 0?@"暂无昵称":commintModel.userName;
        }
        else{//回复回复
            placeStr = replyModel.replyFrom.trim.length == 0?@"暂无昵称":replyModel.replyFrom;
        }
        if (self.replyClickBlock) {
            self.replyClickBlock([NSString stringWithFormat:@"回复%@",placeStr], YES);
        }
    }
}


//删除评论
-(void)commentDeleteClick:(TopicCommentListModel *)commentModel {
    
    __weak __typeof(self) weakSelf = self;
    NetWork_deleteComment *request = [[NetWork_deleteComment alloc] init];
    request.token = [GlobalData sharedInstance].loginDataModel.token;
    request.id = commentModel.id;
    [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
        if(finished){
            weakSelf.currentPage = 0;
            [weakSelf setupCommentData:self.commentId];
        }
        else{
            [SVProgressHUD showErrorWithStatus:msg];
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
            [weakSelf setupCommentData:self.commentId];
        }
        else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.replyClickBlock) {
        self.replyClickBlock(@"", NO);
    }
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
