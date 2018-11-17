//
//  ScanQRcode.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "TBBaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanQRcode : TBBaseViewController <AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    UIImageView * imageView;
}
@property ( strong , nonatomic ) AVCaptureDevice * device;

@property ( strong , nonatomic ) AVCaptureDeviceInput * input;

@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;

@property ( strong , nonatomic ) AVCaptureSession * session;

@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * preview;

@property ( nonatomic ) CGRect rectOfInterest NS_AVAILABLE_IOS (7_0);

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, retain) UIImageView * line;

@property (strong, nonatomic) UIView *boxView;
@property (nonatomic) BOOL isReading;
@property (strong, nonatomic) CALayer *scanLayer;

@end
