//
//  PersonalInformationViewController.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "PersonalInformationViewController.h"

#import "NickNameViewController.h"
#import "IntroduceViewController.h"


#import "NetWork_uploadApi.h"
#import "NetWork_uploadIcon.h"


@interface PersonalInformationViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong) UIImageView * loginIconImageView;
@property(nonatomic,strong) UILabel * labelNickName;
@property(nonatomic,strong) UILabel * labelIntrduce;
@property(nonatomic,strong) UIView * nicknameView;
@property(nonatomic,strong) UIImageView * nicknameArrowImageView;
@property(nonatomic,strong) UIScrollView * scrollBg;



@end

@implementation PersonalInformationViewController

-(void)dealloc{
    NSLog(@"---------------%@ dealloc ",NSStringFromClass([self class]));
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

-(void)initNavTitle{
    [super initNavTitle];
    
    self.title = @"编辑资料";
}

- (void)viewDidLoad {
    
    self.isNavBackGroundHiden = NO;
    
    [super viewDidLoad];
    
    [self creatUI];
//    [self initRequest];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUser];
    
}
-(void)creatUI{
    self.view.backgroundColor = RGBFromColor(0xecedf1);
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont defaultFontWithSize:20],
//       NSForegroundColorAttributeName:RGBFromColor(0x464952)}];
    self.view.backgroundColor = RGBFromColor(0xf6f6f6);
    
    
    self.scrollBg = [[UIScrollView alloc] init];
    self.scrollBg.size = [UIView getSize_width:ScreenWidth height:ScreenHeight - kTabBarHeight_New];
    self.scrollBg.origin = [UIView getPoint_x:0 y:self.navBackGround.bottom];
    self.scrollBg.showsVerticalScrollIndicator = NO;
    
    self.scrollBg.contentSize = CGSizeMake(self.scrollBg.width, ScreenHeight);
    //    self.scrollBg.delaysContentTouches = NO;
    //    self.scrollBg.canCancelContentTouches = NO;
    
    [self.view addSubview:self.scrollBg];
    
    // 头像的view
    UIView * iconView = [[UIView alloc]init];
    iconView.size = [UIView getSize_width:ScreenWidth height:sizeScale(66)];
    iconView.origin =[UIView getPoint_x:0 y:12];
    iconView.backgroundColor = [UIColor whiteColor];
    [self.scrollBg addSubview:iconView];
    
    UILabel * lableLine = [[UILabel alloc]init];
    lableLine.backgroundColor = RGBFromColor(0xecedf1);
    lableLine.left = 0;
    lableLine.width = ScreenWidth;
    lableLine.height = 1;
    lableLine.top = iconView.height-1;
    
    [iconView addSubview:lableLine];
    UILabel * labelIcon = [[UILabel alloc]init];
    labelIcon.font = [UIFont defaultFontWithSize:sizeScale(14)];
    labelIcon.textColor = RGBFromColor(0x464952);
    labelIcon.text = @"头像";
    
    CGSize labelIconSize = [labelIcon.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:labelIcon.font,NSFontAttributeName, nil]];
    labelIcon.size = [UIView getSize_width:labelIconSize.width height:labelIconSize.height];
    labelIcon.left = 21;
    labelIcon.top = (iconView.height - labelIcon.height)/2;
    [iconView addSubview:labelIcon];
    
    UIImageView * arrowImageView = [[UIImageView alloc]init];
    arrowImageView.size = [UIView getSize_width:5 height:10];
    arrowImageView.top = (iconView.height - arrowImageView.height)/2;
    arrowImageView.left = iconView.width - 21 - arrowImageView.width;
    arrowImageView.image = [UIImage imageNamed:@"command_left"];
    [iconView addSubview:arrowImageView];
    
    //  用户头像
    self.loginIconImageView = [[UIImageView alloc]init];
    self.loginIconImageView.userInteractionEnabled = YES;
    self.loginIconImageView.size = [UIView getSize_width:33 height:33];
    self.loginIconImageView.top = (iconView.height - self.loginIconImageView.height)/2;
    self.loginIconImageView.left = ScreenWidth - arrowImageView.width - 8 -self.loginIconImageView.width-21;
    CALayer * loginIconImageViewLayer = [self.loginIconImageView layer];
    [loginIconImageViewLayer setMasksToBounds:YES];
    [loginIconImageViewLayer setCornerRadius:self.loginIconImageView.width/2];
    self.loginIconImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginIconImageViewClcik:)];
    [self.loginIconImageView addGestureRecognizer:tap];
    
    [iconView addSubview:self.loginIconImageView];
    // 昵称
    self.nicknameView = [[UIView alloc]init];
    self.nicknameView.size = [UIView getSize_width:ScreenWidth height:sizeScale(66)];
    self.nicknameView.origin =[UIView getPoint_x:0 y:iconView.bottom];
    self.nicknameView.backgroundColor =[UIColor whiteColor];
    [self.scrollBg addSubview:self.nicknameView];
    
    UILabel * labelLoginIcon = [[UILabel alloc]init];
    labelLoginIcon.font = [UIFont defaultFontWithSize:sizeScale(14)];
    labelLoginIcon.textColor = RGBFromColor(0x464952);
    labelLoginIcon.text = @"昵称";
    CGSize lableNicknameSize = [labelLoginIcon.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:labelLoginIcon.font,NSFontAttributeName, nil]];
    
    labelLoginIcon.size = [UIView getSize_width:lableNicknameSize.width height:lableNicknameSize.height];
    labelLoginIcon.left = 21;
    labelLoginIcon.top = (self.nicknameView.height - labelLoginIcon.height)/2;
    [self.nicknameView addSubview:labelLoginIcon];
    
    self.nicknameArrowImageView = [[UIImageView alloc]init];
    self.nicknameArrowImageView.size = [UIView getSize_width:5 height:10];
    self.nicknameArrowImageView.top = (self.nicknameView.height - self.nicknameArrowImageView.height)/2;
    self.nicknameArrowImageView.left = self.nicknameView.width - 21 - self.nicknameArrowImageView.width;
    self.nicknameArrowImageView.image = [UIImage imageNamed:@"command_left"];
    [self.nicknameView addSubview:self.nicknameArrowImageView];
    
    self.labelNickName = [[UILabel alloc]init];
    self.labelNickName.userInteractionEnabled = YES;
    self.labelNickName.textAlignment = NSTextAlignmentRight;
    self.labelNickName.font = [UIFont defaultFontWithSize:sizeScale(14)];
    self.labelNickName.textColor = RGBFromColor(0x777777);
    [self.nicknameView addSubview:self.labelNickName];
    
    UIButton * buttonClear = [[UIButton alloc]init];
    buttonClear.size = [UIView getSize_width:200 height:self.nicknameView.height];
    buttonClear.origin = [UIView getPoint_x:ScreenWidth-200 y:0];
    [buttonClear addTarget:self action:@selector(nickNameClcik) forControlEvents:UIControlEventTouchUpInside];
    [self.nicknameView addSubview:buttonClear];
    
    UILabel * lableLineNickName = [[UILabel alloc]init];
    lableLineNickName.backgroundColor = RGBFromColor(0xecedf1);
    lableLineNickName.left = 0;
    lableLineNickName.width = ScreenWidth;
    lableLineNickName.height = 1;
    lableLineNickName.top = self.nicknameView.height-1;
    
    [self.nicknameView addSubview:lableLineNickName];
    
    
    //编辑资料
    UIView * viewIntroduce = [[UIView alloc]init];
    viewIntroduce.size   =[UIView getSize_width:ScreenWidth height:sizeScale(66)];
    viewIntroduce.origin =[UIView getPoint_x:0 y:self.nicknameView.bottom];
    viewIntroduce.backgroundColor = [UIColor whiteColor];
    [self.scrollBg addSubview:viewIntroduce];
    
    UILabel * lablescan = [[UILabel alloc]init];
    lablescan.font = [UIFont defaultFontWithSize:sizeScale(14)];
    lablescan.textColor = RGBFromColor(0x464952);
    lablescan.text = @"介绍";
    lablescan.left = 21;
    lablescan.top = 0;
    lablescan.size = [UIView getSize_width:100 height:viewIntroduce.height];
    [viewIntroduce addSubview:lablescan];
    
    
    self.labelIntrduce = [[UILabel alloc]init];
    self.labelIntrduce.userInteractionEnabled = YES;
    self.labelIntrduce.textAlignment = NSTextAlignmentRight;
    self.labelIntrduce.font = [UIFont defaultFontWithSize:sizeScale(14)];
    self.labelIntrduce.textColor = RGBFromColor(0x777777);
    [viewIntroduce addSubview:self.labelIntrduce];
    
    
    UIImageView * scanArrowImageView = [[UIImageView alloc]init];
    scanArrowImageView.size = [UIView getSize_width:5 height:10];
    scanArrowImageView.top = (viewIntroduce.height - scanArrowImageView.height)/2;
    scanArrowImageView.left = viewIntroduce.width - 21 - scanArrowImageView.width;
    scanArrowImageView.image = [UIImage imageNamed:@"command_left"];
    [viewIntroduce addSubview:scanArrowImageView];
    
    UIButton * btnEditInfo = [[UIButton alloc]init];
    btnEditInfo.size = [UIView getSize_width:viewIntroduce.width height:viewIntroduce.height];
    btnEditInfo.origin = [UIView getPoint_x:0 y:0];
    btnEditInfo.tag = 9010;
    [btnEditInfo addTarget:self action:@selector(introduceClcik) forControlEvents:UIControlEventTouchUpInside];
    [viewIntroduce addSubview:btnEditInfo];
    
    UILabel * lableLineEditInfo = [[UILabel alloc]init];
    lableLineEditInfo.backgroundColor = RGBFromColor(0xecedf1);
    lableLineEditInfo.left = 0;
    lableLineEditInfo.width = ScreenWidth;
    lableLineEditInfo.height = 1;
    lableLineEditInfo.top = viewIntroduce.height-1;
    [viewIntroduce addSubview:lableLineEditInfo];
}



