//
//  VoiceJumpModel.h
//  xl_native
//
//  Created by MAC on 2018/9/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceJumpModel : NSObject

@property (copy, nonatomic) NSString *url; ///< H5页面地址
@property (copy, nonatomic) NSString *filePathMp3; ///< 语音沙盒地址
@property (copy, nonatomic) NSString *voiceText; ///< 语音内容文字
@property (assign, nonatomic) NSInteger nativeType;
@property (assign, nonatomic) NSInteger voiceSingleClickType;

@end
