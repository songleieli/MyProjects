//
//  WXSmartVideoView.m
//  SmartVideo
//
//  Created by yindongbo on 2017/5/5.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import "WXSmartVideoView.h"
#import "WXSmartVideoBottomView.h"
#import "WXVideoPreviewViewController.h"
#import "GPUImage.h"

#import "GPUImageBeautifyFilter.h"                  //美颜滤镜
#import "GPUImageSketchFilter.h"                    //素描滤镜
#import "GPUImageSmoothToonFilter.h"                //卡通滤镜
#import "GPUImageEmbossFilter.h"                    //浮雕效果，带有点3d的感觉
#import "GPUImageGlassSphereFilter.h"               //水晶球效果
#import "GPUImageKuwaharaFilter.h"                  //桑原(Kuwahara)滤波,水粉画的模糊效果；处理时间比较长，慎用
#import "GPUImageStretchDistortionFilter.h"         //伸展失真，哈哈镜
#import "GPUImageSphereRefractionFilter.h"          //球形折射，图形倒立
#import "GPUImageHalftoneFilter.h"                  //点染,图像黑白化，由黑点构成原图的大致图形




typedef enum : NSUInteger {
    FaceCameraFilterNone,
    FaceCameraFilterBeautify,
    FaceCameraFilterSketch,
    FaceCameraFilterSmoothToon,
    FaceCameraFilterEmboss,
    FaceCameraFilterGlassSphere,
    FaceCameraFilterKuwahara,
    FaceCameraFilterStretchDistortion,
    FaceCameraFilterSphereRefraction,
    FaceCameraFilterHalftone,
} FaceCameraFilterEnum;

@interface WXSmartVideoView()<WXSmartVideoDelegate>

@property (nonatomic, strong) UIButton *invertBtn; //切换前置和后置摄像头
@property (nonatomic, strong) WXSmartVideoBottomView *bottomView; // 包含箭头和文字 and controlView
//GPUImageVideoCamera仅能录像， GPUImageStillCamera 可拍照可录像，继承于GPUImageVideoCamera
@property (nonatomic, strong) GPUImageStillCamera *camera;
@property (nonatomic, strong) GPUImageMovieWriter *writer;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, strong) id  tempFilter;

@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, assign) BOOL savingImg;
@property (nonatomic, strong) WXVideoPreviewViewController *vc;
@property (nonatomic, strong) UIButton *beautifyBtn; //滤镜button
@end


#define kMAXDURATION 10
//#define kWeakSelf
@implementation WXSmartVideoView

-(void)setEnableVideoRecord:(BOOL)enableVideoRecord{
    _enableVideoRecord = enableVideoRecord;
    _bottomView.enableVideoRecord = enableVideoRecord;
}


#pragma mark ---- 元素声明 ----

- (UIButton *)invertBtn {
    if (!_invertBtn) {
        _invertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_invertBtn setTitle:@"前置" forState:UIControlStateNormal];
        [_invertBtn setTitle:@"后置" forState:UIControlStateSelected];
        [_invertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_invertBtn addTarget:self action:@selector(InvertShot:) forControlEvents:UIControlEventTouchUpInside];
        _invertBtn.frame = CGRectMake(ScreenWidth - 60, 10, 50, 50);
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = _invertBtn.bounds;
        layer.backgroundColor = [UIColor blackColor].CGColor;
        layer.opacity = 0.7;
        layer.cornerRadius = layer.frame.size.width/2;
        [_invertBtn.layer addSublayer:layer];
    }
    return _invertBtn;
}

- (UIButton *)beautifyBtn {
    
    if (!_beautifyBtn) {
        _beautifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beautifyBtn setTitle:@"无" forState:UIControlStateNormal];
        [_beautifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_beautifyBtn addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
        _beautifyBtn.frame = CGRectMake(ScreenWidth - 90, 70, 80, 80);
        _beautifyBtn.tag = 1;
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = _beautifyBtn.bounds;
        layer.backgroundColor = [UIColor blackColor].CGColor;
        layer.opacity = 0.7;
        layer.cornerRadius = layer.frame.size.width/2;
        [_beautifyBtn.layer addSublayer:layer];
    }
    return _beautifyBtn;
}

