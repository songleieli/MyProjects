//
//  NewProjectView.m
//  JrLoanMobile
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 Junrongdai. All rights reserved.
//

#import "XLGCBodyView.h"
#import "UIButton+Create.h"


@implementation GCItemModel

@end


@interface XLGCBodyView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imgIcon;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSArray *source;

//@property (copy,   nonatomic) void(^finish)(ModelProjectProjectList *);

@end

@implementation XLGCBodyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)reloadWithSource:(NSArray*)source{
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
    CGFloat with = self.width/rowCount; //正方形，高等于宽
    CGFloat scal = (CGFloat)187/142; //宽高比
    CGFloat height = (CGFloat)with/scal; //正方形，高等于宽

    self.height = height*row;
    
    for(int i=0; i<row;i++){
        for(int j=0;j<rowCount;j++){
            
            NSInteger index = i*rowCount+j;
            UIButton *btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
            btnSub.tag = i*rowCount+j;
            btnSub.size = [UIView getSize_width:with height:height];
            btnSub.origin = [UIView getPoint_x:j*with y:i*height];
            btnSub.layer.borderWidth = 0.25;
//            btnSub.layer.borderWidth = 0.0;
            btnSub.layer.borderColor = defaultLineColor.CGColor;
            [self addSubview:btnSub];
            
            if(index < self.source.count){
                
                [btnSub setBackgroundColor:RGBAlphaColor(239, 239, 243, 1) forState:UIControlStateHighlighted];
                [btnSub addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                GCItemModel *model = [self.source objectAtIndex:index];
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.size = [UIView getScaleSize_width:32 height:32];
                imageView.origin = [UIView getPoint_x:(btnSub.width - imageView.width)/2
                                                    y:(btnSub.height - imageView.height)/2 - 30];
                imageView.image = [BundleUtil getCurrentBundleImageByName:model.itemIcon];
                [btnSub addSubview:imageView];
                
                UILabel *lableFunctionTitle = [[UILabel alloc] init];
                lableFunctionTitle.size = [UIView getSize_width:btnSub.width height:sizeScale(20)];
                lableFunctionTitle.origin = [UIView getPoint_x:0 y:imageView.bottom + 5];
                lableFunctionTitle.textAlignment = NSTextAlignmentCenter;
                lableFunctionTitle.textColor = XLColorMainLableAndTitle;
                lableFunctionTitle.font = [UIFont defaultFontWithSize:16];
                lableFunctionTitle.text = model.itemTitle;
                [btnSub addSubview:lableFunctionTitle];

                
                UILabel *lableFunctionContent = [[UILabel alloc] init];
                lableFunctionContent.size = [UIView getSize_width:btnSub.width height:sizeScale(20)];
                lableFunctionContent.origin = [UIView getPoint_x:0 y:lableFunctionTitle.bottom + 5];
                lableFunctionContent.textAlignment = NSTextAlignmentCenter;
                lableFunctionContent.textColor = XLColorMainClassTwoTitle;
                lableFunctionContent.font = [UIFont defaultFontWithSize:14];
                lableFunctionContent.text = model.itemContent;
                
                [btnSub addSubview:lableFunctionContent];
            }
        }
    }
}

-(void)btnClick:(UIButton*)btn{
    //self.userInteractionEnabled = NO;
    GCItemModel *item = [self.source objectAtIndex:btn.tag];
    if(self.blockClcik){
        self.blockClcik(item);
    }
}


@end
