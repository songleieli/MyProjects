//
//  WXSmartVideoView.h
//  SmartVideo
//
//  Created by yindongbo on 2017/5/5.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXSmartVideoView : UIView


@property (nonatomic, copy) void (^finishedRecordBlock)(NSDictionary *dic); //视频录制完成

@property (nonatomic, copy) void (^finishedCaptureBlock)(UIImage *img);     //照片拍摄完成

@property (nonatomic, copy) void (^cancelCaptureBlock)();                   //取消拍摄视频

@property (nonatomic,assign) BOOL enableVideoRecord; //是否启用录像功能，add by songleilei

- (instancetype)initWithFrame:(CGRect)frame;

@end
