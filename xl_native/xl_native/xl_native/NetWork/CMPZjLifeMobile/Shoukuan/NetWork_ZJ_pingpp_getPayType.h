//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

@interface ZjPingppGetPayTypeModel : IObjcJsonBase

@property(nonatomic,copy) NSString *pay_type_id;
@property(nonatomic,copy) NSString *pay_type;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *number;


@end



@interface ZjPingppGetPayTypeRespone : IObjcJsonBase

@property(nonatomic,strong) NSArray *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_getPayType : WCServiceBase_Zjsh


@end
