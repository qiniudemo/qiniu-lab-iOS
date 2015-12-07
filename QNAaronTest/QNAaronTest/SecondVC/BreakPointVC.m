//
//  BreakPointVC.m
//  QNAaronTest
//
//  Created by   何舒 on 15/10/16.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BreakPointVC.h"

@interface BreakPointVC ()

@property (nonatomic, strong) QNUploadManager * upManager;
@property (nonatomic, assign) BOOL isStop;
@property (nonatomic, strong) UIImage * pickImage;
@end

@implementation BreakPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.uploadImage.contentMode = UIViewContentModeScaleAspectFit;
    self.showLabel.hidden = YES;
    
    self.prograssView.hidden = YES;
    self.prograssView.progress = 0.0f;
    
    self.upManager = [[QNUploadManager alloc] init];
    
    self.isStop = NO;
}

-(void)getTokenFromQN
{
    [HTTPRequestPost hTTPRequest_GetpostBody:nil andUrl:@"api/resumable_upload/without_key_upload_token.php" andSucceed:^(NSURLSessionDataTask *task, id responseObject) {
        self.token = responseObject[@"uptoken"];
//        [self getImagePath:self.pickImage];
        [self uploadImageToQNFilePath];
    } andFailure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ======  %@", error);
    } andISstatus:nil];
}
- (IBAction)choseAction:(id)sender {
    [self gotoImageLibrary];
}

- (IBAction)uploadAction:(id)sender {
    
    self.showLabel.hidden = NO;
    self.prograssView.hidden = NO;
    [self getTokenFromQN];
    self.isStop = NO;
    
    
}

- (IBAction)stopAction:(id)sender
{
    
    self.showLabel.hidden = YES;
    self.prograssView.hidden = YES;
    self.isStop = YES;
    
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
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.pickImage = image;
    [self getImagePath:self.pickImage];
    [picker dismissModalViewControllerAnimated:YES];
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


//照片获取本地路径转换
- (void)getImagePath:(UIImage *)Image
{
    NSString * filePath = nil;
    NSData * data = nil;
    if (UIImagePNGRepresentation(Image) == nil)
    {
        data = UIImageJPEGRepresentation(Image, 1.0);
    }
    else
    {
        data = UIImagePNGRepresentation(Image);
    }
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * ImagePath = [[NSString alloc]initWithFormat:@"/theFirstImage1.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    //创建存储文件路径的path
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSData * pathData = [ImagePath dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/file.txt"] contents:pathData attributes:nil];
    
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,ImagePath];
    self.uploadImage.image = [[UIImage alloc] initWithContentsOfFile:filePath];
}

-(void)uploadImageToQNFilePath
{
    NSString * token = @"";
    if (!isStringEmpty(self.token)) {
        token = self.token;
    }
    //fileName为key,当上传的文件名字一样时，默认为上传失败
    NSString * document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSError *error;
    QNFileRecorder * file = [QNFileRecorder fileRecorderWithFolder:[document stringByAppendingString: @"/QN_uploadFile"] error:&error];
    
    QNUploadOption * uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        self.percentFloat = percent;
        
    } params:nil checkCrc:NO cancellationSignal:^BOOL () {
        return self.isStop;
    }];
    
    DebugLog(@"file =========== %@",file);
    
    self.upManager = [self.upManager initWithRecorder:file];
    
    NSString * putFilePath = [[NSString alloc]initWithFormat:@"%@/file.txt",document];
    NSData * pathData = [NSData dataWithContentsOfFile:putFilePath];
    NSString * pathfile=[NSString stringWithFormat:@"%@%@",document,[[NSString alloc] initWithData:pathData encoding:NSUTF8StringEncoding]];
    
    [self.upManager putFile:pathfile key:self.fillKey.text token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        NSLog(@"%@/%@",FILE_URL,key);
        [self.uploadImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",FILE_URL,key]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    [self.fillKey resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
    return YES;
    
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
