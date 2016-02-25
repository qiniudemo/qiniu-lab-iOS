//
//  QN_PlayVideoVC.m
//  QNAaronTest
//
//  Created by   何舒 on 15/10/19.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "QN_PlayVideoVC.h"
#import <MediaPlayer/MediaPlayer.h>

@interface QN_PlayVideoVC ()
//视频播放器
@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation QN_PlayVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.uploadImage addSubview:self.playBtn];
}
- (IBAction)previewAction:(id)sender {
    if(!self.fillURL.text)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"URL为空！" message:@"请填写视频URL进行播放" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else
    {
        NSString *videoURL = [self transformUrl];
        self.playBtn.hidden = NO;
        self.player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:videoURL]];
        self.player.shouldAutoplay = NO;
        self.uploadImage.image = [self.player thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    }
}
- (IBAction)playAction:(id)sender {
    self.player = [ [MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:[self transformUrl]] ];//远程
    self.playBtn.hidden = YES;
    //1设置播放器的大小
    [self.player.view setFrame:self.uploadImage.frame];
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

//判断是否添加“http://”
- (NSString *)transformUrl
{
    NSString *str = @"http://";
    NSString * urlString;
    if ([self.fillURL.text rangeOfString:str ].location != NSNotFound)
    {
        urlString = self.fillURL.text;
    }else
    {
        urlString = [NSString stringWithFormat:@"http://%@",self.fillURL.text];
    }
    return urlString;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
//当点击键盘上return按钮的时候调用
{
    //代理记录了当前正在工作的UITextField的实例，因此你点击哪个UITextField对象，形参就是哪个UITextField对象
    [textField resignFirstResponder];//键盘回收代码
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
