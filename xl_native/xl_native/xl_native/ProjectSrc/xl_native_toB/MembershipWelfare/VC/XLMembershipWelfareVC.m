//
//  XLMembershipWelfareVC.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLMembershipWelfareVC.h"
#import "TBWealthPlanViewController.h"

@interface XLMembershipWelfareVC () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (nonatomic,strong) UIImagePickerController *picker;
@property (strong, nonatomic) UIImage *selectImg;

@end

@implementation XLMembershipWelfareVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"会员福利";
    self.view.backgroundColor = XLRGBColor(242, 242, 242);
    
    [self setupUI];
    [self creatPiker];
}
- (void)setupUI
{
    self.name.text = self.model.appUserName;
    self.desc.text = self.model.communityName;
    self.info.text = self.model.content;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.model.userIcon]];
}
- (IBAction)addImage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加照片" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickerIsPhotoAlbum:NO];
    }]] ;
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickerIsPhotoAlbum:YES];
    }]] ;
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)submitClick
{
    if (!self.selectImg) {
        [SVProgressHUD showErrorWithStatus:@"请添加图片"];
        return;
    }
    
    NSMutableDictionary *fileDic = [[NSMutableDictionary alloc]init];
    
    NSData *imageData = nil;
    int max = self.selectImg.size.height > self.selectImg.size.width ? self.selectImg.size.height : self.selectImg.size.width;
    float alpha = 1;
    if (max>700) {
        alpha = 700.0 / (float)max;
    }
    
    imageData = UIImageJPEGRepresentation([GlobalFunc scaleToSizeAlpha:self.selectImg alpha:alpha], 0.5);
    NSString *key = [NSString stringWithFormat:@"%@.png",[GlobalFunc getCurrentTime]];
    [fileDic setObject:imageData forKey:key];
    
    if (fileDic.allKeys.count > 0) {
        NetWork_uploadApi *request = [[NetWork_uploadApi alloc]init];
        request.uploadFilesDic = fileDic;
        [request startPostWithBlock:^(UploadRespone *result, NSString *msg, BOOL finished) {
            
            if([result.status isEqualToString:@"1"] && result.data.count > 0){
                
                UploadModel *model = [result.data objectAtIndex:0];
                
                NetWork_membershipWelfare *request = [[NetWork_membershipWelfare alloc] init];
                request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
                request.image = model.attachUrl;
                request.voucher_ReceiveId = self.voucherReceiveId;
                [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
                    if (finished) {
                        [SVProgressHUD showSuccessWithStatus:msg];
                        for (UIViewController *vc in self.navigationController.viewControllers) {
                            if ([vc isKindOfClass:[TBWealthPlanViewController class]]) {
                                [self.navigationController popToViewController:vc animated:YES];
                            }
                        }
                    } else {
                        [SVProgressHUD showSuccessWithStatus:msg];
                    }
                }];
            } else {
            }
        }];
    }
}

#pragma mark   --- 图片选取 操作  ---
- (void)creatPiker
{
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
}

-(void)imagePickerIsPhotoAlbum:(BOOL)isPhotoAlbum
{
    if (isPhotoAlbum)
    {// 打开相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_picker animated:YES completion:nil];
        }
    }
    else
    {
        NSError *error;
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 创建输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (!input) {
            // 判断相机是否可用
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }else
        {// 打开相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:_picker animated:YES completion:NULL];
            }
        }
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image;
    if (_picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary || _picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.img.image = image;
        self.selectImg = image;
    }
}


@end
