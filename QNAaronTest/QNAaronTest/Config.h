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
//版本
#define kDevice70 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)     //判断系统版本大于7.0
#define kDevice60 ([[[UIDevice currentDevice] systemVersion] doubleValue]<7.0)     //判断系统版本大于7.0
#define kDeviceSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]   //获得系统版本
//字符串空判断
#define kWipeNull(object) (object==[NSNull null]?@"":object)

//设置颜色
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]