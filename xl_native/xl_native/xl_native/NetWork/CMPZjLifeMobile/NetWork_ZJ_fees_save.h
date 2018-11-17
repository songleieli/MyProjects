//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//



@interface ZjFeesSaveModel : IObjcJsonBase

@property(nonatomic,copy) NSString * material_name;
@property(nonatomic,copy) NSString * material_number;
@property(nonatomic,copy) NSString * sh_name;
@property(nonatomic,copy) NSString * sh_number;
@property(nonatomic,copy) NSString * material_price;
@property(nonatomic,copy) NSNumber * material_count;

@end


@interface ZjFeesSaveTempModel : IObjcJsonBase

@property(nonatomic,copy) NSArray * material;


@end



@interface ZjFeesSaveRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjFeesSaveTempModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_fees_save : WCServiceBase_Zjsh


/*
 
 "request_number": "01201607128933", //服务单号
 "card_status": "Y",                 //卡状态
 "receipt_num": "0123456789",        //收据号码(抄手抄的号)
 "money_handle": "0",                //应付金额(第三方修理)
 "repair_material_fee": "0",         //材料费用
 "repair_material_num": "0",         //材料票号
 "money_form": [
 
 material_fees:[
 
 */



@property(nonatomic,copy) NSString *request_number;
@property(nonatomic,copy) NSString *card_status;
@property(nonatomic,copy) NSString *receipt_num;
@property(nonatomic,copy) NSString *money_handle;
@property(nonatomic,copy) NSString *repair_material_fee;
@property(nonatomic,copy) NSString *repair_material_num;
@property(nonatomic,copy) NSString *money_form;
@property(nonatomic,copy) NSString *material_fees;


@end
