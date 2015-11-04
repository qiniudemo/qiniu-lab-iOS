//
//  uploadAlassetImage.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/14.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "BaseVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface uploadAlassetImage : BaseVC<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *takePhotoBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *prograssView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;

@property (nonatomic, strong) NSString * functionTitle;
@end
