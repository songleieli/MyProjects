//
//  CommentCell.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "CommentCell.h"
#import "UIView+SDAutoLayout.h"

@implementation CommentCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView
//{
//    static NSString *ID = @"CommentCell";
//    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    return cell;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //头像
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.layer.cornerRadius = 16;
    self.iconImageView.top = 21;
    self.iconImageView.left = 21;
    self.iconImageView.width = 32;
    self.iconImageView.height = 32;
    [self.contentView addSubview:self.iconImageView];
    
    //姓名
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.height = ReplyTitleHeight;
    self.nameLabel.top = self.iconImageView.top + (self.iconImageView.height-self.nameLabel.height)/2;//
    self.nameLabel.left = self.iconImageView.right + 16;
    self.nameLabel.width = ScreenWidth - 20;
    self.nameLabel.textColor = RGBFromColor(0x464952);
    [self.contentView addSubview:self.nameLabel];
    
//    //时间
//    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.left = self.nameLabel.left;
//    self.timeLabel.top = self.nameLabel.bottom + 8;
//    self.timeLabel.height = 14;
//    self.timeLabel.width = ScreenWidth - 20;
//    self.timeLabel.font = [UIFont systemFontOfSize:12];
//    self.timeLabel.textColor = RGBFromColor(0xaaaaaa);
//    [self.contentView addSubview:self.timeLabel];
//    //test
//    self.timeLabel.backgroundColor = [UIColor blueColor];
    
    //评论
    self.btnComment = [UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] init];
    self.btnComment.titleLabel.numberOfLines = 0;
    self.btnComment.left = self.nameLabel.left;
    self.btnComment.top = self.nameLabel.bottom + VerticalSpace;
    self.btnComment.titleLabel.font = ReplyContentFont;
    self.btnComment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.btnComment setBackgroundColor:RGBAlphaColor(117, 117, 117, 0.5) forState:UIControlStateHighlighted];
    [self.btnComment setTitleColor:RGBFromColor(0x777777) forState:UIControlStateNormal];
    [self.btnComment addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnComment];
    
    //test
//    self.btnComment.backgroundColor = [UIColor blueColor];
    
    //删除评论
    self.btnCommentDelete = [UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] init];
    self.btnCommentDelete.hidden = YES;
    self.btnCommentDelete.width = 50;
    self.btnCommentDelete.height = 30;
    self.btnCommentDelete.left = ScreenWidth - self.btnCommentDelete.width;
    self.btnCommentDelete.top = self.btnComment.top;
    self.btnCommentDelete.titleLabel.numberOfLines = 0;
    self.btnCommentDelete.titleLabel.font = ReplyContentFont;
    self.btnCommentDelete.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.btnCommentDelete setBackgroundColor:RGBAlphaColor(117, 117, 117, 0.5) forState:UIControlStateHighlighted];
    [self.btnCommentDelete setTitleColor:RGBFromColor(0x777777) forState:UIControlStateNormal];
    [self.btnCommentDelete setTitle:@"删除" forState:UIControlStateNormal];
    [self.btnCommentDelete addTarget:self action:@selector(commentDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnCommentDelete];
    
    //test
//    self.btnCommentDelete.backgroundColor = [UIColor greenColor];
    
    //分割线
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.contentView.height-0.4, ScreenWidth, 0.4)];
    self.lineLabel.backgroundColor = RGBAlphaColor(222, 222, 222, 0.8);
    [self.contentView addSubview:self.lineLabel];
    
    self.viewReplyBg = [[UIView alloc] init];
    self.viewReplyBg.size = [UIView getSize_width:ScreenWidth-self.nameLabel.left height:0];
    self.viewReplyBg.origin = [UIView getPoint_x:self.nameLabel.left y:self.btnComment.bottom];
    [self.contentView addSubview:self.viewReplyBg];
    
    //test
//    self.viewReplyBg.backgroundColor = [UIColor blueColor];

}