//每次进入界面，从userAccount中拿值，刷新界面的值
-(void)updateUser {
    
    [self.loginIconImageView sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].loginDataModel.userIcon] placeholderImage:[UIImage imageNamed:@"个人中心默认头像-1"]]; //默认头像
    //  昵称
    if ([GlobalData sharedInstance].loginDataModel.nickName == nil) {
        self.labelNickName.text = @"";
    }else{
        self.labelNickName.text = [GlobalData sharedInstance].loginDataModel.nickName;
    }
    

    
    
    CGRect nameLabelSize = [self.labelNickName.text boundingRectWithSize:CGSizeMake(1000, self.nicknameView.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelNickName.font,NSFontAttributeName, nil] context:nil];
    
    self.labelNickName.size = [UIView getSize_width:nameLabelSize.size.width height:self.nicknameView.height];
    self.labelNickName.top = (self.nicknameView.height - self.labelNickName.height)/2;
    self.labelNickName.left = self.nicknameArrowImageView.left -8-self.labelNickName.width;
    
    
    //  昵称
    if ([GlobalData sharedInstance].loginDataModel.selfIntroduction == nil) {
        self.labelIntrduce.text = @"";
    }else{
        self.labelIntrduce.text = [GlobalData sharedInstance].loginDataModel.selfIntroduction;
    }
    
    CGRect introduceLabelSize = [self.labelIntrduce.text boundingRectWithSize:CGSizeMake(1000, self.nicknameView.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelNickName.font,NSFontAttributeName, nil] context:nil];
    
    self.labelIntrduce.size = [UIView getSize_width:introduceLabelSize.size.width height:self.nicknameView.height];
    self.labelIntrduce.top = (self.nicknameView.height - self.labelNickName.height)/2;
    self.labelIntrduce.left = self.nicknameArrowImageView.left -8-self.labelNickName.width;
    self.labelIntrduce.right = ScreenWidth - 35;
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [[GlobalFunc sharedInstance] localPhoto:self];
            break;
        case 1:
            [[GlobalFunc sharedInstance] takePhoto:self];
            break;
        default:
            break;
    }
}




