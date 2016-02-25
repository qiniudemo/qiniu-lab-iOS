//
//  QN_LivePhotoVC.h
//  QNAaronTest
//
//  Created by   何舒 on 16/2/25.
//  Copyright © 2016年   何舒. All rights reserved.
//

#import "BaseVC.h"

@interface QN_LivePhotoVC : BaseVC<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIImageView * uploadImage;
@property (weak, nonatomic) IBOutlet UIProgressView *prograssView;
@property (weak, nonatomic) IBOutlet UITextField *fillKey;

@end