- (WXSmartVideoBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[WXSmartVideoBottomView alloc] initWithFrame:CGRectMake(0,ScreenHeight - 180, ScreenWidth, 300)];
        //test
        _bottomView.backgroundColor = [UIColor clearColor];
        //        _bottomView.backgroundColor = [UIColor redColor];
        _bottomView.delegate = self;
        _bottomView.duration = kMAXDURATION;
        _bottomView.enableVideoRecord = YES; //默认可以录视频
        __weak id weakSelf = self;
        [_bottomView setBackBlock:^{
            [weakSelf cancelCapture]; //响应取消block
            [weakSelf removeSelf];
        }];
    }
    return _bottomView;
}

- (NSURL *)videoUrl {
    if (!_videoUrl) {
        NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
        _videoUrl = [NSURL fileURLWithPath:pathToMovie];
        unlink([pathToMovie UTF8String]);
    }
    return _videoUrl;
}

- (GPUImageMovieWriter *)writer {
    if (!_writer) {
        _writer = [[GPUImageMovieWriter alloc] initWithMovieURL:self.videoUrl size:[self videoSize:self.filterView.size]];
        _writer.encodingLiveVideo = YES;
        _writer.shouldPassthroughAudio = YES;
        _writer.hasAudioTrack=YES;
    }
    return _writer;
}

- (GPUImageStillCamera *)camera {
    if (!_camera) {
        _camera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetInputPriority cameraPosition:AVCaptureDevicePositionBack];
        _camera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _camera.horizontallyMirrorFrontFacingCamera = YES; // 前置摄像头需要 镜像反转
        _camera.horizontallyMirrorRearFacingCamera = NO; // 后置摄像头不需要 镜像反转 （default：NO）
        
        [_camera addAudioInputsAndOutputs]; //该句可防止允许声音通过的情况下，避免录制第一帧黑屏闪屏
    }
    return _camera;
}

- (GPUImageView *)filterView {
    if (!_filterView) {
        _filterView = [[GPUImageView alloc] initWithFrame:self.bounds];
        _filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    }
    return _filterView;
}


#pragma mark ---- init初始化 ----

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.filterView];
        [self.camera addTarget:self.filterView];
        [self.camera startCameraCapture]; //开始捕获视频
        self.camera.audioEncodingTarget = self.writer; //音频
        
        /*使用GPUImageFilter 作为原图效果，没有添加滤镜*/
        GPUImageFilter *imageFilter = [[GPUImageFilter alloc] init];
        [imageFilter addTarget:_filterView];
        [imageFilter addTarget:self.writer];
        [self.camera addTarget:imageFilter];
        
        _tempFilter = imageFilter;
        
        [self addSubview:self.beautifyBtn];
        [self addSubview:self.invertBtn];
        [self addSubview:self.bottomView];
    }
    return self;
}

#pragma mark ---- 按钮点击事件 ----

- (void)InvertShot:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    [self.camera rotateCamera];
}

