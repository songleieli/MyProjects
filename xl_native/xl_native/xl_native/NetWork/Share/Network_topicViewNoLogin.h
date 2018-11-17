//
//  Network_topicViewNoLogin.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/28.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"


@interface ListNoLoginModel : IObjcJsonBase

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

@interface CommentsNoLoginModel : IObjcJsonBase

@property(nonatomic,strong)NSNumber * id;
@property(nonatomic,strong)NSNumber * topicId;
@property(nonatomic,strong)NSNumber * url;
@property(nonatomic,strong)NSArray * list;

@end

@interface ImagesNoLoginModel : IObjcJsonBase

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * topicId;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * breviaryUrl;

@end

@interface topicViewNoLoginModel : IObjcJsonBase
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * topicContent;
@property(nonatomic,copy)NSString * publishTime;
@property(nonatomic,copy)NSString * showTime;
@property(nonatomic,copy)NSString * publisher;
@property(nonatomic,copy)NSString * topicAddress;
@property(nonatomic,copy)NSString * communityName;
@property(nonatomic,copy)NSString * typeName;
@property(nonatomic,strong)NSNumber * commentNum;
@property(nonatomic,strong)NSNumber * praiseNum;
@property(nonatomic,copy)NSString * userIcon;
@property(nonatomic,strong)NSArray * images;
@property(nonatomic,strong)CommentsNoLoginModel * comments;

@property(nonatomic,assign) NSInteger cellHeight;


@end


@interface topicViewNoLoginResponse : IObjcJsonBase

@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,strong)topicViewNoLoginModel * data;
@end

@interface Network_topicViewNoLogin : WCServiceBase

@property(nonatomic,strong) NSString * id;

@end