#pragma mark - 选择图片后返回图片列表

- (void)selectedImages:(NSArray*)images{
    
    NSMutableDictionary *fileDic = [[NSMutableDictionary alloc]init];
    for(UIImage *image in images){
        
        NSData *imageData = nil;
        int max = image.size.height > image.size.width ? image.size.height : image.size.width;
        float alpha = 1;
        if (max>700) {
            alpha = 700.0 / (float)max;
        }
        
        imageData = UIImageJPEGRepresentation([GlobalFunc scaleToSizeAlpha:image alpha:alpha], 0.5);
        NSString *key = [NSString stringWithFormat:@"%@.png",[GlobalFunc getCurrentTime]];
        [fileDic setObject:imageData forKey:key];
    }
    
    if(fileDic.allKeys.count > 0){
        __weak __typeof(self) weakSelf = self;
        NetWork_uploadApi *request = [[NetWork_uploadApi alloc]init];
        request.uploadFilesDic = fileDic;
        [request startPostWithBlock:^(UploadRespone *result, NSString *msg, BOOL finished) {
            
            if([result.status isEqualToString:@"1"] && result.data.count > 0){
                
                UploadModel *model = [result.data objectAtIndex:0];
                //                [weakSelf.loginIconImageView sd_setImageWithURL:[NSURL URLWithString:model.showImgUrl]];
                NetWork_uploadIcon *requestIcon = [[NetWork_uploadIcon alloc]init];
                requestIcon.token = [GlobalData sharedInstance].loginDataModel.token;
                requestIcon.mobile = [GlobalData sharedInstance].loginDataModel.mobile;
                requestIcon.userIcon = model.attachUrl;
                [requestIcon showWaitMsg:@"" handle:self];
                [requestIcon startPostWithBlock:^(UploadIconRespone *resulIcon, NSString *msg, BOOL finished) {
                    /*
                     *如果上传成功，发送用户状态改变通知
                     */
                    if([resulIcon.status isEqualToString:@"1"]){
                        [weakSelf.loginIconImageView sd_setImageWithURL:[NSURL URLWithString:model.showAttachUrl]];
                        
                        NSString *dicStr = [[GlobalData sharedInstance].loginDataModel generateJsonStringForProperties];
                        LoginDataModel *dataModelTemp = [[LoginDataModel alloc]initWithDictionary:[dicStr objectFromJSONString]];
                        dataModelTemp.userIcon = model.showAttachUrl;
                        [GlobalData sharedInstance].loginDataModel = dataModelTemp;
                        
                        [[AddIntegralTool sharedInstance] addIntegral:self code:@"10002"];
                    }else{
                        
                        [self showFaliureHUD:msg];
                        
                    }
                }];
            }else{
                [self showFaliureHUD:msg];
            }
        }];
    }
}
//事件处理
-(void)loginIconImageViewClcik:(UIGestureRecognizer *)tap{
    NSLog(@"点击头像按钮");
//    [GlobalFunc event:@"event_modify_user_avart"];
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"从相册选择", @"拍照",nil];
    [myActionSheet showInView:self.view];
}

