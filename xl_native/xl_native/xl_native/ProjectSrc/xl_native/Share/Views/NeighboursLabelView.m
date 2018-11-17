//
//  NeighboursLabelView.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/8/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NeighboursLabelView.h"

@implementation LableModel


@end


@interface NeighboursLabelView()


@property (nonatomic, strong)UIButton *doneBtn;//完成按钮
@property (nonatomic ,strong)NSMutableArray *dataSource; //数据源
@property (nonatomic ,strong)NSMutableArray *selectArray; //选择的tag

@end

@implementation NeighboursLabelView


- (UIView *)doneBtn{
    
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.size = [UIView getSize_width:40 height:30];
        _doneBtn.top = 10;
        _doneBtn.left = self.width - _doneBtn.width -15;
        _doneBtn.titleLabel.font=[UIFont defaultFontWithSize:16];
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_doneBtn setTitleColor:RGBFromColor(0xfd6f00) forState:UIControlStateHighlighted];
        [_doneBtn addTarget:self action:@selector(btnDoneClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


- (NSMutableArray *)selectArray{

    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = RGBFromColor(0xf2f2f2);
    }
    return self;
}


#pragma mark - 加载数据

-(void)dataBind:(NSMutableArray*)dataSource{
    if (dataSource.count == 0) {
        return;
    }
    
    [self.selectArray removeAllObjects];
    self.dataSource = dataSource;
    [self removeAllSubviews];

    [self addSubview:self.doneBtn];
    
    CGFloat top = 15.0f; //初始top位置
    CGFloat titleHeight = 30.0f;
    CGFloat lableHeight = 40.0f;
    
    
    //for(LableModel *model in self.dataSource){
    for(int m=0; m<self.dataSource.count;m++){

        LableModel *model = [self.dataSource objectAtIndex:m];
        
        CGRect frame = CGRectMake(15, top, self.width-150, titleHeight);
        UILabel *titleLalbe = [[UILabel alloc]initWithFrame:frame];
        titleLalbe.font = [UIFont defaultFontWithSize:16];
        titleLalbe.textColor = RGBFromColor(0x9b9b9b);
        titleLalbe.text = model.title;
        [self addSubview:titleLalbe];
        
        NSInteger rowCount = 4; //每行显示按钮个数
        NSInteger modular = model.lables.count%rowCount;
        NSInteger row = model.lables.count/rowCount;
        
        if(modular > 0){
            row = row+1;
        }
        frame = CGRectMake(0, titleLalbe.bottom, self.width, lableHeight*row);
        UIView *viewBody = [[UIView alloc] initWithFrame:frame];
        viewBody.tag = m;
        
        for(int i=0; i<row;i++){
            for(int j=0;j<rowCount;j++){
                
                NSInteger index = i*rowCount+j;
                if(index >= model.lables.count){ //多余的按钮不显示
                    continue;
                }
                
                FindAllTagDataModel *tagModel = [model.lables objectAtIndex:index];
                CGFloat with = viewBody.width/rowCount; //正方形，高等于宽
                CGFloat height = viewBody.height/row; //正方形，高等于宽
                
                UIView *viewSub = [[UIView alloc] init];
                viewSub.size = [UIView getSize_width:with height:height];
                viewSub.origin = [UIView getPoint_x:j*with y:i*height];
                [viewBody addSubview:viewSub];
//                //test 调试需要保留
//                viewSub.layer.borderWidth = 0.5;
//                viewSub.layer.borderColor = defaultLineColor.CGColor;
                
                //button的宽和高
                CGFloat withBtn = 70;
                CGFloat heightBtn = 32;
                
                UIButton *btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
                btnSub.tag = index;
                btnSub.size = [UIView getSize_width:withBtn height:heightBtn];
                btnSub.origin = [UIView getPoint_x:(viewSub.width-btnSub.width)/2
                                                 y:(viewSub.height-btnSub.height)/2]; //居中
                btnSub.titleLabel.font=[UIFont defaultFontWithSize:12];
                [btnSub setTitle:tagModel.tagName forState:UIControlStateNormal];
                [btnSub setTitleColor:RGBFromColor(0x9b9b9b) forState:UIControlStateNormal];
                [btnSub setTitleColor:RGBFromColor(0xfd6f00) forState:UIControlStateHighlighted];
                [btnSub setTitleColor:RGBFromColor(0xfd6f00) forState:UIControlStateSelected];
                btnSub.titleLabel.lineBreakMode = NSLineBreakByCharWrapping; //UIButton 文字换行显示
                [btnSub addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btnSub.backgroundColor = RGBFromColor(0xe7e7e7);
                btnSub.layer.masksToBounds = YES;
                btnSub.layer.cornerRadius = MasScale_1080(10);
                
                if(tagModel.isSelected){
                    btnSub.selected = YES;
                    [self.selectArray addObject:tagModel];
                }
                else{
                    btnSub.selected = NO;
                }
                
                [viewSub addSubview:btnSub];
            }
        }
        [self addSubview:viewBody];
        //下一个类别的top
        top = viewBody.bottom;
    }
    self.height = top+15; //15是为下步预留区域
    
}

-(void)btnClick:(UIButton*)btn{
    
    if(btn.selected){
        return; //如果当前按钮已选择，直接返回。
    }
    
    UIView *bodyView = [[btn superview] superview];
    NSArray *subViews = bodyView.subviews;

    //取消选择
    for(UIView *viewSub in subViews){//设置所有的按钮未选择
        UIButton *btnSub = [[viewSub subviews] objectAtIndex:0];
        btnSub.selected = NO;
    }
    btn.selected = !btn.selected; //选择当前
    
    
    LableModel *lableModel = [self.dataSource objectAtIndex:bodyView.tag]; //[model.lables objectAtIndex:index];
    FindAllTagDataModel *tagModel = [lableModel.lables objectAtIndex:btn.tag];
    
    [self.selectArray replaceObjectAtIndex:bodyView.tag withObject:tagModel];
    
    
    NSLog(@"-------");
}

-(void)btnDoneClick:(UIButton*)btn{
    
//    UIView *bodyView = [[btn superview] superview];
    
    //模仿 NSIndexPath 的写法，传递两个数值参数
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bodyView.tag inSection:btn.tag];
    
    if (self.selectCollectionIndexPath) {
        self.selectCollectionIndexPath(self.selectArray);
    }
}



@end
