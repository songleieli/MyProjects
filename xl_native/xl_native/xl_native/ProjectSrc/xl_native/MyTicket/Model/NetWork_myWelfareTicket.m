//
//  NetWork_myWelfareTicket.m
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_myWelfareTicket.h"

@implementation MyWelfareTicketModel

@end

@implementation MyWelfareTicketRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"MyWelfareTicketModel"};
}

@end

@implementation NetWork_myWelfareTicket

-(Class)responseType{
    return [MyWelfareTicketRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/consume/voucher/show";
}

@end
