//
//  QN_PHAssetCollectionViewCell.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/23.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QN_PHAssetCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;
@property (nonatomic, weak) IBOutlet UILabel *videoTime;

@property (nonatomic, copy) NSString *representedAssetIdentifier;
@end
