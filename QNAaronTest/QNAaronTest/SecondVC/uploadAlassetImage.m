//
//  uploadAlassetImage.m
//  QNAaronTest
//
//  Created by   何舒 on 15/10/14.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "uploadAlassetImage.h"
#import <Photos/Photos.h>

@interface uploadAlassetImage ()

@property (nonatomic, strong) ALAsset * asset;
@property (nonatomic, strong) ALAssetsLibrary * assetslibrary;


@end

@implementation uploadAlassetImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.functionTitle;
    self.uploadImage.contentMode = UIViewContentModeScaleAspectFit;
    self.showLabel.hidden = YES;
    
    self.prograssView.hidden = YES;
    self.prograssView.progress = 0.0f;
    
    self.assetslibrary = [[ALAssetsLibrary alloc] init];
    
}

- (IBAction)takePhotoAction:(id)sender {
    [self gotoImageLibrary];
}
- (IBAction)uploadAction:(id)sender {
    if (!self.asset) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"还未选择资源图片" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }else
    {
        self.showLabel.hidden = NO;
        self.prograssView.hidden = NO;
        [self getTokenFromQN];
        
    }
}

-(void)getTokenFromQN
{
    [HTTPRequestPost hTTPRequest_GetpostBody:nil andUrl:@"api/quick_start/simple_image_example_token.php" andSucceed:^(NSURLSessionDataTask *task, id responseObject) {
        self.token = responseObject[@"uptoken"];
        self.domain = responseObject[@"domain"];
        [self uploadImageAssetToQN];
    } andFailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ======  %@", error);
    } andISstatus:nil];
}

/**
 *  调用系统相册
 */
-(void)gotoImageLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"访问图片库错误"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    }
}

//再调用以下委托：
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSURL * imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset * asset)
    {
        self.asset = asset;
    };
    [self.assetslibrary assetForURL:imageURL resultBlock:resultBlock failureBlock:nil];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImageAssetToQN
{
    NSString * token = @"";
    if (!isStringEmpty(self.token)) {
        token = self.token;
    }
    
    //当上传的文件名字一样时，默认为上传失败
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption * uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        self.percentFloat = percent;
    } params:nil checkCrc:NO cancellationSignal:nil];
    
    [upManager putALAsset:self.asset key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        
        NSLog(@"%@/%@",self.domain,resp[@"key"]);
        [self.uploadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.domain,resp[@"key"]]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        
    } option:uploadOption];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getPercent) userInfo:nil repeats:YES];
    
}

- (void)getPercent
{
    if (self.percentFloat == 1.00) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.showLabel.text = [NSString stringWithFormat:@"%.0f%%",self.percentFloat*100];
    self.prograssView.progress = self.percentFloat;
    [self.showLabel setNeedsLayout];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
