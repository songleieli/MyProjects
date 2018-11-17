//
//  TopicCell.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/26.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "TopicCell.h"

#import "UIView+SDAutoLayout.h"
#import "Network_topicViewNoLogin.h"
#import "Network_topicViewLogin.h"
#import "TZImagePickerController.h"
#import "SDPhotoBrowser.h"
#import "ImageButton.h"

@interface TopicCell ()<UICollectionViewDataSource,UICollectionViewDelegate,YBAttributeTapActionDelegate,
                        TZImagePickerControllerDelegate,SDPhotoBrowserDelegate>{
                            
}

@property(nonatomic,strong)UIView * viewTopBg;
@property(nonatomic,strong)UIView * viewBottomBg;
@property(nonatomic,strong) NSMutableArray *selectedPhotos;
@property(nonatomic,strong) NSMutableArray *selectedAssets;

@end


@implementation TopicCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)viewBgClick:(UIButton *)btn{
    
    if ([self.clickDelegate respondsToSelector:@selector(clickViewBgDelegate:)]) {
        [self.clickDelegate clickViewBgDelegate:_listLoginModel];
    }
}

- (void)initUI {
    self.contentView.backgroundColor = RGBFromColor(0xf0f0f0);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //白色背景
    self.viewBg = [[UIButton alloc]init];
    self.viewBg.size = [UIView getSize_width:ScreenWidth height:20];
    self.viewBg.origin = [UIView getPoint_x:0 y:0];
//    self.viewBg.layer.borderWidth = 0.5;
    self.viewBg.backgroundColor = [UIColor whiteColor];
    [self.viewBg setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewBg setBackgroundColor:defaultLineColor forState:UIControlStateHighlighted];
    [self.viewBg addTarget:self action:@selector(viewBgClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.viewBg.layer.borderColor = defaultLineColor.CGColor;
    [self.contentView addSubview:self.viewBg];
    
    //上面固定的头像的View;
    self.viewTopBg = [[UIView alloc]init];
    self.viewTopBg.backgroundColor = [UIColor clearColor];
    self.viewTopBg.userInteractionEnabled = NO;
    self.viewTopBg.width  = ScreenWidth;
    self.viewTopBg.height = 68;
    self.viewTopBg.left = 0;
    self.viewTopBg.top=0;
    [self.viewBg addSubview:self.viewTopBg];
    
    /** 头像 */
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];//[[UIImageView alloc] init];
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.layer.cornerRadius = 16;
    self.iconBtn.size = [UIView getSize_width:32 height:32];
    self.iconBtn.left = 21;
    self.iconBtn.top =21;
    [self.iconBtn addTarget:self action:@selector(userIconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.iconBtn]; //iconBtn需要添加到 contentView 中，添加到 self.viewTopBg 中不响应事件
    
    /** 名字 */
    self.nameLable = [UILabel new];
    self.nameLable.font = [UIFont defaultFontWithSize:17];
    self.nameLable.textColor = RGBFromColor(0x464952);
    self.nameLable.left = self.iconBtn.right +16;
    self.nameLable.top = 21;
    self.nameLable.height = 20;
    [self.viewTopBg addSubview:self.nameLable];

    /** 时间 */
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = RGBFromColor(0xaaaaaa);
    self.timeLabel.left = self.nameLable.left;
    self.timeLabel.top = self.nameLable.bottom+8;
    self.timeLabel.height= 12;
    [self.viewTopBg addSubview:self.timeLabel];
    
    /** 位置 */
    self.locationLabel = [[UILabel alloc]init];
    self.locationLabel.font = [UIFont systemFontOfSize:12];
    self.locationLabel.textColor = RGBFromColor(0xaaaaaa);
    self.locationLabel.top = self.timeLabel.top;
    self.locationLabel.height = self.timeLabel.height;
    self.locationLabel.textColor = RGBFromColor(0xaaaaaa);
    [self.viewTopBg addSubview:self.locationLabel];
    
    
    /** 内容 */
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [UIFont defaultFontWithSize:14];
    self.contentLabel.textColor = RGBFromColor(0x777777);
    [self.viewBg addSubview:self.contentLabel];
    
    /*
     *CollictionView，支持多张图片
     */
    self.layout = [[LxGridViewFlowLayout alloc] init];
    self.margin = 4;
    self.colCount = 3;
    
    CGFloat labelContectW = ScreenWidth - 91;
    self.itemWH = ((labelContectW -
                    2*self.margin -
                    (self.colCount - 1)*2*self.margin))/self.colCount;
    
    self.layout.minimumInteritemSpacing = self.margin;
    self.layout.minimumLineSpacing = self.margin;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,0, 0) collectionViewLayout:self.layout];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    self.collectionView.userInteractionEnabled = YES;
    self.collectionView.delaysContentTouches = YES;
    [self.viewBg addSubview:self.collectionView];
    
    self.maskView = [[UIView alloc] init];
    [self.viewTopBg addSubview:self.maskView];
    
    // viewBottomBg
    self.viewBottomBg = [[UIView alloc]init];
    self.viewBottomBg.backgroundColor = [UIColor clearColor];
    self.viewBottomBg.top = 10 ;
    self.viewBottomBg.width =110;
    self.viewBottomBg.left = ScreenWidth - self.viewBottomBg.width;
    self.viewBottomBg.height = 50;
    [self.viewBg addSubview:self.viewBottomBg];
    
    /** 评论文字 */
    self.commentLabel = [[UILabel alloc]init];
    self.commentLabel.font = [UIFont systemFontOfSize:12];
    self.commentLabel.textColor = RGBFromColor(0x888a91);
    self.commentLabel.size = [UIView getSize_width:30 height:14];
    self.commentLabel.left = self.viewBottomBg.width - self.commentLabel.width;
    self.commentLabel.top = (self.viewBottomBg.height - self.commentLabel.height)/2  - MasScale_1080(30);
    self.commentLabel.textAlignment = NSTextAlignmentLeft;
    [self.viewBottomBg addSubview:self.commentLabel];
    
    /** 评论按钮 */
    UIImage * commentImage = [UIImage imageNamed:@"neighbour_comment"];
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:commentImage forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.commentBtn.size = [UIView getSize_width:15 height:16];
    self.commentBtn.left = self.commentLabel.left -self.commentBtn.width - 5;
    self.commentBtn.top = self.commentLabel.top-1;
    [self.viewBottomBg addSubview:self.commentBtn];
    
    self.commentBigBtn = [[UIButton alloc] init];
    self.commentBigBtn.left = self.commentBtn.left;
    self.commentBigBtn.top = self.commentBtn.top;
    self.commentBigBtn.size = [UIView getSize_width:45 height:16];
    [self.commentBigBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBottomBg addSubview:self.commentBigBtn];
    
    
    /** 赞文字 */
    self.zanLabel = [UILabel new];
    self.zanLabel.font = [UIFont systemFontOfSize:12];
    self.zanLabel.textColor = RGBFromColor(0x888a91);
    self.zanLabel.text = @"456";
    self.zanLabel.size = [UIView getSize_width:30 height:14];
    self.zanLabel.top = self.commentLabel.top;
    self.zanLabel.left = self.commentBtn.left - self.zanLabel.width;
    [self.viewBottomBg addSubview:self.zanLabel];
    
    
    /** 赞按钮 */
    self.zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zanBtn.size = [UIView getSize_width:16 height:16];
    self.zanBtn.top =self.commentBtn.top;
    self.zanBtn.left = self.zanLabel.left - self.zanBtn.width - 5;
    [self.viewBottomBg addSubview:self.zanBtn];
    
    self.zanBigBtn = [[UIButton alloc] init];
    self.zanBigBtn.left = self.zanBtn.left;
    self.zanBigBtn.top = self.zanBtn.top;
    self.zanBigBtn.size = [UIView getSize_width:45 height:16];
    [self.zanBigBtn addTarget:self action:@selector(zanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBottomBg addSubview:self.zanBigBtn];
}

#pragma -mark  ------  加载Model  ----------

//已登录列表
-(void)setListLoginModel:(ListLoginModel *)listLoginModel{
    
    _listLoginModel = listLoginModel;
    
    self.viewBg.height = listLoginModel.heightCell -12;
    self.viewTopBg.height = listLoginModel.heightBgTopBgView;
    self.viewBottomBg.height = listLoginModel.heightBgBottomView;
    
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:listLoginModel.userIcon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"actitvtiyDefout"]];
    
    if ([listLoginModel.publisher isEqualToString:@""]) {
        self.nameLable.text = @"暂无昵称";
        
    }else{
        self.nameLable.text = listLoginModel.publisher;
    }
    
    self.nameLable.width = listLoginModel.labelContectW;
    self.timeLabel.text = listLoginModel.showTime;
    self.timeLabel.width = listLoginModel.timelabelContectW;
    
    if ([self.locationLabel.text isEqualToString:@""]) {
        self.locationLabel.hidden = YES;
    }else{
        self.locationLabel.hidden = NO;
        self.locationLabel.text = listLoginModel.communityName;
        
        self.locationLabel.width =listLoginModel.locationlabelContectW;
        self.locationLabel.left = self.timeLabel.right + 10;
    }
    
    if (listLoginModel.topicContent.length > 0) {
        
        self.contentLabel.numberOfLines =0;
        self.contentLabel.top = self.viewTopBg.bottom;
        self.contentLabel.left = 70 ;
        self.contentLabel.size = [UIView getSize_width:listLoginModel.widthContentLable height:listLoginModel.heightContentLable];
        
        //新添加按标签，显示群组功能
        if(listLoginModel.typeName.length > 0){
            
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:listLoginModel.topicContent];
            [attributed addAttribute:NSFontAttributeName
                               value:self.contentLabel.font
                               range:NSMakeRange(0,listLoginModel.topicContent.length)]; //设置字体大小
            [attributed addAttribute:NSForegroundColorAttributeName
                               value:XLColorMainPart
                               range:NSMakeRange(0,listLoginModel.typeName.length+2)];//设置颜色标签颜色
            [attributed addAttribute:NSForegroundColorAttributeName
                               value:XLColorMainLableAndTitle
                               range:NSMakeRange(listLoginModel.typeName.length+2,listLoginModel.topicContent.length-listLoginModel.typeName.length-2 )];//设置内容颜色
            
            self.contentLabel.attributedText = attributed;
            [self.contentLabel yb_addAttributeTapActionWithStrings:@[[NSString stringWithFormat:@"#%@#",listLoginModel.typeName]] delegate:self];
        }
        else{
            self.contentLabel.text  = listLoginModel.topicContent;
        }
        
    }else{
        self.contentLabel.height = 0;
    }
    
    // 图片
    if (listLoginModel.medias.count > 0) {
        
        self.collectionView.top = self.contentLabel.bottom + listLoginModel.marginOne;
        self.collectionView.left = self.contentLabel.left;
        self.collectionView.height = listLoginModel.heightColloctionView;
        if (listLoginModel.medias.count == 4) {
            self.collectionView.width = listLoginModel.widthFourColloctionView;
        }
        else{
            self.collectionView.width = listLoginModel.widthColloctionView;
        }
        if (listLoginModel.medias.count == 1) {
            self.layout.itemSize = CGSizeMake(listLoginModel.widthOneImg, listLoginModel.heightForOneImage);
        }else{
            self.layout.itemSize = CGSizeMake(self.itemWH, self.itemWH);
        }
        self.maskView.top = self.contentLabel.bottom + listLoginModel.marginOne;
        self.maskView.left = self.contentLabel.left;
        self.maskView.height = listLoginModel.heightColloctionView;
        self.maskView.width = listLoginModel.widthColloctionView;
        
        self.viewBottomBg.top = self.collectionView.bottom;
        [self.collectionView reloadData];
    }
    else{
        self.collectionView.height = 0;
        self.maskView.height = 0;
        self.viewBottomBg.top = self.contentLabel.bottom;
    }
    
    //底部的View
    self.zanLabel.text = [listLoginModel.praiseNum stringValue];
    self.commentLabel.text = [listLoginModel.commentNum stringValue];
    
    if (listLoginModel.praiseFlag == YES) {
        [self.zanBtn setImage:[UIImage imageNamed:@"neighbour_zan_selected"] forState:UIControlStateNormal];
    }else{
        [self.zanBtn setImage:[UIImage imageNamed:@"neighbour_zan_normal"] forState:UIControlStateNormal];
    }
}


