//
//  XLVoiceButton.m
//  xl_native
//
//  Created by MAC on 2018/9/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLVoiceButton.h"


@implementation XLVoiceButton

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        [self setImage:[UIImage imageNamed:@"一呼即有"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"一呼即有"] forState:UIControlStateHighlighted];
        [self initRecognizer]; //初始化讯飞参数
        
        //拖动
        [self  addTarget:self action:@selector(dragMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
        //拖动结束,先注册先相应
//        [self addTarget:self action:@selector(dragEnded:withEvent: )forControlEvents:UIControlEventTouchUpInside];
        //点击事件，后注册后相应
        [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) dragMoving: (UIControl *)c withEvent:event{
    
    CGPoint current = [[[event allTouches] anyObject] locationInView:self.superview];
    
    if(current.x > self.width/2 && current.x < self.superview.width- self.width/2 &&
       current.y > self.height/2 && current.y < self.superview.height- self.height/2){
        
        c.center = [[[event allTouches] anyObject] locationInView:self.self.superview];
    }
    self.isDrag = YES;
}

//- (void) dragEnded: (UIControl *)c withEvent:event {
//
//    CGPoint current = [[[event allTouches] anyObject] locationInView:self.superview];
//
//    if(current.x > self.width/2 && current.x < self.superview.width- self.width/2
//       && current.y > self.height/2 && current.y < self.superview.height- self.height/2){
//
//        c.center = [[[event allTouches] anyObject] locationInView:self.self.superview];
//    }
//}

//在点击方法里做一下判断，是拖动还是点击
- (void)onClick
{
    if (self.isDrag) {//拖动不弹出录音按钮，点击弹出录音按钮。
        self.isDrag = NO;
        return;
    }
    //点击方法
    NSLog(@"-------点击按钮--------");
    [self voiceSingleClick:VoiceSingleClickTypeDefault];
}


- (void)voiceSingleClick:(VoiceSingleClickType)type
{
    [XLVoiceSingleTool sharedInstance].voiceFirstClick = 0;
    self.voiceSingleClickType = type;
    [self  startService];
}

-(void)initRecognizer {
    
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        [_iFlySpeechRecognizer setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //录制声音名称
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];

        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
    }
}

#pragma mark - IFlySpeechRecognizerDelegate
- (void) onCompleted:(IFlySpeechError *) errorCode{
    
    [self stopService];
}

- (void)convertToMp3{
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *pcmFilePath = [NSString stringWithFormat:@"%@/asr.pcm",cachePath];
    NSString *fileName = [NSString stringWithFormat:@"/%@.mp3", @"test"];
    self.filePathMp3 = [cachePath stringByAppendingPathComponent:fileName];
    
    @try {
        int read,write;
        //只读方式打开被转换音频文件
        FILE *pcm = fopen([pcmFilePath cStringUsingEncoding:1], "rb");
        fseek(pcm, 4 * 1024, SEEK_CUR);//删除头，否则在前一秒钟会有杂音
        //只写方式打开生成的MP3文件
        FILE *mp3 = fopen([self.filePathMp3 cStringUsingEncoding:1], "wb");
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE * 2];
        unsigned char mp3_buffer[MP3_SIZE];
        //这里要注意，lame的配置要跟AVAudioRecorder的配置一致，否则会造成转换不成功
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 8000);//采样率
        
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            //以二进制形式读取文件中的数据
            read = (int)fread(pcm_buffer, 2 * sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            //二进制形式写数据到文件中  mp3_buffer：数据输出到文件的缓冲区首地址  write：一个数据块的字节数  1:指定一次输出数据块的个数   mp3:文件指针
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
        
    } @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    } @finally {
        NSLog(@"MP3生成成功!!!");
    }
}

