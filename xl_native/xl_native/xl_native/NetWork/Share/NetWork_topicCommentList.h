//
//  NetWork_topicCommentList.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

@interface TopicReplyModel : IObjcJsonBase

/*
 "objectVersionNumber":"",
 "creationDate":1512921600000,
 "token":"",
 "readonly":false,
 "fastdfsImageServer":"http://10.17.200.7/",
 "id":"665eaeea58854f8085f42133f439f3d5",
 "replyId":"b0233ea2837e4b14a4114f823d40e50a",
 "userId":"ef582512e06d4bd18aab6e5657f2000c",
 "content":"你好",
 "commentId":"b0233ea2837e4b14a4114f823d40e50a",
 "replyFrom":"Evan",
 "replyFromIcon":"G01/M00/00/84/ChHIB1lR-0eAYNjJABHf9ak1_xE728.png",
 "replyTo":"张涛",
 "replyToIcon":"G01/M00/00/12/ChHIB1j--9GAeh2XAABmAWBdNl0518.png"
 */



@property(nonatomic,copy) NSString * objectVersionNumber;
@property(nonatomic,copy) NSString * creationDate;
@property(nonatomic,copy) NSString * token;
@property(nonatomic,copy) NSString * readonly;
@property(nonatomic,copy) NSString * fastdfsImageServer;
@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * replyId;
@property(nonatomic,copy) NSString * userId;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,copy) NSString * commentId;
@property(nonatomic,copy) NSString * replyFrom;
@property(nonatomic,copy) NSString * replyFromIcon;
@property(nonatomic,copy) NSString * replyTo;
@property(nonatomic,copy) NSString * replyToIcon;


@property(nonatomic,assign) NSInteger replyBodyHeight;  //每个回复的垂直高度
@property(nonatomic,assign) NSInteger replyContentHeight;//每个回复内容的LableHeight


@end

@interface TopicCommentListModel : IObjcJsonBase

@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * topicId;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * userIcon;
@property (nonatomic,copy) NSString * replyId;
@property (nonatomic,copy) NSString * replyer;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * createTime;

//评论
@property (nonatomic,copy) NSArray * replies;
@property(nonatomic,assign) NSInteger cellHeight;              //cell整体高度
@property(nonatomic,assign) NSInteger topicContentHeight;        //每个评论内容的高度
@property(nonatomic,assign) NSInteger replyBodyHeight;              //当前Cell的所有回复高度



@end


@interface TopicCommentModel : IObjcJsonBase

@property (nonatomic,strong) NSNumber * pageNo;
@property (nonatomic,strong) NSNumber * pageSize;
@property (nonatomic,strong) NSNumber * count;
@property (nonatomic,strong) NSArray * list;


@end


@interface TopicCommentListResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) TopicCommentModel * data;

@end


@interface NetWork_topicCommentList : WCServiceBase

@property (nonatomic,copy) NSString * topicId;
@property (nonatomic,strong) NSNumber * pageSize;
@property (nonatomic,strong) NSNumber * pageNo;


@end