#pragma -mark  ------  按钮点击事件  ----------


//点赞
-(void)zanBtnClick:(UIButton *)btn{
    
    if ([self.clickDelegate respondsToSelector:@selector(clickPraiseDelegate:andCell:)]) {
        [self.clickDelegate clickPraiseDelegate:self.listLoginModel.id andCell:self];
    }
}

//点击用户头像
-(void)userIconBtnClick:(UIButton *)btn{
    
    if ([self.clickDelegate respondsToSelector:@selector(clickUserIcon:)]) {
        [self.clickDelegate clickUserIcon:self.listLoginModel];
    }
}

-(void)commentBtnClick:(UIButton *)btn{
    
    if ([self.clickDelegate respondsToSelector:@selector(clickCommentDelegate:)]) {
        [self.clickDelegate clickCommentDelegate:self.listLoginModel];
    }
}

//预览图片和播放视频
- (void)btnClick:(ImageButton  *)btn{
    
    if([_listLoginModel.topicType.trim isEqualToString:@"video"]){ //播放视频
        
        if ([self.clickDelegate respondsToSelector:@selector(clickPlayVedio:)]) {
            [self.clickDelegate clickPlayVedio:self.listLoginModel];
        }
    }
    else{ //预览图片
        
        _imageArr = [NSMutableArray arrayWithCapacity:0];
        for (ImagesLoginModel *image in _listLoginModel.medias) {
            [_imageArr addObject:image.url];
        }
        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = btn.indexPath.row ;
        photoBrowser.imageCount = _imageArr.count;
        photoBrowser.sourceImagesContainerView = self.maskView;
        [photoBrowser show];
    }
}