- (void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    if (!results) {
        [SVProgressHUD showErrorWithStatus:@"语音未识别"];
        return;
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    NSArray *ws = rootDic[@"ws"];
    
    for (NSDictionary *dic in ws) {
        NSArray *cw = dic[@"cw"];
        for (NSDictionary *dic in cw) {
            NSString *w = dic[@"w"];
            [resultStr appendFormat:@"%@",w];
        }
    }
    
    if (resultStr.length != 0) {
        [self stopService];
        
        NetWork_keywordFunctionList *request = [[NetWork_keywordFunctionList alloc] init];
        request.keyword = resultStr;
        [request startPostWithBlock:^(keywordFunctionListRespone *result, NSString *msg, BOOL finished) {
            if(finished){
                NSDictionary *dic = (NSDictionary *)result.data;
                NSString *code = dic[@"functionCode"];
                NSString *name = dic[@"functionName"];
                NSString *keyword = dic[@"keyword"];

                if (self.voiceSingleClickType == VoiceSingleClickTypePurchase) {// 语音购买
                    [self actionWithCode:code name:@"" keyword:resultStr];
                } else {
                    [self actionWithCode:code name:name keyword:keyword];
                }
            } else {
                [VoiceAnimationHUD showDefault:msg success:NO];
            }
        }];
    }
}
- (void)actionWithCode:(NSString *)code name:(NSString *)name keyword:(NSString *)keyword
{
    AppDelegateBase *delegate = (AppDelegateBase *)[[UIApplication sharedApplication] delegate];
    ZJCustomTabBar *tab = (ZJCustomTabBar *)delegate.window.rootViewController;
    
    VoiceJumpModel *model = [[VoiceJumpModel alloc] init];
    model.filePathMp3 = self.filePathMp3;
    model.voiceText = keyword;
    model.voiceSingleClickType = self.voiceSingleClickType;
    
    int codeNum = [code intValue];
    
   if (codeNum == 1) {
        [tab selectTabAtIndex:0];
    } else if (codeNum == 2) {
        [tab selectTabAtIndex:1];
    } else if (codeNum == 3) {
        [tab selectTabAtIndex:2];
    } else if (codeNum == 4) {
        [tab selectTabAtIndex:3];
    } else if (codeNum == 5) {
        [tab selectTabAtIndex:4];
    } else if (codeNum == 6) {// 设置
        model.nativeType = PushNativeTypeSetting;
        [self pushAction:model];
    } else if (codeNum == 7) {// 信用
        model.nativeType = PushNativeTypeMyCredit;
        [self pushAction:model];
    } else if (codeNum == 8) {// 积分
        model.nativeType = PushNativeTypeMyIntegral;
        [self pushAction:model];
    } else if (codeNum == 9) {// 认证
        model.nativeType = PushNativeTypeAuthentication;
        [self pushAction:model];
    } else if (codeNum == 10) {// 资料
        model.nativeType = PushNativeTypePersonalInformation;
        [self pushAction:model];
    } else if (codeNum == 11) {// 修改密码
        model.nativeType = PushNativeTypeModifyPassword;
        [self pushAction:model];
    } else if (codeNum == 12) {// 关于
        model.nativeType = PushNativeTypeAbout;
        [self pushAction:model];
    }
    else if ([code containsString:@".html"]){
        model.nativeType = PushNativeTypeHTML;
        model.url = [NSString stringWithFormat:@"%@%@",[WCBaseContext sharedInstance].h5Server,code] ;
        [self pushAction:model];

        if (self.voiceSingleClickType == VoiceSingleClickTypePurchase) {// 语音购买
            self.voiceSingleClickType = VoiceSingleClickTypeDefault;
        }
    }
}
- (void)pushAction:(VoiceJumpModel *)model
{
    if (self.voiceResultAction) {
        self.voiceResultAction(model);
    }
}
- (void)startService
{
    // 启动语音识别服务
    [_iFlySpeechRecognizer startListening];
    
    self.currentRecordState = BBVoiceRecordState_Recording;
    [self dispatchVoiceState];
   
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.voiceView animated:NO completion:nil];
}
- (void)stopService
{
    [_iFlySpeechRecognizer stopListening];
    
    self.currentRecordState = BBVoiceRecordState_Normal;
    [self dispatchVoiceState];
    
    [self.voiceView dismissViewControllerAnimated:NO completion:nil];
    
    [self convertToMp3];
}
#pragma mark - 音量大小
- (void)startFakeTimer
{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
    self.fakeTimer = [NSTimer scheduledTimerWithTimeInterval:kFakeTimerDuration target:self selector:@selector(onFakeTimerTimeOut) userInfo:nil repeats:YES];
    [_fakeTimer fire];
}

- (void)stopFakeTimer
{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
}

- (void)onFakeTimerTimeOut
{
    self.duration += kFakeTimerDuration;
    NSLog(@"+++duration+++ %f",self.duration);
    float remainTime = kMaxRecordDuration-self.duration;
    if ((int)remainTime == 0) {
        self.currentRecordState = BBVoiceRecordState_Normal;
        [self dispatchVoiceState];
    }
    else if ([self shouldShowCounting]) {
        self.currentRecordState = BBVoiceRecordState_RecordCounting;
        [self dispatchVoiceState];
        [self.voiceRecordCtrl showRecordCounting:remainTime];
    }
    else
    {
        float fakePower = (float)(1+arc4random()%99)/100;
        [self.voiceRecordCtrl updatePower:fakePower];
    }
}

- (BOOL)shouldShowCounting
{
    if (self.duration >= (kMaxRecordDuration-kRemainCountingDuration) && self.duration < kMaxRecordDuration && self.currentRecordState != BBVoiceRecordState_ReleaseToCancel) {
        return YES;
    }
    return NO;
}

- (void)resetState
{
    [self stopFakeTimer];
    self.duration = 0;
    self.canceled = YES;
}

- (void)dispatchVoiceState
{
    if (_currentRecordState == BBVoiceRecordState_Recording) {
        self.canceled = NO;
        [self startFakeTimer];
    }
    else if (_currentRecordState == BBVoiceRecordState_Normal)
    {
        [self resetState];
    }
    [self.voiceRecordCtrl updateUIWithRecordState:_currentRecordState];
}

- (BBVoiceRecordController *)voiceRecordCtrl
{
    if (_voiceRecordCtrl == nil) {
        _voiceRecordCtrl = [BBVoiceRecordController new];

    }
    return _voiceRecordCtrl;
}
- (XLVoiceView *)voiceView {
        __weak typeof(self) weakSelf = self;
    if (!_voiceView) {
        _voiceView = [[XLVoiceView alloc] init];
        _voiceView.modalPresentationStyle = UIModalPresentationOverFullScreen;
        _voiceView.vcDismiss = ^{
            [weakSelf stopService];
        };
    }
    return _voiceView;
}

@end
