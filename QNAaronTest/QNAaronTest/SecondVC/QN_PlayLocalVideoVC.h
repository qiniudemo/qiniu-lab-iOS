//
//  QN_PlayLocalVideoVC.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/20.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BaseVC.h"

@interface QN_PlayLocalVideoVC : BaseVC<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton * choseBtn;
@property (nonatomic, weak) IBOutlet UIButton * previewBtn;
@property (nonatomic, weak) IBOutlet UIImageView * previewImageView;
@property (nonatomic, weak) IBOutlet UIButton * playBtn;

@end
