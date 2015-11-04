//
//  HTTPRequestPost.m
//  HTTPRequest
//
//  Created by kn on 14/11/19.
//  Copyright (c) 2014年 kn. All rights reserved.
//

#import "HTTPRequestPost.h"
#import "content.h"
#import "Config.h"
#import "SVProgressHUD.h"


@implementation HTTPRequestPost

-(id)init
{
    self=[super init];
    if(self)
    {
        self.AFAppDotNetClient=[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:URL_HFB]];
        DebugLog(@"%@",URL_HFB);
    }
    return self;
}

/**
 *  普通的网络请求
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
+(void)hTTPRequest_PostpostBody:(NSDictionary *)body andUrl:(NSString *)url andSucceed:(Succeed)succeed andFailure:(Failure)failure andISstatus:(BOOL)isStatus;
{
    
    DebugLog(@"%@",body);
    
    HTTPRequestPost *httpRequestPost=[[HTTPRequestPost alloc] init];
    
    [httpRequestPost setconManagefiguration];
    
    if(isStatus)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setStatus:@"请稍候..."];
    }
    
    
    [httpRequestPost.AFAppDotNetClient POST:url parameters:body success:^(NSURLSessionDataTask *task, id responseObject) {
        DebugLog(@"%@",responseObject);
        
//        if([[responseObject objectForKey:@"stat"] isEqualToString:@"ok"])
//        {
            succeed(task,responseObject);
            return ;
//        }
//
//        if([responseObject[@"code"] isEqualToString:@"1000"]&&[responseObject[@"stat"] isEqualToString:@"fail"])
//        {
//            if([url isEqualToString:@"user/logout"])
//            {
//                succeed(task,responseObject);
//                [SVProgressHUD showSuccessWithStatus:@"退出成功"];
//                return;
//            }
////            succeed(task,responseObject);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"HTTPRequestPost" object:responseObject];
////            [SVProgressHUD showAlterMessage:@"您的账户已在别处登录,请您重新登录"];
//            [SVProgressHUD dismiss];
//            return;
//        }
//        
//        if([[responseObject objectForKey:@"stat"] isEqualToString:@"fail"])
//        {
//            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
//            //            succeed(task,responseObject);
//            return;
//        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
}
/**
 *  上传图片
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
+(void)hTTPRequest_ImageWithUrl:(NSString *)url postParam:(NSDictionary *)postParam image:(NSString *)imageName success:(Succeed)block error:(Failure)blockError;
{
    HTTPRequestPost *httpRequestPost=[[HTTPRequestPost alloc] init];
    
    [httpRequestPost setconManagefiguration];
    
    [httpRequestPost requestWithUrl:url withImage:imageName fileName:nil postParam:postParam Block:block Error:blockError];
}

/**
 *  上传文件
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
+(void) requestUpdataFileWithUrl:(NSString *)url postParam:(NSDictionary *)postParam file:(NSString *)fileName success:(Succeed)block error:(Failure)blockError;
{
    HTTPRequestPost *httpRequestPost=[[HTTPRequestPost alloc] init];
    
    
    [httpRequestPost requestWithUrl:url withImage:nil fileName:fileName postParam:postParam Block:block Error:blockError];
}

-(void)requestWithUrl:(NSString *)url withImage:(NSString *)imageName  fileName:(NSString *)fileName  postParam:(NSDictionary *) postParam Block:(Succeed)block Error:(Failure)blockError
{
    if(IOS7_OR_LATER)
    {
        /**
         *  上传图片
         */
        dispatch_queue_t urls_queue = dispatch_queue_create("blog.devtang.com", NULL);
        dispatch_async(urls_queue, ^{
            
            if (imageName) {
                UIImage *imageNew = [UIImage imageWithContentsOfFile:imageName];
//                UIImage *imageNew = [UIImage imageNamed:imageName];
                //设置image的尺寸
                NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.2);
                
                [self.AFAppDotNetClient POST:url parameters:postParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    //upload
                    [formData appendPartWithFileData :imageData name:@"upload" fileName:imageName mimeType:@"image/jpeg"];
                } success:^(NSURLSessionDataTask *task, id responseObject) {
                    block(task,responseObject);
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    blockError(task,error);
                    
                }];
    
                return;
            }
        });
        
        /**
         *  上传文件
         */
        if (fileName) {
            NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
            
            NSURLSessionUploadTask *uploadTask = [self.AFAppDotNetClient uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                
            }];
            
            [AFAppDotNetAPIClient sharedClient];
            
            
            [uploadTask resume];
            return;
        }
    }
}


/**
 *  普通的网络GET请求
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
+(void)hTTPRequest_GetpostBody:(NSDictionary *)body andUrl:(NSString *)url andSucceed:(Succeed)succeed andFailure:(Failure)failure andISstatus:(BOOL)isStatus;
{
    
    DebugLog(@"%@",body);
    
    HTTPRequestPost *httpRequestPost=[[HTTPRequestPost alloc] init];
    
    [httpRequestPost setconManagefiguration];
    
    if(isStatus)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setStatus:@"请稍候..."];
    }
    
    
    [httpRequestPost.AFAppDotNetClient GET:url parameters:body success:^(NSURLSessionDataTask *task, id responseObject) {
        DebugLog(@"%@",responseObject);
        succeed(task,responseObject);
        return ;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure(task,error);
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
}


#pragma mark------------------------------------配置------------------------------------------------------
/**
 *  AFHTTPSessionManager 配置
 */
-(void)setconManagefiguration
{

    
    self.AFAppDotNetClient.requestSerializer = [AFJSONRequestSerializer serializer];
    
    self.AFAppDotNetClient.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self.AFAppDotNetClient.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
    [self.AFAppDotNetClient.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
    [self.AFAppDotNetClient.requestSerializer setTimeoutInterval:10];
    
}
#pragma 但电灯路
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HTTPRequestPost" object:self];
        [SVProgressHUD dismiss];
        NSLog(@"确定");
    }else
    {
        NSLog(@"取消");
    }
}
@end
