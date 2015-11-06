//
//  Config.h
//  Project_Struct
//
//  Created by System Administrator on 3/21/15.
//  Copyright (c) 2015 System Administrator_陈飞. All rights reserved.
//

#ifndef Project_Struct_Config_h
#define Project_Struct_Config_h


#endif


#if TARGET_IPHONE_SIMULATOR
#define DebugLog(log, ...) NSLog((@"%s [Line %d] " log), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DebugLog(log, ...) NSLog((@"ipod= %s [Line %d] " log), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif


//#define DebugLog(log, ...) NSLog((@"%s [Line %d] " log), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//获取版本号
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//获取当前屏幕宽高
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width        //屏幕宽
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height      //屏幕高

/*--------------------Iphone5 的判断------------------------------------------------------*/
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/*--------------------ios7 的判断------------------------------------------------------*/
#define IOS8_OR_LATER  [[[UIDevice currentDevice]systemVersion] floatValue] >= 8
#define IOS5 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0f && [[[UIDevice currentDevice] systemVersion] floatValue] < 6.0f)
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_7_DELTA(V,X,Y,W,H) if(IOS7_OR_LATER) {CGRect f = V.frame;f.origin.x += X;f.origin.y += Y;f.size.width +=W;f.size.height += H;V.frame=f;}
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
/*--------------------ios8 的判断------------------------------------------------------*/
//#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
//字体设置判断
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_6_0 // iOS6 and later
#define UITextAlignmentCenter    NSTextAlignmentCenter
#define UITextAlignmentLeft      NSTextAlignmentLeft
#define UITextAlignmentRight     NSTextAlignmentRight
#define UILineBreakModeTailTruncation     NSLineBreakByTruncatingTail
#define UILineBreakModeMiddleTruncation   NSLineBreakByTruncatingMiddle
#endif
//版本
#define kDevice70 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)     //判断系统版本大于7.0
#define kDevice60 ([[[UIDevice currentDevice] systemVersion] doubleValue]<7.0)     //判断系统版本大于7.0
#define kDeviceSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]   //获得系统版本
//字符串空判断
#define kWipeNull(object) (object==[NSNull null]?@"":object)

//设置颜色
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]