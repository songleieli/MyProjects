//
//  XLCommentView.m
//  xl_native
//
//  Created by MAC on 2018/10/8.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLCommentView.h"

@implementation XLCommentView

+ (instancetype)shareView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"XLCommentView" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
    viewBorderRadius(self.text, 5, 0.5, [UIColor lightGrayColor]);
    self.text.delegate = self;
    self.text.scrollEnabled = NO;
}
- (IBAction)sendBtnClick:(UIButton *)sender {
    if (self.sendBtnClickBlock) {
        self.sendBtnClickBlock();
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        if (self.sendBtnClickBlock) {
            self.sendBtnClickBlock();
        }
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat width = CGRectGetWidth(textView.frame);
    CGFloat height = CGRectGetHeight(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
    textView.frame= newFrame;
    
    if (self.viewHeight) {
        self.viewHeight(textView.frame.size.height);
    }
    
    if (textView.text.length == 0) {
        self.paceText.text = @"写评论...";
    } else {
        self.paceText.text = @"";
    }
}


@end
