//
//  NetWork_hotTopic.h
//  xl_native
//
//  Created by MAC on 2018/10/11.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

//@interface HotTopicModel : IObjcJsonBase
//
//@property (assign, nonatomic) NSInteger userNumber;
//@property (assign, nonatomic) NSInteger topicNum;
//@property (copy, nonatomic) NSString *tagName;
//
//@end

@interface HotTopicRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_hotTopic : WCServiceBase

@property (copy, nonatomic) NSString *typeId;

@end

NS_ASSUME_NONNULL_END
