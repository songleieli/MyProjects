//
//  Network_allTopicListLogin.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/28.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface ImagesLoginModel : IObjcJsonBase

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * topicId;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * breviaryUrl;
@property (copy, nonatomic) NSString *publishId; ///< 发布人id

@end


@interface ListLoginModel : IObjcJsonBase
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * topicContent;
@property(nonatomic,copy)NSString * publishTime;
@property(nonatomic,copy)NSString * showTime;
@property(nonatomic,copy)NSString * publisher;
@property(nonatomic,copy)NSString * topicAddress;
@property(nonatomic,copy)NSString * typeName;
@property(nonatomic,copy)NSString * typeId;
@property(nonatomic,copy)NSString * communityName;
@property(nonatomic,copy)NSString * topicType   ;
@property(nonatomic,strong)NSNumber * commentNum;
@property(nonatomic,strong)NSNumber * praiseNum;
@property(nonatomic,strong)NSNumber * viewTimes;
@property(nonatomic,copy)NSString * userIcon;
@property(nonatomic,strong)NSMutableArray * medias;
@property(nonatomic,assign)Boolean praiseFlag;
@property (copy, nonatomic) NSString *publishId; ///< 发布人id


//cell 高度计算
@property(nonatomic,copy)NSString *isFirstCell;
@property(nonatomic,assign) NSInteger heightCell;
@property(nonatomic,assign) NSInteger heightBgTopBgView;
@property(nonatomic,assign) NSInteger heightContentLable;
@property(nonatomic,assign) CGFloat widthContentLable;
@property(nonatomic,assign) NSInteger heightBgBottomView;
@property(nonatomic,assign) NSInteger heightImgView;
@property(nonatomic,assign) NSInteger heightBackgroundBtn;
@property(nonatomic,assign) NSInteger widthOneImg;
@property(nonatomic,assign) NSInteger labelContectW;
@property(nonatomic,assign) NSInteger typelabelContectW;
@property(nonatomic,assign) NSInteger locationlabelContectW;


@property(nonatomic,assign) NSInteger marginOne;

//collictionview 相关计算
@property (nonatomic,assign) NSInteger itemWH;
@property (nonatomic,assign) NSInteger margin;
@property (nonatomic,assign) NSInteger rowCount;
@property (nonatomic,assign) NSInteger colCount;

@property (nonatomic,assign) NSInteger heightColloctionView;
@property (nonatomic,assign) NSInteger widthColloctionView;
@property (nonatomic,assign) NSInteger widthFourColloctionView;
@property (nonatomic,assign) NSInteger timelabelContectW;

@property (nonatomic,assign) NSInteger heightForOneImage;

@end

@interface UserModel : IObjcJsonBase

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * nickName;
@property(nonatomic,copy)NSString * userIcon;
@property(nonatomic,copy)NSString * communityName;

@end



@interface allTopicListLoginModel : IObjcJsonBase

//@property(nonatomic,strong)NSNumber * pageNo;
//@property(nonatomic,strong)NSNumber * pageSize;
@property(nonatomic,strong)NSNumber * count;
@property(nonatomic,strong)NSArray * list;

//关注用户列表 exists NO 关注列表为空，需要关注的用户列表
@property(nonatomic,assign)BOOL exists;
@property(nonatomic,strong)NSArray * listUsers;

@end

@interface allTopicListLoginResponse : IObjcJsonBase

@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,strong)allTopicListLoginModel * data;

@end

@interface Network_hotTopicList : WCServiceBase

@property(nonatomic,strong)NSNumber * longitude;
@property(nonatomic,strong)NSNumber * latitude;

@property(nonatomic,strong)NSNumber * pageSize;
@property(nonatomic,strong)NSNumber * pageNo;
@property(nonatomic,strong)NSString * token;
@property(nonatomic,strong)NSString * publishId;

@end
