//
//  CF_Network.h
//  Project_Struct
//
//  Created by System Administrator on 3/21/15.
//  Copyright (c) 2015 System Administrator_陈飞. All rights reserved.
//
//typedef void(^Succeed) (NSURLSessionDataTask *task, id responseObject);
//typedef void(^Failure) (NSURLSessionDataTask *task, NSError *error);
#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSHTTPRequestManger.h"
#include "Config.h"
@interface CF_Network : NSObject


+(void)getExecuteWithUrlStr:(NSString *)code Paramters:(NSDictionary *)params showHUD:(BOOL)showHUD  FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure;


+(void)postExecuteWithUrlStr:(NSString *)code Paramters:(NSDictionary *)params showHUD:(BOOL)showHUD FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure;


+(void)executeWithUrlStr_Image:(NSString *)code Paramters:(NSDictionary *)params imagepath:(NSMutableArray*)imageDatasAry FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure;


+(void)executeWithUrlStr_Image_noProgressHUD:(NSString *)code Paramters:(NSDictionary *)params imagepath:(NSMutableArray*)imageDatasAry FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure;


@end
