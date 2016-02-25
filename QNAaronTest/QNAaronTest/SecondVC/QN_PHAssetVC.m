//
//  QN_PHAssetVC.m
//  QNAaronTest
//
//  Created by   何舒 on 15/10/22.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "QN_PHAssetVC.h"

#import <Photos/Photos.h>

#import "QN_PHAssetChoseVC.h"


#define IMAGEUPLOAD @"api/quick_start/simple_image_example_token.php"
#define VIDEOUPLOAD @"api/resumable_upload/with_key_upload_token.php"
@interface QN_PHAssetVC ()

@property (nonatomic ,strong) PHAsset * phAsset;
@property (nonatomic, strong) PHFetchResult * selectPhasset;

@property (nonatomic, assign) BOOL isStop;

@end

@implementation QN_PHAssetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
-(void)getTokenFromQNURL:(NSString *)url
{
    [HTTPRequestPost hTTPRequest_GetpostBody:nil andUrl:url andSucceed:^(NSURLSessionDataTask *task, id responseObject) {
        self.token = responseObject[@"uptoken"];
        self.domain = responseObject[@"domain"];
        [self uploadImageAssetToQN];
    } andFailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ======  %@", error);
    } andISstatus:nil];
}

- (IBAction)choseAction:(id)sender
{
//    QN_PHAssetChoseVC * getPHAssetVC = [[QN_PHAssetChoseVC alloc] init];
//    [self.navigationController pushViewController:getPHAssetVC animated:YES];
//    [getPHAssetVC getPHAssetFromPH:^(PHAsset *asset) {
//        self.phAsset = asset;
//    }];
    [self gotoImageLibrary];
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
    NSArray * array = [[NSArray alloc] initWithObjects:imageURL, nil];
    self.selectPhasset = [PHAsset fetchAssetsWithALAssetURLs:array options:nil];
    self.phAsset = self.selectPhasset[0];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)uploadBtn:(id)sender
{
    if (self.phAsset.mediaType == PHAssetMediaTypeImage) {
        [self getTokenFromQNURL:IMAGEUPLOAD];
    }else
    {
        [self getTokenFromQNURL:VIDEOUPLOAD];
    }
    self.showLabel.hidden = NO;
    self.prograssView.hidden = NO;
    self.isStop = NO;
}

- (IBAction)stopAction:(id)sender
{
    
    self.showLabel.hidden = YES;
    self.prograssView.hidden = YES;
    self.isStop = YES;
    
}
-(void)uploadImageAssetToQN
{
    NSString * token = @"";
    if (!isStringEmpty(self.token)) {
        token = self.token;
    }
    
    //fileName为key,当上传的文件名字一样时，默认为上传失败
    NSString * document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSError *error;
    QNFileRecorder * file = [QNFileRecorder fileRecorderWithFolder:[document stringByAppendingString: @"/QN_uploadFile"] error:&error];
    
    //当上传的文件名字一样时，默认为上传失败
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption * uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        self.percentFloat = percent;
    } params:nil checkCrc:NO cancellationSignal:^BOOL () {
        return self.isStop;
    }];
    upManager = [upManager initWithRecorder:file];
    
    [upManager putPHAsset:self.phAsset key:self.fillKey.text token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
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
    if (self.percentFloat == 0.50) {
        self.isStop = YES;
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