#pragma mark --------- UICollectionView -----------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _listLoginModel.medias.count;
}


//完善加载图片动画
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;{
    
    TZTestCell *cell =(TZTestCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell.imageView.image;
}

-(NSURL*)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    return [NSURL URLWithString:_imageArr[index]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    ImagesLoginModel *imageModel = _listLoginModel.medias[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.breviaryUrl.trim]
                      placeholderImage:[UIImage imageNamed:@"neighborhood_defuot"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { }];
    cell.deleteBtn.hidden = YES;
    
    ImageButton *  _btn = [ImageButton buttonWithType:UIButtonTypeSystem];
    _btn.center = CGPointMake(self.collectionView.origin.x + cell.center.x, self.collectionView.origin.y + cell.center.y);
    _btn.bounds = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    [_btn setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    
    if([_listLoginModel.topicType.trim isEqualToString:@"video"]){ //如果该条记录是视频，添加视频播放按钮。
        
        UIImageView *imageViewPlay = [[UIImageView alloc] init];
        imageViewPlay.size = [UIView getSize_width:30 height:30];
        imageViewPlay.origin = [UIView getPoint_x:(_btn.width-imageViewPlay.width)/2
                                                y:(_btn.height-imageViewPlay.height)/2];
        imageViewPlay.image = [UIImage imageNamed:@"video_play"];
        [_btn addSubview:imageViewPlay];
        
    }
    
    _btn.indexPath = indexPath;
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btn];
    
    ButtonMaskView *view = [[ButtonMaskView alloc]init];
    view.bounds = cell.bounds;
    view.center = cell.center;
    [self.maskView addSubview:view];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= _listLoginModel.medias.count || destinationIndexPath.item >= _listLoginModel.medias.count) return;
    UIImage *image = _listLoginModel.medias[sourceIndexPath.item];
    if (image) {
        [_listLoginModel.medias exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_listLoginModel.medias exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    }
}


- (void)yb_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index{
    if ([self.clickDelegate respondsToSelector:@selector(clickTag:)]) {
        [self.clickDelegate clickTag:self.listLoginModel];
    }
}

@end
