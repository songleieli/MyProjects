//
//  NewProjectView.m
//  JrLoanMobile
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 Junrongdai. All rights reserved.
//

#import "XLHomeFunctionView.h"
#import "UIButton+Create.h"


//@implementation XLFunctionItemModel
//
//@end


@interface XLHomeFunctionView () <UIScrollViewDelegate>

//@property (strong, nonatomic) UIScrollView *scrolNew;
@property (strong, nonatomic) UIImageView *imgIcon;
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) NSArray *source;

//@property (copy,   nonatomic) void(^finish)(ModelProjectProjectList *);

@end

@implementation XLHomeFunctionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor whiteColor];
        
        //初始化代码，写这里
    }
    
    return self;
}


-(void)reloadWithSource:(NSArray*)source dataLoadFinishBlock:(void(^)())dataLoadFinishBlock{
    if (source.count == 0) {
        return;
    }
    
    self.source = source;
    [self removeAllSubviews];
    
    NSInteger rowCount = 2;
    NSInteger modular = self.source.count%rowCount;
    NSInteger row = self.source.count/rowCount;
    
    if(modular > 0){
        row = row+1;
    }
    
    //计算当前页的高度
    CGFloat scalwh = (CGFloat)171.5/273;//宽高比
    CGFloat with = (CGFloat)self.width/rowCount; //正方形，高等于宽
    CGFloat height = (CGFloat)with/scalwh; //正方形，高等于宽
    
    self.height = height*row;
    
    for(int i=0; i<row;i++){
        for(int j=0;j<rowCount;j++){
            
            NSInteger index = i*rowCount+j;
            UIView *btnSub = [[UIView alloc] init];//[UIButton buttonWithType:UIButtonTypeCustom];
            btnSub.tag = index;
            btnSub.size = [UIView getSize_width:with height:height];
            btnSub.origin = [UIView getPoint_x:j*with y:i*height];
            //btnSub.layer.borderWidth = 0.25;
//            btnSub.layer.borderWidth = 1.0;
//            btnSub.layer.borderColor = defaultLineColor.CGColor;
            [self addSubview:btnSub];
            
            if(index < self.source.count){
                ListLoginModel *model = [self.source objectAtIndex:index];
                
                //背景带阴影框
                UIView *viewSubBg = [[UIView alloc] init];
                viewSubBg.tag = index;
                viewSubBg.size = [UIView getSize_width:with-sizeScale(15) height:height-sizeScale(15)];
                //调整位置
                CGFloat x = (btnSub.width - viewSubBg.width)/2;
                CGFloat y = (btnSub.height - viewSubBg.height)/2;
                CGFloat space = sizeScale(2.5f);
                if(j%2 == 0){ //左侧按钮背景右移7.5,高度居中上移 sizeScale(5)
                    x = x+space;
                    viewSubBg.height = viewSubBg.height+sizeScale(5);
                }
                else{ //右侧按钮背景左移7.5, 高度居中上移 sizeScale(5)
                    x = x-space;
                    viewSubBg.height = viewSubBg.height+sizeScale(5);
                }
                viewSubBg.origin = [UIView getPoint_x:x y:y];
                viewSubBg.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
                viewSubBg.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.16].CGColor;
                viewSubBg.layer.shadowOffset = CGSizeMake(0,2);
                viewSubBg.layer.shadowRadius = 3;
                viewSubBg.layer.shadowOpacity = 1;
                viewSubBg.layer.cornerRadius = 4;
//                viewSubBg.layer.masksToBounds = YES;
                [btnSub addSubview:viewSubBg];
                
                //d缩略图
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.size = [UIView getSize_width:viewSubBg.width height:viewSubBg.width+10];
                imageView.origin = [UIView getPoint_x:0 y:0];
                imageView.contentMode =  UIViewContentModeScaleAspectFill;
                NSString *breviaryStr = @"";
                for(ImagesLoginModel *modelImage in model.medias){
                    breviaryStr = [NSString stringWithFormat:@"%@@thumb.jpg",modelImage.breviaryUrl];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:breviaryStr] placeholderImage:[UIImage imageNamed:@"actitvtiyDefout"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        NSLog(@"error 是%ld",(long)error.code);
                    }];
                }
                imageView.layer.masksToBounds = YES;
                imageView.layer.cornerRadius = 4.0f;
                imageView.userInteractionEnabled = YES;
                [viewSubBg addSubview:imageView];
                
                /*
                 UIButton不能点击情况的第一种是，你将button添加到一个不能响应点击事件的View里。如你将button添加到UIImageView中，解决办法只需将UIImageView的
                 userInteractionEnabled设为YES即可。
                 */
                
                /*播放按钮*/
                UIButton *  _btn = [UIButton buttonWithType:UIButtonTypeSystem];
                _btn.frame = imageView.bounds;
                _btn.tag = index;
                _btn.backgroundColor = [UIColor clearColor];
                [_btn addTarget:self action:@selector(btnPlayClick:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:_btn];
                
                UIImageView *imageViewPlay = [[UIImageView alloc] init];
                imageViewPlay.size = [UIView getSize_width:35 height:35];
                imageViewPlay.origin = [UIView getPoint_x:(_btn.width-imageViewPlay.width)/2
                                                        y:(_btn.height-imageViewPlay.height)/2];
                imageViewPlay.image = [UIImage imageNamed:@"video_play"];
                [_btn addSubview:imageViewPlay];

                //内容
                VUILable *lableTitle = [[VUILable alloc] init];
                lableTitle.size = [UIView getSize_width:viewSubBg.width-20 height:40];
                lableTitle.origin = [UIView getPoint_x:10 y:imageView.bottom+15];
                lableTitle.textAlignment = NSTextAlignmentLeft;
                lableTitle.verticalAlignment = VerticalAlignmentTop;
                lableTitle.textColor = XLColorMainLableAndTitle;
                lableTitle.font = [UIFont defaultFontWithSize:15];
                lableTitle.text = model.topicContent;
                //UILable显示两行文字，多于两行就显示....
                lableTitle.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
                lableTitle.numberOfLines = 2;
                [viewSubBg addSubview:lableTitle];
                
                //test
//                lableTitle.backgroundColor = [UIColor blueColor];
                
                /** 头像 */
                UIImageView *iconView = [UIImageView new];
                iconView.layer.masksToBounds = YES;
                iconView.layer.cornerRadius = 12.5;
                iconView.size = [UIView getSize_width:25 height:25];
                iconView.left = lableTitle.left;
                iconView.top =viewSubBg.height - iconView.height - 15;
                //topbgView
                [iconView sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:[UIImage imageNamed:@"user_default_icon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    NSLog(@"error 是%ld",(long)error.code);
                }];
                
                [viewSubBg addSubview:iconView];
                
                /** 名字 */
                UILabel *nameLable = [UILabel new];
                nameLable.font = [UIFont defaultFontWithSize:12];
                nameLable.size = [UIView getSize_width:60 height:16];
                nameLable.left = iconView.right +5;
                nameLable.top = iconView.top + (iconView.height - nameLable.height)/2;
                nameLable.height = 20;
                nameLable.text = model.publisher;
                nameLable.textAlignment = NSTextAlignmentLeft;
                nameLable.textColor = XLColorMainClassTwoTitle;
                [viewSubBg addSubview:nameLable];
                
                /** 赞文字 */
                UILabel *labelZan = [UILabel new];
                labelZan.tag = 9000+index;
                labelZan.font = [UIFont systemFontOfSize:12];
                labelZan.textColor = XLColorMainClassTwoTitle;
//                labelZan.text = @"456";
                labelZan.textAlignment = NSTextAlignmentCenter;
                labelZan.size = [UIView getSize_width:25 height:16];
                labelZan.top = nameLable.top;
                labelZan.left = viewSubBg.width - labelZan.width;
                labelZan.text = [model.praiseNum stringValue];
                [viewSubBg addSubview:labelZan];
                
                /** 赞按钮 */
                UIButton *btnZan = [UIButton buttonWithType:UIButtonTypeCustom];
                btnZan.tag = index;
                btnZan.size = [UIView getSize_width:16 height:16];
                btnZan.top = labelZan.top;
                btnZan.left = labelZan.left - btnZan.width;
                [btnZan setImage:[UIImage imageNamed:@"neighbour_zan_normal"] forState:UIControlStateNormal];
                [btnZan setImage:[UIImage imageNamed:@"neighbour_zan_selected"] forState:UIControlStateSelected];

                [btnZan addTarget:self action:@selector(btnZanClick:) forControlEvents:UIControlEventTouchUpInside];

                if (model.praiseFlag == YES) {
                    btnZan.selected = YES;
                }else{
                    btnZan.selected = NO;
                }
                
                [viewSubBg addSubview:btnZan];
            }
        }
    }
    
    if(dataLoadFinishBlock){
        dataLoadFinishBlock();
    }
}

-(void)btnPlayClick:(UIButton*)btn{
    ListLoginModel *item = [self.source objectAtIndex:btn.tag];
    if(self.playVideoClcik){
        self.playVideoClcik(item);
    }
}

-(void)btnZanClick:(UIButton*)btn{
    
    UIView *btnSub = [self viewWithTag:btn.tag];
    UIView *viewSubBg = [btnSub viewWithTag:btn.tag];
    UILabel *labelZan = [viewSubBg viewWithTag:9000+btn.tag];
    
    
    ListLoginModel *item = [self.source objectAtIndex:btn.tag];
    if(self.zanClcik){
        self.zanClcik(item,btn,labelZan);
    }
}

@end
