//
//  DeliverArticleViewController.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "DeliverArticleViewController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import "UIView+SDAutoLayout.h"
#import "ClassifyViewController.h"
#import "PulishCell.h"
#import "Network_publishTopic.h"
//#import "FocusCommunityViewController.h"
#import "ZJLoginService.h"
#import "NetWork_uploadApi.h"

#import "LxGridViewFlowLayout.h"
//#import "NetWork_integralAdd.h"//积分
#import "PublishSuccessView.h"//成功的窗口
#import "UIView+TTFramePopupView.h"//第三方




#import "WXSmartVideoView.h"
#import "PlayerViewController.h"

@interface DeliverArticleViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,selectedClassityDelegate,UITextViewDelegate>
{
    
    BOOL _isSelectOriginalPhoto;
    UITextView *speakTextView;
    UILabel * _placeHoldelLebel;
    //    LxGridViewFlowLayout *_layout;
    UICollectionViewFlowLayout * _layout;
    
}
@property(nonatomic,copy) NSString * imageStringUrl;
@property (nonatomic,strong) NSArray * nameArray;
@property (nonatomic,strong) NSArray * categoryArray;
@property(nonatomic,copy)NSString * typeId;
@property(nonatomic,copy) NSString *communityId;

@property(nonatomic,strong) UIImageView * imageViewPublick;
@property(nonatomic, copy) NSString * str;
@property (nonatomic,assign)NSInteger tag;

@property(nonatomic,strong) NSMutableArray *selectedPhotos;
//@property(nonatomic,strong) NSMutableArray *selectedAssets;

@property (nonatomic,strong) UITableView * tableView;

// add by songlei
@property(nonatomic,strong) UIView *viewHead;
@property(nonatomic,strong) UIView *viewTopBg;
@property(nonatomic,strong) UIView *spaceView;
@property(nonatomic,strong) UIView *viewMiddleBg;
@property(nonatomic,strong) UIView *viewBottomBg;


@property (nonatomic,assign) NSInteger itemWH;
@property (nonatomic,assign) NSInteger margin;
@property (nonatomic,assign) NSInteger rowCount;
@property (nonatomic,assign) NSInteger colCount;
@property(nonatomic,strong) NSString * labelNameStyle;
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) UIView * whiteView;
@property(nonatomic,strong) UIView * lineView;


@property(nonatomic,strong) NSMutableString * myMustr;
@property(nonatomic,strong) UIButton * rightBarButton;

@property (nonatomic, strong)PublishSuccessView*  publishSuccessView;
@end

@implementation DeliverArticleViewController

- (NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos){
        _selectedPhotos = [[NSMutableArray alloc]init];
    }
    return _selectedPhotos;
}


