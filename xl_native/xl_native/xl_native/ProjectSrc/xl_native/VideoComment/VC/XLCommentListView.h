//
//  XLCommentListView.h
//  xl_native
//
//  Created by MAC on 2018/10/8.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLCommentListView : UIView <UITableViewDelegate,UITableViewDataSource,ReplyClickDelegate>

+ (instancetype)shareView ;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (nonatomic,assign) BOOL iskeyBordShow;

@property (strong, nonatomic) TopicCommentListModel *commintModel;
@property (strong, nonatomic) TopicReplyModel *replyModel;

@property (assign, nonatomic) BOOL isLoadMoreData;

@property (copy, nonatomic) NSString *commentId; 

-(void)setupCommentData:(NSString *)commentId ;

@property (copy, nonatomic) void (^replyClickBlock)(NSString *placeStr, BOOL isShowKeyboard); 

@end

NS_ASSUME_NONNULL_END
