//
//  content.h
//  QNAaronTest
//
//  Created by   何舒 on 15/10/9.
//  Copyright © 2015年   何舒. All rights reserved.
//

//#ifndef content_h
//#define content_h
//
//
//#endif /* content_h */


/**
 *  定义Base_URL
 */
#define SELECT_IP  0
#if SELECT_IP == 0
#define URL_QN @"http://115.231.183.102:9090"

#endif

/**
 *  定义环境参数
 */

#define FILE_URL @"http://7pn64c.com1.z0.glb.clouddn.com"


//获取当前屏幕宽高
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width        //屏幕宽
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height      //屏幕高
//版本
#define kDevice70 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)     //判断系统版本大于7.0
#define kDevice60 ([[[UIDevice currentDevice] systemVersion] doubleValue]<7.0)     //判断系统版本大于7.0
#define kDeviceSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]   //获得系统版本
//字符串空判断
#define kWipeNull(object) (object==[NSNull null]?@"暂无数据":object)
#define kWipeNullKong(object) (object==[NSNull null]?@"":object)
#define kWipeNullKongs(object) ((object==[NSNull null]?@"uploadFile/carlogo/mading.png":object))
//图片字符串判断
#define httpImage(base,string) [string hasPrefix:@"http"]?string:([NSString stringWithFormat:@"%@%@",base,string])
#define REST_API_KEY    @""

#define UMENG_APPKEY    @"4eeb0c7b527015643b000003"

// 网络请求常用
#define kErrorNetWork           @"网络请求出错,请稍后再试"
#define NQ_LOGIN_SUCCESS        @"NQ_LOGIN_SUCCESS"
#define NQ_MESSAGENUM_CHANGE    @"NQ_MESSAGENUM_CHANGE"
#define NQ_LOGOUT               @"NQ_LOGOUT"
#define NQ_ENTERHOME            @"NQ_ENTERHOME"
#define NQ_BADGEADD             @"NQ_BADGEADD"

static inline BOOL isoObjectEmpty(NSObject * proName ){
    
    if ([proName isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}
//判断空
static inline BOOL isStringEmpty(NSString *string){
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}