-(void)initNavTitle{
    self.isNavBackGroundHiden  = NO;
    self.title = @"发布图文";
    self.lableNavTitle.textColor = [UIColor blackColor];
    self.navBackGround.backgroundColor = [UIColor whiteColor];
    
    [self.btnLeft setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateNormal];
    
    self.rightBarButton = [[UIButton alloc]init];
    self.rightBarButton.size = [UIView getSize_width:50 height:50];
    [self.rightBarButton setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
    self.rightBarButton.titleLabel.font = [UIFont defaultFontWithSize:17];
    self.rightBarButton.titleLabel.textColor = RGBFromColor(0x464952) ;
    [self.rightBarButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.rightBarButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnRight = self.rightBarButton;
    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = RGBFromColor(0xd4d4d4);
    [self.navBackGround addSubview:lineView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameArray = @[@"分类"];
    [self setupUI];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(changeUserState:)
//                                                 name:NSNotificationUserLoginStateChange
//                                               object:nil];
    
}

-(void)changeUserState:(id)sender{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}


//选择图片或者视频
-(void)tapToSelectPicOrVideo{
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"拍摄", @"从相册选择",nil];
    [myActionSheet showInView:self.view];
    
}

#pragma -mark  initUI---


- (PublishSuccessView *)publishSuccessView{
    
    if (!_publishSuccessView) {
        _publishSuccessView = [[PublishSuccessView alloc] init];
        
        _publishSuccessView.layer.cornerRadius = MasScale_1080(10);
        
    }
    
    
    return _publishSuccessView;
}

- (void)publishSuccessViewF{
    
    [_publishSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(MasScale_1080(535));
        make.height.mas_equalTo(MasScale_1080(256));
    }];
    
}

-(void)setupUI{
    
    self.view.backgroundColor = RGBFromColor(0xecedf1);
    
    
    //    [self initNavUI];
    [self initTabel];
    [self initTopViewUI];
    [self initBottomViewUI];
}

//-(void)initNavUI{
//
//    self.view.backgroundColor = RGBFromColor(0xecedf1);
//    self.rightBarButton = [[UIButton alloc]init];
//    self.rightBarButton.size = [UIView getSize_width:30 height:14];
//    [self.rightBarButton setTitleColor:RGBFromColor(0x464952) forState:UIControlStateNormal];
////    [self.rightBarButton setTitleColor:RGBFromColor(0xecedf1) forState:UIControlStateDisabled];
//    self.rightBarButton.titleLabel.font = [UIFont defaultFontWithSize:14];
//    self.rightBarButton.titleLabel.textColor = RGBFromColor(0x464952) ;
//    [self.rightBarButton setTitle:@"发布" forState:UIControlStateNormal];
//    [self.rightBarButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.rightBarButton];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBarButton];
//    self.navigationItem.rightBarButtonItem.enabled = YES;
//}

- (void)initTabel{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBackGround.bottom, ScreenWidth, ScreenHeight - kNavBarHeight_New) style:UITableViewStylePlain];
    self.tableView.left = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

-(void)initTopViewUI{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:@"UITextViewTextDidChangeNotification" object:speakTextView];
    
    self.viewTopBg = [[UIView alloc]init];
    self.viewTopBg.size = [UIView getSize_width:ScreenWidth height:sizeScale(1000)];
    self.viewTopBg.origin = [UIView getPoint_x:0 y:0];
    
    speakTextView = [[UITextView alloc] init];
    speakTextView.frame = CGRectMake(0, 0, self.viewTopBg.width, sizeScale(125));
    speakTextView.delegate = self;
    speakTextView.returnKeyType = UIReturnKeyDefault;
    speakTextView.font = [UIFont systemFontOfSize:16.0];
    [self.viewTopBg addSubview:speakTextView];
    
    
    _placeHoldelLebel = [[UILabel alloc]init];
    _placeHoldelLebel.frame = [UIView getScaleFrame_x:10 y:0 width:100 height:30];
    _placeHoldelLebel.text = @"这一刻我想说......";
    _placeHoldelLebel.textColor = [UIColor lightGrayColor];
    _placeHoldelLebel.font = [UIFont systemFontOfSize:14];
    [speakTextView addSubview:_placeHoldelLebel];
    
    //监听textView的限制字数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeOneCI:) name:UITextViewTextDidChangeNotification object:speakTextView];
    
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    self.margin = 4;
    self.rowCount = 1;
    self.colCount = 3;
    
    self.itemWH = (self.view.tz_width - 2*_margin - (self.colCount - 1)*2*_margin)/self.colCount;
    
    NSInteger height = (self.rowCount - 1)*self.margin*2 + self.margin*2 + self.rowCount * self.itemWH;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = self.margin;
    _layout.minimumLineSpacing = self.margin;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_margin, speakTextView.bottom, self.viewTopBg.width - 2 * _margin, height) collectionViewLayout:_layout];
    
    CGFloat rgb = 244 / 255.0;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(4, 0, 0, 2);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    [self.viewTopBg addSubview:self.collectionView];
    
    self.viewHead = [[UIView alloc]init];
    self.viewHead.size = [UIView getSize_width:ScreenWidth height:sizeScale(125)];
    self.viewHead.origin = [UIView getPoint_x:0 y:0];
    [self.viewHead addSubview:self.viewTopBg];
    
    self.spaceView = [[UIView alloc] init];
    self.spaceView.top = self.collectionView.bottom;
    self.spaceView.left = 0;
    self.spaceView.height = 24;
    self.spaceView.width = ScreenWidth;
    [self.viewTopBg addSubview:self.spaceView];
    
    self.whiteView = [[UIView alloc] init];
    self.whiteView.top = 0;
    self.whiteView.height = 12;
    self.whiteView.left = 0;
    self.whiteView.width = ScreenWidth;
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.spaceView addSubview:self.whiteView];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.top = self.whiteView.bottom;
    self.lineView.height = 12;
    self.lineView.left = 0;
    self.lineView.width = ScreenWidth;
    self.lineView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    [self.spaceView addSubview:self.lineView];
    
    
    [self layerOutHeadView];
}

