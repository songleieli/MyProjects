//
//  Network_topicViewLogin.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/28.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

@interface LisLoginModel : IObjcJsonBase

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * createTime;
@property(nonatomic,copy)NSString * topicId;
@property(nonatomic,copy)NSString * userId;
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * userIcon;
@property(nonatomic,copy)NSString * replyId;
@property(nonatomic,copy)NSString * replyer;
@property(nonatomic,copy)NSString * content	;



@end

@interface CommentsLoginModel : IObjcJsonBase

@property(nonatomic,strong)NSNumber * id;
@property(nonatomic,strong)NSNumber * topicId;
@property(nonatomic,strong)NSNumber * url;
@property(nonatomic,strong)NSArray * list;

@end

@interface ImageLoginModel : IObjcJsonBase

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * topicId;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * breviaryUrl;

@end


@interface TopicViewLoginModel : IObjcJsonBase

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * topicContent;
@property(nonatomic,copy)NSString * publishTime;
@property(nonatomic,copy)NSString * showTime;
@property(nonatomic,copy)NSString * publisher;
@property(nonatomic,copy)NSString * topicAddress;
@property(nonatomic,copy)NSString * typeName;
@property(nonatomic,copy)NSString * communityName;
@property(nonatomic,strong)NSNumber * commentNum;
@property(nonatomic,strong)NSNumber * praiseNum;
@property(nonatomic,copy)NSString * userIcon;
@property(nonatomic,strong)NSArray * images;
@property(nonatomic,strong)CommentsLoginModel * comments;
@property(nonatomic,assign)Boolean praiseFlag;

@property(nonatomic,assign) NSInteger cellHeight;

@end

@interface TopicViewLoginResponse : IObjcJsonBase

@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,strong)TopicViewLoginModel * data;
@end

@interface Network_topicViewLogin : WCServiceBase

@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * token;

@end