-(void)nickNameClcik{
    
//    [GlobalFunc event:@"event_modify_user_nickName"];
    
    NickNameViewController * nickNameViewController = [[NickNameViewController alloc]init];
    //    [self pushNewVC:nickNameViewController animated:YES];
    [self.navigationController pushViewController:nickNameViewController animated:YES];
}

-(void)introduceClcik{
    
    IntroduceViewController * introduceViewController = [[IntroduceViewController alloc]init];
    //    [self pushNewVC:nickNameViewController animated:YES];
    [self.navigationController pushViewController:introduceViewController animated:YES];
}



-(void)buttonClcik:(UIButton *)btn{
    
    if (btn.tag == 9020) {
        
        
    }
    else if (btn.tag == 9011) {
        
        if(self.isWxBind){//解绑
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"解除绑定" message:@"确定要解除账号与微信的关联么？\r\n解除后将无法使用微信登录此账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解除绑定", nil];
            alert.tag = 91;
            [alert show];
        }
        else{ //绑定
//            [self sendWeChatAuthRequest];
        }
    }
    else if (btn.tag == 9012) {
        
        if(self.isSinaBind){//解绑
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"解除绑定" message:@"确定要解除账号与微博的关联么？\r\n解除后将无法使用微博登录此账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解除绑定", nil];
            alert.tag = 92;
            [alert show];
        }
        else{ //绑定
//            [self sendWeiboAuth];
        }
    }
    else{
        
    }
}



@end
