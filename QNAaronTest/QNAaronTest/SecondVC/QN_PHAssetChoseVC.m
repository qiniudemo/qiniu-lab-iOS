//
//  QN_PHAssetChoseVC.m
//  QNAaronTest
//
//  Created by   何舒 on 15/10/26.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "QN_PHAssetChoseVC.h"

@interface QN_PHAssetChoseVC ()

@property (nonatomic, strong) PHFetchResult *allPhotos;

@end

@implementation QN_PHAssetChoseVC

static NSString * const CellReuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
//    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
//    self.allPhotos = [PHAsset fet]
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"QN_PHAssetCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellReuseIdentifier];
    
    [self.collectionView reloadData];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allPhotos.count;
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kDeviceWidth/5, kDeviceWidth/5);
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QN_PHAssetCollectionViewCell * cell = (QN_PHAssetCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    PHAsset * asset = self.allPhotos[indexPath.item];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        cell.representedAssetIdentifier = asset.localIdentifier;
        
        
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:CGSizeMake(kDeviceWidth/5, kDeviceWidth/5)
                                                  contentMode:PHImageContentModeAspectFill
                                                      options:nil
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    // Set the cell's thumbnail image if it's still showing the same asset.
                                                    if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                                        cell.photoImageView.image = result;
                                                        cell.videoTime.hidden = YES;
                                                    }
                                                }];
    }
    else
    {
        PHVideoRequestOptions *request = [PHVideoRequestOptions new];
        request.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        request.version = PHVideoRequestOptionsVersionCurrent;
        
        [[PHImageManager defaultManager] requestAVAssetForVideo:asset
                                                        options:request
                                                  resultHandler:
         ^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
             AVURLAsset *urlAsset = (AVURLAsset *)asset;
             AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];
             
             gen.appliesPreferredTrackTransform = YES;
             CMTime time = CMTimeMakeWithSeconds(0.0, 600);
             
             NSError *error = nil;
             
             CMTime actualTime;
             
             CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
             
             cell.photoImageView.image = [[UIImage alloc] initWithCGImage:image];
         }];
        cell.videoTime.hidden = NO;
        cell.videoTime.text = [NSString stringWithFormat:@"%f",asset.duration];
    }

    return cell;
}


#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    PHAsset * asset = self.allPhotos[indexPath.item];
    self.assets(asset);
    [self.navigationController popViewControllerAnimated:YES];
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)getPHAssetFromPH:(asset)GetPHAssetblock
{
    self.assets = GetPHAssetblock;
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
