//
//  XLVoiceButton.h
//  xl_native
//
//  Created by MAC on 2018/9/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyMSC.h"
#import "IATConfig.h"
#import "AppDelegateBase.h"
#import "ZJCustomTabBar.h"
#import "XLVoiceView.h"

#import "BBVoiceRecordController.h"
#import "UIColor+BBVoiceRecord.h"
#import "BBHoldToSpeakButton.h"

#define kFakeTimerDuration       0.2
#define kMaxRecordDuration       60     //最长录音时长
#define kRemainCountingDuration  10     //剩余多少秒开始倒计时

typedef void(^initBlock)(VoiceJumpModel *model);

typedef enum : NSUInteger {
    VoiceSingleClickTypeDefault = 0,
    VoiceSingleClickTypePurchase = 1 // 语音购买
    
} VoiceSingleClickType;

typedef enum : NSUInteger {
    PushNativeTypeNone = 0,           //
    
    PushNativeTypeSetting = 6,// 设置
    PushNativeTypeMyCredit = 7,        // 我的信用
    PushNativeTypeMyIntegral = 8,// 我的积分
    PushNativeTypeAuthentication = 9, // 认证
    PushNativeTypePersonalInformation = 10,// 用户资料
    PushNativeTypeModifyPassword = 11,// 修改密码
    PushNativeTypeAbout = 12, // 关于
    PushNativeTypeHTML = 1000// H5
    
} PushNativeType;

@interface XLVoiceButton : UIButton <IFlyRecognizerViewDelegate,IFlySpeechRecognizerDelegate>


@property (assign, nonatomic) CGFloat previousX;
@property (assign, nonatomic) CGFloat previousY;

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (assign, nonatomic) VoiceSingleClickType voiceSingleClickType; 

@property (copy, nonatomic) void (^voiceResultAction)(VoiceJumpModel *model);

@property (nonatomic, strong) BBVoiceRecordController *voiceRecordCtrl;
@property (nonatomic, assign) BBVoiceRecordState currentRecordState;
@property (nonatomic, strong) NSTimer *fakeTimer;
@property (nonatomic, assign) float duration;
@property (nonatomic, assign) BOOL canceled;

@property (strong, nonatomic) XLVoiceView *voiceView;


- (void)voiceSingleClick:(VoiceSingleClickType)type;

//拖动按钮，参考代码网址：https://www.jianshu.com/p/a493df5a44e3
@property (nonatomic,assign) BOOL isDrag;  //用来判断按钮是否处于拖动状态


@property (nonatomic,strong) NSString * filePathMp3;

@end
