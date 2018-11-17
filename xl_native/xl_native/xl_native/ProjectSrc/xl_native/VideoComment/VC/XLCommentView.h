//
//  XLCommentView.h
//  xl_native
//
//  Created by MAC on 2018/10/8.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLCommentView : UIView <UITextViewDelegate>

+ (instancetype)shareView ;

@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *paceText;

@property (copy, nonatomic) void (^viewHeight)(CGFloat viewH);
@property (copy, nonatomic) dispatch_block_t sendBtnClickBlock;

@end

NS_ASSUME_NONNULL_END
