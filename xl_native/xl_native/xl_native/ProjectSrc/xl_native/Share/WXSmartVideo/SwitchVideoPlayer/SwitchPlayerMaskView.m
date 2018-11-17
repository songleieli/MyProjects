//
//  CLPlayerMaskView.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2017/2/24.
//  Copyright © 2017年 JmoVxia. All rights reserved.
//

#import "SwitchPlayerMaskView.h"
#import "CLSlider.h"
#import "Masonry.h"


@interface SwitchPlayerMaskView ()



@end

@implementation SwitchPlayerMaskView

#pragma mark ------------UI元素----------------

- (UIButton *) backButton{
    if (_backButton == nil){
        _backButton = [[UIButton alloc] init];
        _backButton.size = [UIView getSize_width:40 height:40];
        _backButton.origin = [UIView getPoint_x:20 y:35];
        [_backButton setImage:[self getPictureWithName:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIImageView *) imageViewUser{
    if (_imageViewUser == nil){
        _imageViewUser = [[UIImageView alloc] init];
        _imageViewUser.size =  [UIView getScaleSize_width:40 height:40]; //[UIView getSize_width:50 height:50];
        _imageViewUser.origin = [UIView getPoint_x:self.width-_imageViewUser.width - 15
                             y:(self.height-_imageViewUser.height)/2 - 60];
        [_imageViewUser sd_setImageWithURL:[NSURL URLWithString:_listLoginModel.head] placeholderImage:[self getPictureWithName:@"user_default_icon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"error 是%ld",(long)error.code);
        }];
        
        //圆角
        CALayer * imageViewLayer = [_imageViewUser layer];
        [imageViewLayer setMasksToBounds:YES];
        [imageViewLayer setCornerRadius:_imageViewUser.width/2];
        _imageViewUser.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewUserAction)];
        [_imageViewUser addGestureRecognizer:tap];
    }
    return _imageViewUser;
}

- (UIButton *)btnZan{
    if (_btnZan == nil){
        _btnZan = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat scal = (CGFloat)112/96; //原图尺寸
        _btnZan.size = [UIView getSize_width:30 height:30/scal];
        _btnZan.origin = [UIView getPoint_x:_imageViewUser.left + (_imageViewUser.width - _btnZan.width)/2
                                                 y:_imageViewUser.bottom + Video_Btn_space + 3];
        [_btnZan setBackgroundImage:[self getPictureWithName:@"video_like_normal"] forState:UIControlStateNormal];
        [_btnZan setBackgroundImage:[self getPictureWithName:@"video_like_hightlight"] forState:UIControlStateHighlighted];
        [_btnZan setBackgroundImage:[self getPictureWithName:@"video_like_hightlight"] forState:UIControlStateSelected];
        [_btnZan addTarget:self action:@selector(zanButtonAction:) forControlEvents:UIControlEventTouchUpInside];

//        if (_listLoginModel.praiseFlag == YES) {
//            [_btnZan setSelected:YES];
//
//        }else{
//            [_btnZan setSelected:NO];
//        }
    }
    return _btnZan;
}

- (UILabel *)lableZanCount{
    if (_lableZanCount == nil){
        _lableZanCount = [[UILabel alloc] init];
        
        
        _lableZanCount.size = [UIView getSize_width:60 height:19];
        _lableZanCount.origin = [UIView getPoint_x:_btnZan.left + (_btnZan.width - _lableZanCount.width)/2
                                          y:_btnZan.bottom];
//        _lableZanCount.text = [NSString stringWithFormat:@"%@",_listLoginModel.praiseNum];
        _lableZanCount.textColor = [UIColor whiteColor];
        _lableZanCount.textAlignment = NSTextAlignmentCenter;
        _lableZanCount.font = [UIFont defaultFontWithSize:14];
        
        //test
        //_lableZanCount.backgroundColor = [UIColor redColor];
    }
    return _lableZanCount;
}

- (UIButton *)btnComment{
    if (_btnComment == nil){
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat scal = (CGFloat)112/96; //原图尺寸
        _btnComment.size = [UIView getSize_width:30 height:30/scal];
        _btnComment.origin = [UIView getPoint_x:_imageViewUser.left + (_imageViewUser.width - _btnZan.width)/2
                                          y:_lableZanCount.bottom + Video_Btn_space];
        [_btnComment setBackgroundImage:[self getPictureWithName:@"video_comment"] forState:UIControlStateNormal];
        [_btnComment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnComment;
}

- (UILabel *)lableCommentCount{
    if (_lableCommentCount == nil){
        _lableCommentCount = [[UILabel alloc] init];
        
        
        _lableCommentCount.size = [UIView getSize_width:60 height:19];
        _lableCommentCount.origin = [UIView getPoint_x:_btnZan.left + (_btnComment.width - _lableCommentCount.width)/2
                                                 y:_btnComment.bottom];
//        _lableCommentCount.text = [NSString stringWithFormat:@"%@",_listLoginModel.commentNum];
        _lableCommentCount.textColor = [UIColor whiteColor];
        _lableCommentCount.textAlignment = NSTextAlignmentCenter;
        _lableCommentCount.font = [UIFont defaultFontWithSize:14];
    }
    return _lableCommentCount;
}

- (UIButton *)btnView{
    if (_btnView == nil){
        _btnView = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat scal = (CGFloat)112/72; //原图尺寸
        _btnView.size = [UIView getSize_width:30 height:30/scal];
        _btnView.origin = [UIView getPoint_x:_imageViewUser.left + (_imageViewUser.width - _btnView.width)/2
                                              y:_lableCommentCount.bottom + Video_Btn_space];
        [_btnView setBackgroundImage:[self getPictureWithName:@"video_view"] forState:UIControlStateNormal];
    }
    return _btnView;
}

- (UILabel *)lableViewCount{
    if (_lableViewCount == nil){
        _lableViewCount = [[UILabel alloc] init];
        
        
        _lableViewCount.size = [UIView getSize_width:60 height:19];
        _lableViewCount.origin = [UIView getPoint_x:_btnZan.left + (_btnView.width - _lableViewCount.width)/2
                                                     y:_btnView.bottom];
//        _lableViewCount.text = [NSString stringWithFormat:@"%@",_listLoginModel.viewTimes];
        _lableViewCount.textColor = [UIColor whiteColor];
        _lableViewCount.textAlignment = NSTextAlignmentCenter;
        _lableViewCount.font = [UIFont defaultFontWithSize:14];
    }
    return _lableViewCount;
}




- (UILabel *)lableVideoContent{
    if (_lableVideoContent == nil){
        _lableVideoContent = [[UILabel alloc] init];
        _lableVideoContent.font = [UIFont defaultFontWithSize:15];
        _lableVideoContent.size = [UIView getSize_width:ScreenWidth - 30 height:10];
        
//        CGRect contentLabelSize = [_listLoginModel.topicContent boundingRectWithSize:CGSizeMake(_lableVideoContent.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:_lableVideoContent.font,NSFontAttributeName, nil] context:nil];
        
//        _lableVideoContent.height = contentLabelSize.size.height;
        _lableVideoContent.top = self.height - _lableVideoContent.height - Video_Btn_space;
        _lableVideoContent.left = 15;
//        _lableVideoContent.text = _listLoginModel.topicContent;
        _lableVideoContent.textColor = [UIColor whiteColor];
        _lableVideoContent.textAlignment = NSTextAlignmentLeft;
        _lableVideoContent.numberOfLines = 0;
        //test
//        _lableVideoContent.backgroundColor = RGBAlphaColor(0, 0, 0, 0.3);
    }
    return _lableVideoContent;
}

- (UILabel *)lablePublisher{
    if (_lablePublisher == nil){
        _lablePublisher = [[UILabel alloc] init];
        
        _lablePublisher.size = [UIView getSize_width:_lableVideoContent.width height:19];
        _lablePublisher.origin = [UIView getPoint_x:_lableVideoContent.left
                                                  y:_lableVideoContent.top - _lablePublisher.height];
//        _lablePublisher.text = [NSString stringWithFormat:@"@%@",_listLoginModel.publisher];
        _lablePublisher.textColor = [UIColor whiteColor];
        _lablePublisher.textAlignment = NSTextAlignmentLeft;
        _lablePublisher.font = [UIFont defaultBoldFontWithSize:16];
    }
    return _lablePublisher;
}


- (UIImageView *) imageViewbg{
    if (_imageViewbg == nil){
        _imageViewbg = [[UIImageView alloc] init];
        _imageViewbg.size =  [UIView getScaleSize_width:self.width
                                                 height:_lableVideoContent.height+_lablePublisher.height+3*Video_Btn_space];
        _imageViewbg.origin = [UIView getPoint_x:0 y:self.height - _imageViewbg.height];
        _imageViewbg.image = [self getPictureWithName:@"video_background"];
        _imageViewbg.contentMode = UIViewContentModeScaleToFill;
        
        //test
//        _imageViewbg.backgroundColor = [UIColor redColor];
    }
    return _imageViewbg;
}

- (UIButton *) btnPlay{
    if (_btnPlay == nil){
        _btnPlay = [[UIButton alloc] init];
        _btnPlay.size = [UIView getSize_width:50 height:50];
        _btnPlay.origin = [UIView getPoint_x:(self.width - _btnPlay.width)/2
                                              y:(self.height - _btnPlay.height)/2];
        [_btnPlay setImage:[self getPictureWithName:@"video_play"] forState:UIControlStateNormal];
        [_btnPlay addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPlay;
}

-(void)setListLoginModel:(HomeListModel *)listLoginModel{
    _listLoginModel = listLoginModel;
    
//    if (_listLoginModel.praiseFlag == YES) {
//        [_btnZan setSelected:YES];
//    }else{
//        [_btnZan setSelected:NO];
//    }
//    _lableZanCount.text = [NSString stringWithFormat:@"%@",_listLoginModel.praiseNum];
}


-(instancetype)initWithFrame:(CGRect)frame listLoginModel:(HomeListModel *)listLoginModel{
    if (self = [super initWithFrame:frame]) {
        self.listLoginModel = listLoginModel;
        [self initViews];
    }
    return self;
}
- (void)initViews{
    
    [self addSubview:self.backButton];
    [self addSubview:self.imageViewUser];
    [self addSubview:self.btnZan];
    [self addSubview:self.lableZanCount];
    [self addSubview:self.btnComment];
    [self addSubview:self.lableCommentCount];
    [self addSubview:self.btnView];
    [self addSubview:self.lableViewCount];
    [self addSubview:self.btnPlay];
    
    
    [self addSubview:self.lableVideoContent];
    [self addSubview:self.lablePublisher];
    
    [self addSubview:self.imageViewbg];
    [self bringSubviewToFront:self.lableVideoContent];
    [self bringSubviewToFront:self.lablePublisher];

}

#pragma mark - 自定义方法
-(void)showPlayBtn{
    self.btnPlay.hidden = NO;
}

-(void)hidePlayBtn{
    self.btnPlay.hidden = YES;
}

#pragma mark - 按钮点击事件
//返回按钮
- (void)backButtonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(backButtonAction:)]) {
        [_delegate backButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

//播放按钮
- (void)playButtonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(playButtonAction:)]) {
        [_delegate playButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

//点赞按钮
- (void)zanButtonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(zanButtonAction:)]) {
        [_delegate zanButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

// 点击头像
- (void)imageViewUserAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(userInfoAction)]) {
        [_delegate userInfoAction];
    }
}
// 评论
- (void)commentClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(commentAction)]) {
        [_delegate commentAction];
    }
}
#pragma mark - 获取资源图片
- (UIImage *)getPictureWithName:(NSString *)name{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"SwitchPlayer" ofType:@"bundle"]];
    NSString *path   = [bundle pathForResource:name ofType:@"png"];
    return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