- (void)setTopicCommentListModel:(TopicCommentListModel *)topicCommentListModel{
    
    _topicCommentListModel = topicCommentListModel;
    self.lineLabel.top = topicCommentListModel.cellHeight - 1;
    
    if ([topicCommentListModel.userName isEqualToString:@""]) {
        self.nameLabel.text = @"暂无昵称";
    }else{
        self.nameLabel.text = topicCommentListModel.userName;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topicCommentListModel.userIcon] placeholderImage:[UIImage imageNamed:@"access_control"]];
    
    [self.btnComment setTitle:topicCommentListModel.content forState:UIControlStateNormal];
    self.btnComment.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btnComment.size = [UIView getSize_width:CommentCellContentWith height:topicCommentListModel.topicContentHeight];
    self.btnCommentDelete.height = topicCommentListModel.topicContentHeight;
    
    //如果是当前用户发布的回复或者评论，显示删除按钮，暂时先屏蔽
    if([[GlobalData sharedInstance].loginDataModel.userId.trim isEqualToString:topicCommentListModel.userId.trim]){
        self.btnCommentDelete.hidden = NO;
    }
    else{
        self.btnCommentDelete.hidden = YES;
    }
    

    self.viewReplyBg.top = self.btnComment.bottom;
    self.viewReplyBg.height = topicCommentListModel.replyBodyHeight;
    [self.viewReplyBg removeAllSubviews];
    
    if(topicCommentListModel.replies.count>0){//如果有评论加载评论
        //分割线
        UILabel *labelSubLine = [self.viewReplyBg viewWithTag:81];
        if(!labelSubLine){
            CGRect frame = CGRectMake(0,16, ScreenWidth-self.nameLabel.left, 0.4);
            labelSubLine = [[UILabel alloc]initWithFrame:frame];
            labelSubLine.tag = 81;
            labelSubLine.backgroundColor = RGBAlphaColor(222, 222, 222, 0.8);
            [self.viewReplyBg addSubview:labelSubLine];
        }
        
        CGFloat top = labelSubLine.bottom;
        for(int i=0;i<topicCommentListModel.replies.count;i++){
            
            top = top + VerticalSpace;
            TopicReplyModel *replyModel = [topicCommentListModel.replies objectAtIndex:i];
            UILabel *labelReplyTitie = [self.viewReplyBg viewWithTag:90+i]; //90+i labelReplyTitie tag
            
            if(!labelReplyTitie){
                labelReplyTitie = [[UILabel alloc]init];
                labelReplyTitie.font = [UIFont systemFontOfSize:14];
                labelReplyTitie.tag = 90+i;
                labelReplyTitie.textColor = RGBFromColor(0x464952);
                labelReplyTitie.left = 0;
                labelReplyTitie.top = top;
                labelReplyTitie.width = ScreenWidth-self.nameLabel.left-16;
                labelReplyTitie.height = ReplyTitleHeight;
                [self.viewReplyBg addSubview:labelReplyTitie];
            }
            labelReplyTitie.top = top;
            
            //
            NSString *replyFrom = replyModel.replyFrom.trim.length==0?@"暂无昵称":replyModel.replyFrom.trim;
            NSString *replyTo = replyModel.replyTo.trim.length == 0?@"暂无昵称":replyModel.replyTo.trim;
            NSString * text = [NSString stringWithFormat:@"%@回复%@",replyFrom,replyTo];
            
            NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:text];
            NSRange redRange = NSMakeRange(replyFrom.length, 2);
            [noteStr addAttribute:NSForegroundColorAttributeName value:RGBAlphaColor(253, 133, 26, 1) range:redRange];

            if ([labelReplyTitie isKindOfClass:[UILabel class]]) {
                labelReplyTitie.attributedText = noteStr;
            }
            
            top = top + labelReplyTitie.height + VerticalSpace;
            UIButton *labelReplyContent = [self.viewReplyBg viewWithTag:100+i]; //100+i labelReplyContent tag
            if(!labelReplyContent){
                labelReplyContent = [UIButton buttonWithType:UIButtonTypeCustom]; //[[UILabel alloc]init];
                labelReplyContent.tag = 100+i;
                labelReplyContent.titleLabel.numberOfLines = 0;
                labelReplyContent.titleLabel.font = ReplyContentFont;
                [labelReplyContent setTitleColor:RGBFromColor(0x777777) forState:UIControlStateNormal];
                labelReplyContent.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [labelReplyContent setBackgroundColor:RGBAlphaColor(117, 117, 117, 0.5) forState:UIControlStateHighlighted];
                [labelReplyContent addTarget:self action:@selector(replyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                labelReplyContent.left = 0;
                [self.viewReplyBg addSubview:labelReplyContent];
            }
            [labelReplyContent setTitle:replyModel.content forState:UIControlStateNormal];
            labelReplyContent.height = replyModel.replyContentHeight;
            labelReplyContent.width = CommentCellContentWith;
            labelReplyContent.top = top;
            
            UIButton *btnReplyDelete = [UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] init];
            btnReplyDelete.tag = 200+i;
            btnReplyDelete.width = 50;
            btnReplyDelete.height = labelReplyContent.height;
            btnReplyDelete.left = self.viewReplyBg.width - btnReplyDelete.width;
            btnReplyDelete.top = labelReplyContent.top;
            btnReplyDelete.titleLabel.font = ReplyContentFont;
            btnReplyDelete.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [btnReplyDelete setBackgroundColor:RGBAlphaColor(117, 117, 117, 0.5) forState:UIControlStateHighlighted];
            [btnReplyDelete setTitleColor:RGBFromColor(0x777777) forState:UIControlStateNormal];
            [btnReplyDelete setTitle:@"删除" forState:UIControlStateNormal];
            [btnReplyDelete addTarget:self action:@selector(replyDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.viewReplyBg addSubview:btnReplyDelete];
            
            //如果是当前用户发布的回复或者评论，显示删除按钮，暂时先屏蔽
//            if([[GlobalData sharedInstance].loginModel.userId.trim isEqualToString:replyModel.userId.trim]){
//                btnReplyDelete.hidden = NO;
//            }
//            else{
//                btnReplyDelete.hidden = YES;
//            }

            
            //test
//            btnReplyDelete.backgroundColor = [UIColor redColor];
            
            top = top + labelReplyContent.height;
        }
    }
}



