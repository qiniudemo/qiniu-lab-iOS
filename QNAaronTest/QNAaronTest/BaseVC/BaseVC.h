//
//  BaseVC.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/13.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QiniuSDK.h>

@interface BaseVC : UIViewController

@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * domain;

@property (nonatomic, assign) float  percentFloat;
@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, strong) NSString * functionTitle;

@end