-(void)initBottomViewUI{
    
    CGFloat rgb = 244 / 255.0;
    
    self.viewBottomBg = [[UIView alloc]init];
    self.viewBottomBg.size = [UIView getSize_width:ScreenWidth height:sizeScale(170)];
    self.viewBottomBg.origin = [UIView getPoint_x:0 y:self.viewMiddleBg.bottom];
    [self.view addSubview:self.viewBottomBg];
    
    UIView *viewSpace = [[UIView alloc]init];
    viewSpace.size = [UIView getSize_width:ScreenWidth height:sizeScale(12)];
    viewSpace.origin = [UIView getPoint_x:0 y:0];
    viewSpace.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    [self.viewBottomBg addSubview: viewSpace];
    
    //test
    self.tableView.tableFooterView = self.viewBottomBg;
}

-(void)layerOutHeadView{
    self.viewTopBg.height = self.collectionView.bottom;
    self.viewHead.height = self.viewTopBg.bottom;
    self.spaceView.top = self.collectionView.bottom;
    self.viewTopBg.height = self.spaceView.bottom;
    self.viewHead.height = self.viewTopBg.height;
    self.tableView.tableHeaderView = self.viewHead;
}

//设置字数限制500字
-(void)textViewDidChangeOneCI:(NSNotificationCenter *)noti{
    if (speakTextView.text.length <= 500 ) {
        _str = speakTextView.text;
    }
    if (speakTextView.text.length > 500) {
        speakTextView.text = _str;
        [self showFaliureHUD:@"输入内容不要超过500字"];
    }
}

//表情问题
-(void)textViewEditChanged:(NSNotification*)obj{
    
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    BOOL isEmoj = [self stringContainsEmoji:toBeString];
    NSString * _showStr;
    toBeString = [self disable_emoji:toBeString];
    
    
    if (isEmoj) {
        
        [self showFaliureHUD:@"不支持表情符号输入"];
        if ([_showStr length]) {
            
            textView.text = _showStr;
            
        }else{
            textView.text = toBeString;
        }
        
    }
    
}
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}
#pragma Mark   ---  过滤表情

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}





//键盘消失
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
// replacementText:(NSString *)text {
//    if ([text isEqualToString:@"\n"]) {
//        [speakTextView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    _placeHoldelLebel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        _placeHoldelLebel.hidden = NO;
    }
    
}

#pragma -mark ------UIActionSheetDelegate-------------------------

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:  //拍摄小视频
            //[[GlobalFunc sharedInstance] localPhoto:self];
            self.topicType = @"video";
            [self pickVideoClick];
            break;
        case 1:  //从相册选择
            //[[GlobalFunc sharedInstance] takePhoto:self];
            self.topicType = @"image";
            [self pickPhotoButtonClick:nil];
            
            break;
        default:
            break;
    }
}

#pragma mark TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

