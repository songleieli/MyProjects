//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

/*
@property(nonatomic,copy) NSString * fee_id;        //费项id
@property(nonatomic,copy) NSString * fee_name;      //费项名称
@property(nonatomic,copy) NSString * repair_fee;    //原价
@property(nonatomic,copy) NSString * paid_fee;      //议价
@property(nonatomic,assign) BOOL isCurrent;         //是否当前正在添加
@property(nonatomic,strong) UIView *viewFee;
*/

@interface ZjFeeUseListModel : IObjcJsonBase

@property(nonatomic,copy) NSString * fee_id;
@property(nonatomic,copy) NSString * fee_name;
@property(nonatomic,copy) NSString * money_receivable;
@property(nonatomic,copy) NSString * money_paid;

@property(nonatomic,assign) BOOL isCurrent;         //是否当前正在添加
@property(nonatomic,strong) UIView *viewFee;

@end

@interface ZjFeeUseListTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray * money_form;
@property(nonatomic,copy) NSString *card_status;
@property(nonatomic,copy) NSString *receipt_num;
@property(nonatomic,copy) NSString *money_handle;
@property(nonatomic,copy) NSString *repair_material_fee;
@property(nonatomic,copy) NSString *repair_material_num;

@end


@interface ZjFeeUseListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;

@property(nonatomic,strong) ZjFeeUseListTempModel *result;




@end

@interface NetWork_ZJ_fees_fee_use_list : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;

@end
