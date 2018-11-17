//
//  NetWork_addressBookList.m
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_addressBookList.h"

@implementation AaddressBookModel

@end

@implementation AddressBookRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"AaddressBookModel"};
}

@end

@implementation NetWork_addressBookList

-(Class)responseType{
    return [AddressBookRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/personal/society/list";
}

@end
