//
//  QN_uploadFileWithParams.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/18.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BaseVC.h"

@interface QN_uploadFileWithParams : BaseVC<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIImageView * uploadImage;
@property (weak, nonatomic) IBOutlet UIProgressView *prograssView;
@property (weak, nonatomic) IBOutlet UITextField *fillKey;
@property (weak, nonatomic) IBOutlet UITextField *fillParam1;
@property (weak, nonatomic) IBOutlet UITextField *fillParam2;


@end
