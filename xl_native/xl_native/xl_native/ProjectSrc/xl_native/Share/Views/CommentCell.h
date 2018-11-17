//
//  CommentCell.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "Network_topicViewLogin.h"
#import "Network_topicViewNoLogin.h"
#import "NetWork_topicCommentList.h"
#import "Network_hotTopicList.h"


#define CommentCellContentWith   ScreenWidth - 91-30  //定义cell 内容宽度，评论内容和回复内容宽度一样
#define VerticalSpace        16  //评论之间的垂直间隙
#define ReplyTitleHeight     14  //评论title的高度
#define ReplyContentFont     [UIFont defaultFontWithSize:14.0]  //评论内容的font


@protocol ReplyClickDelegate <NSObject>

-(void)replyClick:(TopicCommentListModel *)commineModel replyModel:(TopicReplyModel*)replyModel;

-(void)commentDeleteClick:(TopicCommentListModel *)commentModel;

-(void)replyDeleteClick:(TopicReplyModel*)replyModel;


@end



@interface CommentCell : BaseTableViewCell

//头像
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UIButton * btnComment;
@property (nonatomic,strong) UILabel * lineLabel;
@property (nonatomic,strong) UIView *viewReplyBg;
@property (nonatomic,strong) UIButton * btnCommentDelete; //删除评论




@property (nonatomic, weak) id<ReplyClickDelegate> replyDelegate;



@property (nonatomic,strong) TopicCommentListModel * topicCommentListModel;

//+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
