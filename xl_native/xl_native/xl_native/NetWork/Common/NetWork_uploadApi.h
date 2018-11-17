//
//  NetWork_upload.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UploadModel : IObjcJsonBase

@property(nonatomic,copy) NSString * attachUrl;
@property(nonatomic,copy) NSString * fastdfsImageServer;
@property(nonatomic,copy) NSString * showAttachUrl;
@property(nonatomic,copy) NSString * fileName;
@property(nonatomic,strong) NSNumber * size;

@end


@interface UploadRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * totall;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;

@end

@interface NetWork_uploadApi : WCServiceBase



@end
