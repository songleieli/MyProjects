//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

/*
 *
 
 "fee_id": "006I000P1OGHNdEZeHmQts",
 "fee_name": "疏通下水道",
 "repair_fee": "70.0"
 
 */


@interface ZjFeesItemsModel : IObjcJsonBase

@property(nonatomic,copy) NSString * fee_id;        //费项id
@property(nonatomic,copy) NSString * fee_name;      //费项名称
@property(nonatomic,copy) NSString * repair_fee;    //原价
@property(nonatomic,copy) NSString * paid_fee;      //议价
@property(nonatomic,assign) BOOL isCurrent;         //是否当前正在添加
@property(nonatomic,strong) UIView *viewFee;




@end


@interface ZjFeesItemsTempModel : IObjcJsonBase

@property(nonatomic,copy) NSArray * fees;
@end



@interface ZjFeesItemsRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjFeesItemsTempModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_fees_items : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *project_id;



@end
