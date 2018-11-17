//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjModifyPwdModel : IObjcJsonBase


/*
 
 id	主键	string	@mock=1d417c177d444839848477751ba8026d
 createTime	创建时间	string	@mock=2016-11-25
 updateTime	发布时间	string	@mock=2016-11-29 11:30:13
 content	消息标题	string	@mock=3232
 contentExt		string	@mock=
 type	类型	string	@mock=NOTIFY
 readFlag	是否已读	string	@mock=Y
 readDate	读取时间	string	@mock=2016-11-29 00:00:00
 status	push状态	string	@mock=FAIL
 nativeCreateTime		string	@mock=2016-11-25 13:31:15
 times	阅读次数	string
 
 */


@property(nonatomic,copy) NSString * total;
@property(nonatomic,copy) NSArray * rows;


@end




@interface ZjModifyPwdRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status;
@property(nonatomic,strong) ZjModifyPwdModel * data;
@property(nonatomic,copy) NSString *message;


@end

@interface NetWork_ZJ_modifyPwd : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *oldPwd;
@property(nonatomic,copy) NSString *pwdNew;

//@property(nonatomic,copy) NSString *newPwd;


@end