/// User finish picking photo，if assets are not empty, user picking original photo.
/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    [self.selectedPhotos addObjectsFromArray:photos];
    
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    //    _layout.itemCount = _selectedPhotos.count;
    [self.collectionView reloadData];
    
    NSInteger modular = (_selectedPhotos.count + 1)%self.colCount;
    self.rowCount = (_selectedPhotos.count + 1)/self.colCount;
    
    if(modular > 0){
        self.rowCount = self.rowCount + 1;
    }
    
    NSInteger height = (self.rowCount - 1)*self.margin*2 + self.margin*2 + self.rowCount * self.itemWH;
    
    self.collectionView.contentSize = CGSizeMake(0, height);
    self.collectionView.height = height;
    self.viewMiddleBg.height = height + sizeScale(12);
    
    [self layerOutHeadView];
}


- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    
    return [self.selectedPhotos objectAtIndex:index];
    
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if([self.topicType.trim isEqualToString:@"video"]){
        return  1; //_selectedPhotos.count; //视频只能有一个，所以return 值为1.
    }
    else{
        return _selectedPhotos.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    
    if([self.topicType.trim isEqualToString:@"video"]){
        
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.deleteBtn.hidden = NO;
        
        if([self.topicType.trim isEqualToString:@"video"]){ //如果该条记录是视频，添加视频播放按钮。
            
            UIImageView *imageViewPlay = [[UIImageView alloc] init];
            imageViewPlay.size = [UIView getSize_width:50 height:50];
            imageViewPlay.origin = [UIView getPoint_x:(cell.imageView.width-imageViewPlay.width)/2
                                                    y:(cell.imageView.height-imageViewPlay.height)/2];
            imageViewPlay.image = [UIImage imageNamed:@"video_play"];
            [cell.imageView addSubview:imageViewPlay];
        }
    }
    else{
        if (indexPath.row == _selectedPhotos.count) {
            //AlbumAddBtn 邻里-01-02_40.png
            cell.imageView.image = [UIImage imageNamed:@"neighborhood_pushlish"];
            cell.deleteBtn.hidden = YES;
            
            
            [cell.imageView removeAllSubviews];
        } else {
            cell.imageView.image = _selectedPhotos[indexPath.row];
            cell.deleteBtn.hidden = NO;
        }
    }
    
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if([self.topicType.trim isEqualToString:@"video"]){ //预览视频
        
        //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
        PlayerViewController *playVC =[[PlayerViewController alloc] init];
        playVC.videoUrlString = self.videoUrll;
        
        [self.navigationController pushViewController:playVC animated:YES];
        
    }
    else{
        
        if (indexPath.row == _selectedPhotos.count) {
            //因为添加视频，跳出ActionSheet
            
            [self tapToSelectPicOrVideo];
            
        } else { // preview photos / 预览照片
            
            SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
            photoBrowser.delegate = self;
            photoBrowser.currentImageIndex = indexPath.row ;
            photoBrowser.imageCount = self.selectedPhotos.count;
            photoBrowser.sourceImagesContainerView = self.collectionView;
            [photoBrowser show];
        }
    }
}


- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= _selectedPhotos.count || destinationIndexPath.item >= _selectedPhotos.count) return;
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    if (image) {
        [_selectedPhotos exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
//        [_selectedAssets exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [_collectionView reloadData];
    }
}


#pragma mark 选择多张照片

- (void)deleteBtnClik:(UIButton *)sender {
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        
        if(![self.topicType isEqualToString:@"video"]){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
        
        self.topicType = @"image"; //视频只能有一个，删除视频后，topicType 默认为 image
    }];
}

