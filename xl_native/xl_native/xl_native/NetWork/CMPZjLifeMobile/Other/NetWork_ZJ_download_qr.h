//
//  NetWork_noticeList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/18.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Ljh.h"

@interface ZjDownloadQrModel : IObjcJsonBase

@property(nonatomic,copy) NSString * appkey;
@property(nonatomic,copy) NSString * url;
@property(nonatomic,copy) NSString * html;

@end


@interface ZjDownloadQrRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;


@end


@interface NetWork_ZJ_download_qr : WCServiceBase_Zjsh

@end
