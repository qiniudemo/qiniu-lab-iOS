//
//  QN_LivePhotoVC.m
//  QNAaronTest
//
//  Created by   何舒 on 16/2/25.
//  Copyright © 2016年   何舒. All rights reserved.
//

#import "QN_LivePhotoVC.h"
#import <Photos/Photos.h>

#define IMAGEUPLOAD @"api/quick_start/simple_image_example_token.php"
//当前获取video上传token会另外转码生成map4和m3u8格式文件
#define VIDEOUPLOAD @"api/quick_start/simple_video_example_token.php"
@interface QN_LivePhotoVC ()

@property (nonatomic ,strong) PHAsset * phAsset;
@property (nonatomic, strong) PHFetchResult * selectPhasset;
@property (nonatomic, strong) NSURL * storeUrl;
@property (nonatomic, strong) NSData * storeData;
@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, assign) BOOL isStop;

@property (nonatomic, strong) NSString * imageToken;
@property (nonatomic, strong) NSString * vedioToken;

@property (nonatomic, strong) NSTimer * transformTime;
@property (nonatomic, strong) NSString * persistentId;

@end

@implementation QN_LivePhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)getImageTokenFromQNURL:(NSString *)url
{
    [HTTPRequestPost hTTPRequest_GetpostBody:nil andUrl:url andSucceed:^(NSURLSessionDataTask *task, id responseObject) {
        self.imageToken = responseObject[@"uptoken"];
        self.domain = responseObject[@"domain"];
        [self getVedioTokenFromQNURL:VIDEOUPLOAD];
    } andFailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ======  %@", error);
    } andISstatus:nil];
}
-(void)getVedioTokenFromQNURL:(NSString *)url
{
    [HTTPRequestPost hTTPRequest_GetpostBody:nil andUrl:url andSucceed:^(NSURLSessionDataTask *task, id responseObject) {
        self.vedioToken = responseObject[@"uptoken"];
        self.domain = responseObject[@"domain"];
        [self uploadImageAssetToQN];
    } andFailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ======  %@", error);
    } andISstatus:nil];
}

- (IBAction)choseAction:(id)sender
{
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
    NSArray * selectArray = [[NSArray alloc] initWithObjects:imageURL, nil];
    self.selectPhasset = [PHAsset fetchAssetsWithALAssetURLs:selectArray options:nil];
    self.phAsset = self.selectPhasset[0];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)uploadBtn:(id)sender
{
    if (self.phAsset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        
        
        [self getImageTokenFromQNURL:IMAGEUPLOAD];
        self.showLabel.hidden = NO;
        self.prograssView.hidden = NO;
        self.isStop = NO;
    }else
    {
        [SVProgressHUD showAlterMessage:@"当前文件类型不是LivePhoto，请重新选择"];
    }
}

- (IBAction)stopAction:(id)sender
{
    
    self.showLabel.hidden = YES;
    self.prograssView.hidden = YES;
    self.isStop = YES;
    
}

- (void)uploadImageAssetToQN
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
    QNUploadOption * imageOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        self.percentFloat = percent/2;
    } params:nil checkCrc:NO cancellationSignal:^BOOL () {
        return self.isStop;
    }];
    QNUploadOption * vedioOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        self.percentFloat = percent/2+0.5;
    } params:nil checkCrc:NO cancellationSignal:^BOOL () {
        return self.isStop;
    }];
    upManager = [upManager initWithRecorder:file];
    NSArray * array = [PHAssetResource assetResourcesForAsset:self.phAsset];
    [upManager putPHAsset:self.phAsset key:[NSString stringWithFormat:@"%@.jpg",self.fillKey.text] token:self.imageToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"resp == %@",resp);
        NSLog(@"info == %@",info);
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setStatus:@"请稍候..."];
    } option:imageOption];
    [upManager putPHAssetResource:array[1] key:[NSString stringWithFormat:@"%@.mov",self.fillKey.text] token:self.vedioToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"resp == %@",resp);
        NSLog(@"info == %@",info);
        self.persistentId = resp[@"persistentId"];
        self.transformTime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getMp4AndM3u8FileName) userInfo:nil repeats:YES];
    } option:vedioOption];
    
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

- (void)getMp4AndM3u8FileName
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager POST:[NSString stringWithFormat:@"http://api.qiniu.com/status/get/prefop?id=%@",self.persistentId] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responseObject  ==  %@",responseObject);
        if ([responseObject[@"code"] intValue] == 0) {
            NSString * FilesNames = [NSString stringWithFormat:@"mp4:%@\nm3u8:%@",responseObject[@"items"][0][@"key"],responseObject[@"items"][1][@"key"]];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"视频转换名称" message:FilesNames delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [self.transformTime invalidate];
            [SVProgressHUD dismiss];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error ======  %@", error);
    }];
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
