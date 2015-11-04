//
//  CF_Network.m
//  Project_Struct
//
//  Created by System Administrator on 3/21/15.
//  Copyright (c) 2015 System Administrator_陈飞. All rights reserved.
//

#define HS_API_SERVER_URL  @"http://192.168.20.52:8080/hfb/"


#import "CF_Network.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"

@implementation CF_Network
+(void)getExecuteWithUrlStr:(NSString *)code Paramters:(NSDictionary *)params showHUD:(BOOL)showHUD  FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",HS_API_SERVER_URL,code];
    
    if (showHUD) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            int ret=[[responseObject objectForKey:@"Code"] intValue];
            if (ret==0) {//请求成功
                success(responseObject);
                return;
            }
            NSString   *msg=[responseObject objectForKey:@"Message"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:REQUESTERRORMESSAGE];
        if (failure) {
            failure(error);
        }
    }];
}


+(void)postExecuteWithUrlStr:(NSString *)code Paramters:(NSDictionary *)params showHUD:(BOOL)showHUD FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure{
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",HS_API_SERVER_URL,code];
    
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            int ret=[[responseObject objectForKey:@"Code"] intValue];
            if (ret==0) {//请求成功
                success(responseObject);
                return;
            }
            NSString *msg=[responseObject objectForKey:@"Message"];

//            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:REQUESTERRORMESSAGE];
        if (failure) {
            failure(error);
        }
    }];
}


//执行带图片的处理
+(void)executeWithUrlStr_Image:(NSString *)code Paramters:(NSDictionary *)params imagepath:(NSMutableArray*)imageDatasAry FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure
{
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",HS_API_SERVER_URL,code];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSData *imageData in imageDatasAry) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
            return;
        }
//        [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:REQUESTERRORMESSAGE];
        if (failure) {
            failure(error);
        }
        
    }];
}


//执行带图片的处理 无处理状态框
+(void)executeWithUrlStr_Image_noProgressHUD:(NSString *)code Paramters:(NSDictionary *)params imagepath:(NSMutableArray*)imageDatasAry FinishCallbackBlock:(void (^)(id responseObject))success FailureBlock:(void(^)(NSError *error))failure
{
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",HS_API_SERVER_URL,code];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSData *imageData in imageDatasAry) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
            return;
        }
//        [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:REQUESTERRORMESSAGE];
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
