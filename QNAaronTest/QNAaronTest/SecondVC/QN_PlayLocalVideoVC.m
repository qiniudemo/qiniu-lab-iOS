//
//  QN_PlayLocalVideoVC.m
//  QNAaronTest
//
//  Created by   何舒 on 15/10/20.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "QN_PlayLocalVideoVC.h"
#import <MediaPlayer/MediaPlayer.h>

@interface QN_PlayLocalVideoVC ()

//视频播放器
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (strong, nonatomic) NSString * mediaUrl;

@end

@implementation QN_PlayLocalVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)choseVideoAction:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)previewViewAction:(id)sender
{
    if (!self.mediaUrl) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"还未选择视频" message:@"请点击“选择”选择需要播放的视频" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else
    {
        self.player = [[MPMoviePlayerController alloc]initWithContentURL:self.mediaUrl];
        self.player.shouldAutoplay = NO;
        self.previewImageView.image = [self.player thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    }
}

- (IBAction)playAction:(id)sender
{
//    self.player = [ [MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:self.mediaUrl]];
    self.playBtn.hidden = YES;
    //1设置播放器的大小
    [self.player.view setFrame:self.previewImageView.frame];
    //2将播放器视图添加到根视图
    [self.view addSubview:self.player.view];
    //2 监听播放完成
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishedPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //4播放
    [self.player play];
}

//通知视频播放完成
- (void)finishedPlay
{
    [self.player stop];
    self.playBtn.hidden = NO;
    [self.player.view removeFromSuperview];
}

//再调用以下委托：
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.mediaUrl = [info valueForKey:UIImagePickerControllerMediaURL];
    [picker dismissModalViewControllerAnimated:YES];
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
