//
//  QuickVideoVC.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/15.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BaseVC.h"

@interface QuickVideoVC : BaseVC<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIImageView * uploadVideoImage;
@property (weak, nonatomic) IBOutlet UIProgressView *prograssView;

@end