- (void)filter:(UIButton *)btn {
    
    FaceCameraFilterEnum filterEnum = btn.tag;
    [self.camera removeAllTargets];
    
    switch (filterEnum) {
        case FaceCameraFilterNone:{
            btn.tag = 1;
            
            GPUImageFilter *imageFilter = [[GPUImageFilter alloc] init];
            [self.camera addTarget:imageFilter];
            
            [imageFilter addTarget:_filterView];
            [imageFilter addTarget:self.writer];
            _tempFilter = imageFilter;
            [_beautifyBtn setTitle:@"无" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterBeautify:{
            btn.tag = 2;
            // MARK: 添加 美颜滤镜
            GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
            [self.camera addTarget:beautifyFilter];
            
            [beautifyFilter addTarget:_filterView];
            [beautifyFilter addTarget:self.writer];
            _tempFilter = beautifyFilter;
            [_beautifyBtn setTitle:@"美颜" forState:UIControlStateNormal];
        }
            break;

        case FaceCameraFilterSketch:{
            btn.tag = 3;
            GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
            [self.camera addTarget:filter];
            [filter addTarget:_filterView];
            [filter addTarget:self.writer];
            _tempFilter = filter;
            [_beautifyBtn setTitle:@"素描" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterSmoothToon:{
            btn.tag = 4;
            GPUImageSmoothToonFilter *smoothToonFilter = [[GPUImageSmoothToonFilter alloc] init];
            [self.camera addTarget:smoothToonFilter];
            
            [smoothToonFilter addTarget:_filterView];
            [smoothToonFilter addTarget:self.writer];
            _tempFilter = smoothToonFilter;
            [_beautifyBtn setTitle:@"卡通" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterEmboss:{
            btn.tag = 5;
            GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
            [self.camera addTarget:embossFilter];
            
            [embossFilter addTarget:_filterView];
            [embossFilter addTarget:self.writer];
            _tempFilter = embossFilter;
            [_beautifyBtn setTitle:@"浮雕" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterGlassSphere:{
            btn.tag = 6;
            GPUImageGlassSphereFilter *glassSphereFilter = [[GPUImageGlassSphereFilter alloc] init];
            [self.camera addTarget:glassSphereFilter];
            
            [glassSphereFilter addTarget:_filterView];
            [glassSphereFilter addTarget:self.writer];
            _tempFilter = glassSphereFilter;
            [_beautifyBtn setTitle:@"水晶球" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterKuwahara:{
            btn.tag = 7;
            GPUImageKuwaharaFilter *kuwaharaFilter = [[GPUImageKuwaharaFilter alloc] init];
            [self.camera addTarget:kuwaharaFilter];
            
            [kuwaharaFilter addTarget:_filterView];
            [kuwaharaFilter addTarget:self.writer];
            _tempFilter = kuwaharaFilter;
            [_beautifyBtn setTitle:@"桑原" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterStretchDistortion:{
            btn.tag = 8;
            GPUImageStretchDistortionFilter *stretchDistortionFilter = [[GPUImageStretchDistortionFilter alloc] init];
            [self.camera addTarget:stretchDistortionFilter];
            
            [stretchDistortionFilter addTarget:_filterView];
            [stretchDistortionFilter addTarget:self.writer];
            _tempFilter = stretchDistortionFilter;
            [_beautifyBtn setTitle:@"哈哈镜" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterSphereRefraction:{
            btn.tag = 9;
            GPUImageSphereRefractionFilter *sphereRefractionFilter = [[GPUImageSphereRefractionFilter alloc] init];
            [self.camera addTarget:sphereRefractionFilter];
            
            [sphereRefractionFilter addTarget:_filterView];
            [sphereRefractionFilter addTarget:self.writer];
            _tempFilter = sphereRefractionFilter;
            [_beautifyBtn setTitle:@"球形倒立" forState:UIControlStateNormal];
        }
            break;
        case FaceCameraFilterHalftone:{
            btn.tag = 0;
            GPUImageHalftoneFilter *halftoneFilter = [[GPUImageHalftoneFilter alloc] init];
            [self.camera addTarget:halftoneFilter];
            
            [halftoneFilter addTarget:_filterView];
            [halftoneFilter addTarget:self.writer];
            _tempFilter = halftoneFilter;
            [_beautifyBtn setTitle:@"点染" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}


#pragma mark ------ CustomMethod 自定义方法 ---------------

- (void)removeSelf {
    
    //移除相机，添加动画
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (CGSize)videoSize:(CGSize)size {
    /**
     解决宽度不是16倍数会出现绿边问题
     */
    int width = size.width;
    int height = size.height;
    while (width%16>0)
    {
        width = width +1;
    }
    
    while (height%16>0)
    {
        height = height +1;
    }
    return CGSizeMake(width, height);
}

- (void)writerCurrentFrameToLibrary {
    _savingImg = YES;
    kWeakSelf(self)
    
    if (_tempFilter) {
        [self.camera capturePhotoAsJPEGProcessedUpToFilter:_tempFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error){
            
            UIImage *img = [UIImage imageWithData:processedJPEG];
            [weakSelf previewPhoto:img];
        }];
    }else {
        [self showAlterViewTitle:@"失败" message:@"没有滤镜不能进行拍照"];
    }
}

- (void)showAlterViewTitle:(NSString *)title message:(NSString *)message {
    _savingImg = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)previewSandboxVideo:(NSString *)sanboxURL videoInfo:(NSDictionary *)info{
    
    NSLog(@"%@", sanboxURL);
    kWeakSelf(self);
    self.vc = [WXVideoPreviewViewController new];
    self.vc.url = sanboxURL;
    [self.vc setOperateBlock:^{
        if (weakSelf.finishedRecordBlock){
            weakSelf.finishedRecordBlock(info);
        }
        [weakSelf removeSelf]; //移除相机
    }];
    [self.vc setCancelBlock:^{
        /*
         GPUImageMovieWriter 无法2次录像 报错：[AVAssetWriter startWriting] Cannot call method when status is 3
         
         1.摄像头实例取消对GPUImageMovieWriter的绑定，因为重新实例化新的GPUImageMovieWriter以后原来的实例就没用了。
         2.删除原来已经写好的影片文件，如果新的实例直接写入已存在的文件会报错AVAssetWriterStatusFailed。
         3.重新实例化一个GPUImageMovieWriter。
         4.把新的GPUImageMovieWriter绑定到摄像头实例。
         */
        
        [weakSelf.camera removeAllTargets];
        [[NSFileManager defaultManager] removeItemAtURL:weakSelf.videoUrl error:nil];
        weakSelf.writer = nil;
        
        [weakSelf.camera startCameraCapture];
        weakSelf.camera.audioEncodingTarget = weakSelf.writer;
        
        [weakSelf.camera addTarget:weakSelf.tempFilter];
        
        [weakSelf.tempFilter addTarget:weakSelf.filterView];
        [weakSelf.tempFilter addTarget:weakSelf.writer];
    }];
    [self addSubview:self.vc.view];
}

- (void)previewPhoto:(UIImage *)img { //预览拍摄的照片
    
    kWeakSelf(self);
    _savingImg = NO;
    self.vc = [WXVideoPreviewViewController new];
    self.vc.img = img;
    [self.vc setOperateBlock:^{
        if(weakSelf.finishedCaptureBlock){
            [weakSelf finishedCapture:img];
        }
        [weakSelf removeSelf]; //移除相机
    }];
    [self addSubview:self.vc.view];
}

#pragma  mark -------------------- WXSmartVideoDelegate

- (void)wxSmartVideo:(WXSmartVideoBottomView *)smartVideoView zoomLens:(CGFloat)scaleNum {
//    [self.recorder setScaleFactor:scaleNum];
}

- (void)wxSmartVideo:(WXSmartVideoBottomView *)smartVideoView isRecording:(BOOL)recording {
    if (recording) {
        NSLog(@"开始录制");
        [self startRecording];
    }else {
        NSLog(@"结束录制");
        [self finishRecording];
    }

}

- (void)wxSmartVideo:(WXSmartVideoBottomView *)smartVideoView captureCurrentFrame:(BOOL)capture {
    if (capture && !_savingImg) {
        [self writerCurrentFrameToLibrary];
    }
}

#pragma  mark --------开始录制，结束录制，响应Block------------

- (void)startRecording {
    
    if (!_tempFilter) {
        [self showAlterViewTitle:@"失败" message:@"没有滤镜不能录制"];
        [self.bottomView restoreUI];
    }
    else{
        [self.writer startRecording];
    }
}

- (void)finishRecording {
    
    [_tempFilter removeTarget:self.writer];
    [self.writer finishRecording];
    
    //宋磊添加，预览录制的视频
    NSDictionary *info = @{@"videoURL":[self.videoUrl description]};
    [self previewSandboxVideo:[info objectForKey:@"videoURL"] videoInfo:info]; //预览录制的视频
}






- (void)finishedCapture:(UIImage *)img {
    if (self.finishedCaptureBlock) {
        self.finishedCaptureBlock(img);
    };
}

- (void)cancelCapture{
    if (self.cancelCaptureBlock) {
        self.cancelCaptureBlock();
    };
}

-(AVCaptureVideoOrientation)avOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deviceOrientation;
    if ( deviceOrientation == UIDeviceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeRight;
    else if ( deviceOrientation == UIDeviceOrientationLandscapeRight )
        result = AVCaptureVideoOrientationLandscapeLeft;
    return result;
}
@end
