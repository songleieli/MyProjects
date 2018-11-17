//
//  XLVoiceSingleTool.h
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLVoiceSingleTool : NSObject

@property (assign, nonatomic) int voiceFirstClick;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
