//
//  NetWork_findList.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindListModel : IObjcJsonBase

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *communityId;

@property (nonatomic, copy) NSString *sourceSystemCommunityId;       //物管云小区Id
@property (nonatomic, copy) NSString *sourceSystem;                  //物管名称
@property (nonatomic, copy) NSString *serverUrl;                     //物管云部署Url
//@property (nonatomic, copy) NSString *coreUserId;                    //核心用户id



@property (nonatomic, copy) NSString *communityAddress;
@property (nonatomic, copy) NSString *communityName;
@property (nonatomic, copy) NSString * isAttention;
@end

@interface FindListRespone : IObjcJsonBase

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *data;

@end

@interface NetWork_findList : WCServiceBase_Ljh

@property(nonatomic,copy) NSString * token;


@end
