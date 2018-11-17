//
//  NetWork_myWelfareTicket.m
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_consume_list.h"

@implementation ConsumeRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"MyWelfareTicketModel"};
}

@end

@implementation NetWork_consume_list

-(Class)responseType{
    return [ConsumeRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/consume/voucher/list";
}

@end