- (void)pickPhotoButtonClick:(UIButton *)sender {
    
    //如果已经选择图片，需要减去已选择的张数
    NSInteger maxImageCount = 9 - self.selectedPhotos.count;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImageCount delegate:self];
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    //imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)pickVideoClick{
    
    if([GlobalFunc isSimulator]){
        [self showFaliureHUD:@"模拟器，不支持录制视频！"];
    }
    else{
        NSLog(@"小视频全屏录制");
        WXSmartVideoView *wxsmartView = [[WXSmartVideoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        if(self.selectedPhotos.count>=1){ //如果选择的有照片，需要屏蔽录像功能，参考微信发朋友圈。
            wxsmartView.enableVideoRecord = NO;
        }
        wxsmartView.cancelCaptureBlock = ^{
            self.topicType = @"image"; //如果取消就还将topicType 设置成 image
        };
        wxsmartView.finishedCaptureBlock = ^(UIImage *img) {
            self.topicType = @"image";
            /*
             *图片尺寸已640为准进行改变尺寸，所有的缩放都以
             */
            UIImage *sizeImage = nil;
            NSInteger maxSize = 640;
            if(img.size.width > maxSize){ //宽大于高以宽为标准，高等比例变化
                sizeImage = [GlobalFunc scaleToSizeAlpha:img fixedWith:maxSize];
            }
            else{ // 如果宽和高都小于640，不进行压缩
                sizeImage = img;
            }
            
            NSData *imageData = UIImageJPEGRepresentation(sizeImage, 1.0);
            [self.selectedPhotos addObject:[UIImage imageWithData:imageData]]; //[NSMutableArray arrayWithObject:[UIImage imageWithData:imageData]];

            [self.collectionView reloadData];
            self.collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        };
        wxsmartView.finishedRecordBlock = ^(NSDictionary *dic) { //录制视频
            
            self.topicType = @"video";
            
            //加载
            //            self.videoUrll = [dic objectForKey:@"videoURL"];
            
            NSString *sourceUrlStr = [dic objectForKey:@"videoURL"];
            NSString *outputUrlStr = [sourceUrlStr stringByDeletingPathExtension];
            outputUrlStr = [outputUrlStr  stringByAppendingFormat:@".mp4"];
            
            //生成缩略图
            UIImage *imageBreviary = [self getVideoPreViewImage:[NSURL URLWithString:sourceUrlStr]];
            self.selectedPhotos = [NSMutableArray arrayWithObject:imageBreviary];
            [self.collectionView reloadData];
            self.collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            
            
            NSURL *sourUrl = [NSURL URLWithString:sourceUrlStr];
            NSURL *outputUrl = [NSURL URLWithString:outputUrlStr];
            
            __weak __typeof (self) weakSelf = self;
            
            [self convertVideoQuailtyWithInputURL:sourUrl outputURL:outputUrl completeHandler:^(BOOL finished, NSString *zipFilePath,NSString *sourceFilePath) {
                
                
                if(finished){
                    // 本地播放,Url 需要加 file:// 删除本地文件时需要去掉
                    if ([sourceFilePath hasPrefix:@"file://"]) {
                        NSMutableString *mutableString = [sourceFilePath mutableCopy];
                        [mutableString replaceCharactersInRange:NSMakeRange(0, 7) withString:@""];
                        sourceFilePath = [mutableString copy];
                    }
                    NSError*error;
                    NSFileManager *fm = [NSFileManager defaultManager];
                    if([fm fileExistsAtPath:sourceFilePath]){
                        [fm removeItemAtPath:sourceFilePath error:&error];
                        NSLog(@"删除成功！");
                    }
                    
                    weakSelf.videoUrll = zipFilePath;
                    
                    
                }
            }];
        };
        [self.navigationController.view addSubview:wxsmartView];
    }
    
}


- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(BOOL finished, NSString *zipFilePath,NSString *sourceFilePath))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality]; //高质量转换成mp4
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         
         
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted"); //压缩转mp4成功
                 NSLog(@"压缩转mp4成功!");
                 NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 
                 handler(YES,[outputURL absoluteString],[inputURL absoluteString]);
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
         
         
     }];
    
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}//此方法可以获取文件的大小，返回的是单位是KB。

- (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}//此方法可以获取视频文件的时长。

- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

