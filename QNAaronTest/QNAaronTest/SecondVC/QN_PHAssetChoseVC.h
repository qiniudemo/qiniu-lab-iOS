//
//  QN_PHAssetChoseVC.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/26.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BaseVC.h"
#import "QN_PHAssetCollectionViewCell.h"
#import <Photos/Photos.h>

@interface QN_PHAssetChoseVC : BaseVC<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;

typedef void (^asset) (PHAsset * asset);
@property(nonatomic,copy)asset assets;
- (void)getPHAssetFromPH:(asset)GetPHAssetblock;

@end
