//
//  QN_UploadHttps.h
//  QNAaronTest
//
//  Created by 何昊宇 on 16/6/21.
//  Copyright © 2016年   何舒. All rights reserved.
//

#import "BaseVC.h"

@interface QN_UploadHttps : BaseVC<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIImageView * uploadImage;
@property (weak, nonatomic) IBOutlet UIProgressView *prograssView;

@end