#pragma mark UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *activiteyIdentifier = @"PublishCell";
    
    PulishCell *cell = (PulishCell *)[tableView dequeueReusableCellWithIdentifier:activiteyIdentifier];
    if(cell == nil){
        cell = [[PulishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activiteyIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.communityLabel.text = self.nameArray[indexPath.row];
    if (self.labelNameStyle) {
        cell.descriptionLabel.text = self.labelNameStyle;
        self.typeId = self.typeId;
        
    }else{
        cell.descriptionLabel.text = @"请先选择分类";
    }
    
    
    
    /*
     if (indexPath.row == 0) {
     //        cell.descriptionLabel.text = [GlobalData sharedInstance].communityModel.communityName;
     cell.descriptionLabel.x = ScreenWidth - 140;
     cell.descriptionLabel.width = 83;
     
     if ([GlobalData sharedInstance].hasLogin) {
     if ([GlobalData sharedInstance].communityModel.communityName == nil) {
     cell.descriptionLabel.text = @"请先关注小区";
     
     }
     else{
     cell.descriptionLabel.text = [GlobalData sharedInstance].communityModel.communityName;
     
     }
     }
     else{
     if ([GlobalData sharedInstance].communityUnLoginModel.communityName == nil) {
     cell.descriptionLabel.text = @"请先关注小区";
     }else{
     cell.descriptionLabel.text = [GlobalData sharedInstance].communityUnLoginModel.communityName;
     }
     }
     
     self.communityId = [GlobalData sharedInstance].communityModel.communityId;
     
     }
     
     else
     {
     if (self.labelNameStyle) {
     cell.descriptionLabel.text = self.labelNameStyle;
     self.typeId = self.typeId;
     
     }else{
     cell.descriptionLabel.text = @"请先选择分类";
     }
     }
     */
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return sizeScale(53);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        [self showFaliureHUD:@"没有网络,请先检查网络设置"];
        return;
    }
    
    if (indexPath.row == 0) {
//        [GlobalFunc event:@"event_choose_type_from_market_post"];
        ClassifyViewController * classify = [[ClassifyViewController alloc] init];
        classify.model = @"NEIGHBOR_INTERACTION";
        classify.delegate = self;
        classify.typeFromViewController = NO;
        classify.tag = self.tag;
        [self pushNewVC:classify animated:YES];
        
        
    }else{
        //        [GlobalFunc event:@"event_choose_community_from_market_post"];
        //        if ([GlobalData sharedInstance].communityModel.communityName == nil){
        //
        //            FocusCommunityViewController * focus = [[FocusCommunityViewController alloc] init];
        //            focus.status = @"DeliverArticle";
        //            [self pushNewVC:focus animated:YES];
        //
        //        }else{
        //            MyCommunityController * myComunity = [[MyCommunityController alloc] init];
        //            myComunity.delegate = self;
        //            myComunity.showType = MyCommunity_HidenCancel;
        //            [self pushNewVC:myComunity animated:YES];
        //        }
    }
    
}


-(void)selectedClassityDelegate:(NSString *)name and:(NSString *)tepyID andTag:(NSInteger)tag{
    //   test
    self.labelNameStyle = name;
    //
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PulishCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.descriptionLabel.text = name;
    self.typeId = tepyID;
    self.tag = tag;
}

#pragma mark  ----------------发布按钮点击

-(void)sendButtonClick:(UIBarButtonItem *)rightItem{
    
    self.rightBarButton.enabled = NO;
    
    if (![speakTextView.text.trim isEqualToString:@""]) {
        if (!(self.typeId == nil)) {
            
            if([self.topicType.trim isEqualToString:@"video"]){
                [self uploadVideo];
            }
            else{
                [self uploadPicture];
            }
        }else{
            [self showFaliureHUD:@"分类不能为空"];
            self.rightBarButton.enabled = YES;
        }
    }else{
        [self showFaliureHUD:@"描述内容不能为空"];
        self.rightBarButton.enabled = YES;
    }
}

//上传图片
-(void)uploadPicture{
    
    NSMutableDictionary *fileDic = [[NSMutableDictionary alloc]init];
    for(UIImage *image in self.selectedPhotos){
        
        /*
         *图片尺寸已640为准进行改变尺寸，所有的缩放都以
         */
        UIImage *sizeImage = nil;
        NSInteger maxSize = 640;
        if(image.size.width > maxSize){ //宽大于高以宽为标准，高等比例变化
            sizeImage = [GlobalFunc scaleToSizeAlpha:image fixedWith:maxSize];
        }
        else{ // 如果宽和高都小于640，不进行压缩
            sizeImage = image;
        }
        
        NSData *imageData = UIImageJPEGRepresentation(sizeImage, 1.0);
        //sizeImage = UIImageJPEGRepresentation([GlobalFunc scaleToSizeAlpha:image alpha:alpha], 0.7); //压缩图片质量，保留。
        NSString *key = [NSString stringWithFormat:@"%@.png",[GlobalFunc getCurrentTimeWithFormatter:@"yyyyMMddHHmmssSSS"]];
        
        [fileDic setObject:imageData forKey:key];
        self.imageViewPublick.image = [UIImage imageWithData:imageData];
        NSLog(@"--------压缩后-imageData.length = %ld",(unsigned long)imageData.length);
    }
    
    if(self.myMustr){
        self.myMustr = nil;
    }
    self.myMustr = [[NSMutableString alloc]init];
    
    if(fileDic.allKeys.count > 0){
        
        __weak __typeof(self) weakSelf = self;
        NetWork_uploadApi *request = [[NetWork_uploadApi alloc]init];
        request.uploadFilesDic = fileDic;
        [request showWaitMsg:@"加载中..." handle:self];
        [request startPostWithBlock:^(UploadRespone *result, NSString *msg, BOOL finished) {
            if([result.status isEqualToString:@"1"] && result.data.count > 0){
                
                
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                for(UploadModel *model in result.data){
                    //2017.05.18 songlie 注释，重新添加跳蚤市场后，报错，暂时屏蔽，需要后期挑时候看是什么问题。
                    [resultArray addObject:model.attachUrl];
                    
                }
                //上传图片的顺序和显示图片的顺序需要排布一致
                NSArray *sortArray = [resultArray sortedArrayUsingSelector:@selector(compare:)];
                for(int i=0; i< sortArray.count;i++){
                    NSString *imgUrl = [sortArray objectAtIndex:i];
                    
                    if(i == result.data.count - 1){
                        [weakSelf.myMustr appendString:imgUrl];
                    }
                    
                    else{
                        [weakSelf.myMustr appendString:[NSString stringWithFormat:@"%@,",imgUrl]];
                    }
                }
                weakSelf.imageStringUrl = weakSelf.myMustr;
                NSLog(@"上传图片成功!");
                //[self publishzTopic];
                [self sendBtnRequest];
            }
            else{
                [self showFaliureHUD:@"图片上传失败"];
                self.rightBarButton.enabled = YES;
            }
        }];
    }
    else{
        NSLog(@"上传图片");
        [self sendBtnRequest];
    }
}

-(void)uploadVideo{
    
    NSString *extName = [self.videoUrll pathExtension];
    NSURL *videoUrl = [NSURL URLWithString:self.videoUrll];
    /*
     *测试上传视频
     */
    NSMutableDictionary *fileDic = [[NSMutableDictionary alloc]init];
    NSData *movData = [NSData dataWithContentsOfURL:videoUrl];
    NSString *key = [NSString stringWithFormat:@"%@.%@",[GlobalFunc getCurrentTimeWithFormatter:@"yyyyMMddHHmmssSSS"],extName];
    [fileDic setObject:movData forKey:key];
    
    if(self.myMustr){
        self.myMustr = nil;
    }
    self.myMustr = [[NSMutableString alloc]init];
    
    __weak __typeof(self) weakSelf = self;
    NetWork_uploadApi *request = [[NetWork_uploadApi alloc]init];
    request.uploadFilesDic = fileDic;
    [request showWaitMsg:@"加载中..." handle:self];
    [request startPostWithBlock:^(UploadRespone *result, NSString *msg, BOOL finished) {
        
        if([result.status isEqualToString:@"1"] && result.data.count > 0){
            if(result.data.count > 0){
                
                UploadModel *model = [result.data objectAtIndex:0];
                weakSelf.myMustr = [[NSMutableString alloc] initWithString:model.attachUrl];//model.attachUrl;
                //[self publishzTopic];
                [weakSelf sendBtnRequest];
                
                //上传成功后，删除本地mp4 文件
                NSMutableString *fileMp4Path = [self.videoUrll mutableCopy];
                if ([fileMp4Path hasPrefix:@"file:/"]) {
                    [fileMp4Path replaceCharactersInRange:NSMakeRange(0, 6) withString:@""];
                }
                NSError*error;
                NSFileManager *fm = [NSFileManager defaultManager];
                if([fm fileExistsAtPath:fileMp4Path]){
                    [fm removeItemAtPath:fileMp4Path error:&error];
                    NSLog(@"删除成功！");
                }
                
                NSLog(@"-----------");
            }
            else{
                [weakSelf showFaliureHUD:@"视频上传失败"];
            }
        }
        else{
            [weakSelf showFaliureHUD:@"视频上传失败"];
            weakSelf.rightBarButton.enabled = YES;
        }
        
        
    }];
    
    
}

////校验
//-(void)publishzTopic{
//
////    self.rightBarButton.enabled = YES;
//
//    if(![[Reachability reachabilityForInternetConnection] isReachable]){
//        [self showFaliureHUD:@"没有网络,请先检查网络设置"];
//        return;
//    }
//
//    [self sendBtnRequest];
//}



-(void)sendBtnRequest{
    
    Network_publishTopic * publishTopic = [[Network_publishTopic alloc]init];
    publishTopic.token = [GlobalData sharedInstance].loginDataModel.token;
    publishTopic.topicContent = speakTextView.text;
    publishTopic.urls = self.myMustr;
    publishTopic.typeId = self.typeId;
    publishTopic.communityId =  [GlobalData sharedInstance].loginDataModel.attentionCommunityId;
    publishTopic.longitude = @([[GlobalData sharedInstance].longitude floatValue]);
    publishTopic.latitude = @([[GlobalData sharedInstance].latitude floatValue]);
    publishTopic.topicType = self.topicType;
    [publishTopic showWaitMsg:@"加载中..." handle:self];
    [publishTopic startPostWithBlock:^(publishTopicResponse * result, NSString *msg, BOOL finished) {
        NSLog(@"%@",result);
        if(finished){
            self.rightBarButton.enabled = YES;
            
            if([self.topicType.trim isEqualToString:@"video"]){
                [[AddIntegralTool sharedInstance] addIntegral:self code:@"10007"];
            }
            else{
                [[AddIntegralTool sharedInstance] addIntegral:self code:@"10006"];
            }

            PublishSuccessViewModel* model =  [[PublishSuccessViewModel alloc] init];
            
            model.integral = result.data.integralResult.credits;
            model.title = @"发布成功";
            if ([result.data.integralResult.returnCode isEqualToString:@"0"]) {
                
                model.publishSuccessType = PublishSuccessHasintegral;
            }else{
                
                model.publishSuccessType = PublishSuccessNointegral;
                
            }
            [self.publishSuccessView dataBind:model];
            
            [self.view ttPresentFramePopupView:self.publishSuccessView animationType:TTFramePopupViewAnimationFade dismissed:^{
                NSLog(@"我要消失了");
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            [self publishSuccessViewF];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.view ttDismissPopupViewControllerWithanimationType:TTFramePopupViewAnimationFade];
                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationPublishState
                                                                    object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else{
            
            [self showFaliureHUD:msg];
            self.rightBarButton.enabled = YES;
        }
    }];
}

@end
