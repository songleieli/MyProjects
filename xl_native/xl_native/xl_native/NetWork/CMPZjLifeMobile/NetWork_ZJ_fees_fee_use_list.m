//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_fees_fee_use_list.h"


@implementation ZjFeeUseListModel


@end

//@implementation ZjCreateApplicationTempModel
//
//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"material" : @"material"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"material" : @"ZjCreateApplicationModel"};
//}
//
//@end


@implementation ZjFeeUseListTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"money_form" : @"money_form"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"money_form" : @"ZjFeeUseListModel"};
}

@end


@implementation ZjFeeUseListRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"money_form" : @"money_form"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjFeeUseListTempModel"};
}

@end

@implementation NetWork_ZJ_fees_fee_use_list

-(Class)responseType{
    return [ZjFeeUseListRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/fees/fee_use_list";
}

@end
