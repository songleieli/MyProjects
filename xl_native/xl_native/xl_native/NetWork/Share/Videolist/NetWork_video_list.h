//
//  Network_allTopicListLogin.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Network_hotTopicList.h"


//@interface MediaModel : IObjcJsonBase
//
//@property(nonatomic,copy)NSString * id;
//@property(nonatomic,copy)NSString * topicId;
//@property(nonatomic,copy)NSString * url;
//@property(nonatomic,copy)NSString * breviaryUrl;
//
//@end

//@interface VideoListModel : IObjcJsonBase
//
//@property(nonatomic,copy)NSString * id;
//@property(nonatomic,copy)NSString * topicContent;
//@property(nonatomic,copy)NSString * publishTime;
//@property(nonatomic,copy)NSString * showTime;
//@property(nonatomic,copy)NSString * publisher;
//@property(nonatomic,copy)NSString * topicAddress;
//@property(nonatomic,copy)NSString * typeName;
//@property(nonatomic,copy)NSString * communityName;
//@property(nonatomic,copy)NSString * topicType   ;
//@property(nonatomic,strong)NSNumber * commentNum;
//@property(nonatomic,strong)NSNumber * praiseNum;
//@property(nonatomic,copy)NSString * userIcon;
//@property(nonatomic,strong)NSMutableArray * medias;
//
//@end


@interface VideoListModelTemp : IObjcJsonBase

@property(nonatomic,strong)NSArray * list;

@end



@interface  VideoListRespone : IObjcJsonBase

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) VideoListModelTemp *data;

@end

@interface NetWork_video_list : WCServiceBase

@property(nonatomic,copy) NSString *typeIds;
@property(nonatomic,copy) NSString *token;
@property(nonatomic,strong)NSNumber * pageSize;
@property(nonatomic,strong)NSNumber * pageNo;

@end
