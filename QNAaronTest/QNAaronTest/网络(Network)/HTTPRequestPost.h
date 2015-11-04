//
//  HTTPRequestPost.h
//  HTTPRequest
//
//  Created by kn on 14/11/19.
//  Copyright (c) 2014年 kn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFAppDotNetAPIClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSHTTPRequestManger.h"
typedef void(^Succeed) (NSURLSessionDataTask *task, id responseObject);
typedef void(^Failure) (NSURLSessionDataTask *task, NSError *error);



@interface HTTPRequestPost : NSObject<UIAlertViewDelegate>
{
//    AFHTTPClient    *_httpClient;
    NSOperationQueue *_queue;
}
@property(nonatomic,strong)NSString *strUpllod;
@property(nonatomic,copy) void(^succeedBlocks)(NSDictionary *dict);
@property(nonatomic,retain)AFAppDotNetAPIClient *AFAppDotNetClient;


/**
 *  普通的网络请求
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
+(void)hTTPRequest_PostpostBody:(NSDictionary *)body andUrl:(NSString *)url andSucceed:(Succeed)succeed andFailure:(Failure)failure andISstatus:(BOOL)isStatus;

/**
 *  上传图片
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */

+(void)hTTPRequest_ImageWithUrl:(NSString *)url postParam:(NSDictionary *)postParam image:(NSString *)imageName success:(Succeed)block error:(Failure)blockError;

/**
 *  上传文件
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
+(void) requestUpdataFileWithUrl:(NSString *)url postParam:(NSDictionary *)postParam file:(NSString *)fileName success:(Succeed)block error:(Failure)blockError;

/**
 *  普通的网络GET请求
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
+(void)hTTPRequest_GetpostBody:(NSDictionary *)body andUrl:(NSString *)url andSucceed:(Succeed)succeed andFailure:(Failure)failure andISstatus:(BOOL)isStatus;

@end
