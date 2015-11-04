//
//  QN_PlayVideoVC.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/19.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BaseVC.h"

@interface QN_PlayVideoVC : BaseVC<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;
@property (weak, nonatomic) IBOutlet UIImageView * uploadImage;
@property (weak, nonatomic) IBOutlet UITextField *fillURL;

@end
