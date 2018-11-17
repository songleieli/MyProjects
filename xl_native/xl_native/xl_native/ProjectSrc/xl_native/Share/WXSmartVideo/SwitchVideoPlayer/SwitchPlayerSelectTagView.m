//
//  CLPlayerMaskView.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2017/2/24.
//  Copyright © 2017年 JmoVxia. All rights reserved.
//

#import "SwitchPlayerSelectTagView.h"


@interface SwitchPlayerSelectTagView ()



@end

@implementation SwitchPlayerSelectTagView

#pragma mark -----------懒加载----------------

- (NSMutableArray *)source{
    
    if (!_source) {
        _source = [[NSMutableArray alloc] init];
    }
    return _source;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.size = [UIView getSize_width:self.width height:self.height - 150];
        _scrollView.origin = [UIView getPoint_x:0 y:(self.height-_scrollView.height)/2];
        _scrollView.contentSize = [UIView getSize_width:self.width height:_scrollView.height+1];
    }
    return _scrollView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (void)initViews{
    
    self.backgroundColor = RGBAlphaColor(0, 0, 0, 0.5);
    [self addSubview:self.scrollView];
}

-(void)reloadWithSource:(NSMutableArray*)source selectModel:(FindAllTagDataModel *)selectModel{
    if (source.count == 0) {
        return;
    }
    [self.source removeAllObjects];
    [self.scrollView removeAllSubviews];

    
    self.source = source;
    
    //初始值
    CGFloat with = self.width;
    CGFloat height = 80.0f;
    CGFloat top = 0.0f;
    
    for(int i=0; i<self.source.count;i++){
        
        FindAllTagDataModel *model = [self.source objectAtIndex:i];
        UIButton *btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSub.tag = i;
        btnSub.size = [UIView getSize_width:with height:height];
        btnSub.origin = [UIView getPoint_x:0 y:top];
        btnSub.titleLabel.font = [UIFont defaultBoldFontWithSize:25];
        [btnSub setTitle:model.tagName forState:UIControlStateNormal];
        [btnSub setTitleColor:RGBAlphaColor(255, 255, 255, 0.65) forState:UIControlStateNormal];
        [btnSub setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btnSub setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btnSub addTarget:self action:@selector(selectTagClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btnSub];
        
        if([model.id isEqualToString:selectModel.id]){
            btnSub.selected = YES;
        }
        else{
            btnSub.selected = NO;
        }
        
        top = top+btnSub.height;
    }
    
    self.scrollView.height = top;
    self.scrollView.top = (self.height-self.scrollView.height)/2; //居中
    self.scrollView.contentSize = [UIView getSize_width:self.width height:self.scrollView.height+1]; //可以滑动
}

#pragma mark - 自定义方法


#pragma mark - 按钮点击事件
//返回按钮
- (void)selectTagClick:(UIButton *)button{
    
    
    
    NSArray *subViews = [self.scrollView subviews];
    for(UIButton *btn in subViews){
        btn.selected = NO;
    }
    button.selected = YES;
    
    
    
    
    FindAllTagDataModel *item = [self.source objectAtIndex:button.tag];
    if(self.selectBlockClcik){
        self.selectBlockClcik(item);
    }
}


@end
