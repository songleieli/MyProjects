//
//  TopicDetailViewController.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseTableMJViewController.h"

//#import "NetWork_allTopicList.h"
#import "Network_hotTopicList.h"
#import "NetWork_topicCommentList.h"
#import "Network_topicViewNoLogin.h"
#import "Network_topicViewLogin.h"
#import "NetWork_topicPraise.h"
#import "Network_topicCommentReply.h"

#import "TopicCell.h"
#import "CommentCell.h"


@interface TopicDetailViewController : BaseTableMJViewController<ReplyClickDelegate>


@property (strong,nonatomic) ListLoginModel *loginModel;
@property (copy,nonatomic) NSString *status;
@property (assign,nonatomic) CGFloat tempLocationY;
@property (copy,nonatomic) NSString *direction;
@property (nonatomic,strong) TopicCell * testCell;
@property (nonatomic,strong) NSNumber* commentTotalCount;

//评论和回复相关
@property (nonatomic,assign) BOOL iskeyBordShow;
@property (nonatomic,strong) TopicCommentListModel* commintModel;
@property (nonatomic,strong) TopicReplyModel* replyModel;


@end