#pragma mark --------------点击事件-------------------

/*
 *评论删除
 */
-(void)commentDeleteClick:(UIButton *)button{
    
    NSLog(@"-------------删除评论------------");
    
    if ([self.replyDelegate respondsToSelector:@selector(commentDeleteClick:)]) {
        [self.replyDelegate commentDeleteClick:self.topicCommentListModel];
    } else {
        NSLog(@"代理没响应，快开看看吧");
    }
}

/*
 *回复删除
 */
-(void)replyDeleteClick:(UIButton *)button{
    
    NSLog(@"-------------删除评论------------");
    NSInteger index = button.tag - 200;
    TopicReplyModel *replyModel = [self.topicCommentListModel.replies objectAtIndex:index];
    NSLog(@"----------%@",[replyModel generateJsonStringForProperties]);
    
    if ([self.replyDelegate respondsToSelector:@selector(replyDeleteClick:)]) {
        [self.replyDelegate replyDeleteClick:replyModel];
    } else {
        NSLog(@"代理没响应，快开看看吧");
    }
}

/*
 *评论点击
 */
-(void)commentButtonClick:(UIButton *)button{
    
//    NSLog(@"-------------点击评论------------");
//    NSLog(@"----------%@",[self.topicCommentListModel generateJsonStringForProperties]);
    
    if ([self.replyDelegate respondsToSelector:@selector(replyClick:replyModel:)]) {
        [self.replyDelegate replyClick:self.topicCommentListModel replyModel:nil];
    } else {
        NSLog(@"代理没响应，快开看看吧");
    }
}

-(void)replyButtonClick:(UIButton *)button{
    
//    NSLog(@"-------------点击回复------------");
//    NSLog(@"----评论------%@",[self.topicCommentListModel generateJsonStringForProperties]);
    NSInteger index = button.tag - 100;
    TopicReplyModel *replyModel = [self.topicCommentListModel.replies objectAtIndex:index];
//    NSLog(@"-----回复-----%@",[replyModel generateJsonStringForProperties]);
    
    
    if ([self.replyDelegate respondsToSelector:@selector(replyClick:replyModel:)]) {
        [self.replyDelegate replyClick:self.topicCommentListModel replyModel:replyModel];
    } else {
        NSLog(@"代理没响应，快开看看吧");
    }
}

@end
