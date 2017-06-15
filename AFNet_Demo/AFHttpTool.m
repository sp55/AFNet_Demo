//
//  AFHttpTool.m
//  AFNet_Demo
//
//  Created by admin on 2017/6/15.
//  Copyright © 2017年 AlezJi. All rights reserved.
//

#import "AFHttpTool.h"


#define DemoServer @"http://api.sealtalk.im/" //线上正式环境

@implementation AFHttpTool


+ (AFHttpTool *)shareInstance {
    static AFHttpTool *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (void)requestWihtMethod:(RequestMethodType)methodType
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:20];
    
    
    switch (methodType) {
        case RequestMethodTypeGet: {
            // GET请求
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                //通讯协议状态码
                NSInteger statusCode = response.statusCode;
                NSLog(@"====%ld",statusCode);
                if (statusCode==200) {
                    //[SVProgressHUD showWithStatus:@"请求成功"];
                    [SVProgressHUD showSuccessWithStatus:@"请求成功"];
                    [SVProgressHUD dismissWithDelay:2 completion:^{
                        success(responseObject);
                    //[SVProgressHUD showSuccessWithStatus:@"请求成功"];
                    }];
                    //[SVProgressHUD dismiss];
                }
                //NSLog(@"===%@",responseObject[]);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                //通讯协议状态码
                NSInteger statusCode = response.statusCode;
                
                if (statusCode>400&&statusCode<500) {
                    [SVProgressHUD showErrorWithStatus:@"请求错误"];
                    [SVProgressHUD dismissWithDelay:2 completion:^{
                        failure(error);
                    }];
                }
                
               else if (statusCode>500) {
                    [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                    [SVProgressHUD dismissWithDelay:2 completion:^{
                        failure(error);
                    }];
                }

            }];
            
        } break;
        case RequestMethodTypePost: {
          // POST请求
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                //通讯协议状态码
                NSInteger statusCode = response.statusCode;
                if (statusCode==200) {
                    //[SVProgressHUD showWithStatus:@"请求成功"];
                    [SVProgressHUD showSuccessWithStatus:@"请求成功"];
                    [SVProgressHUD dismissWithDelay:2 completion:^{
                        success(responseObject);
                    }];
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                //通讯协议状态码
                NSInteger statusCode = response.statusCode;
                
                if (statusCode>400&&statusCode<500) {
                    [SVProgressHUD showErrorWithStatus:@"请求错误"];
                    [SVProgressHUD dismissWithDelay:2 completion:^{
                        failure(error);
                    }];
                }
                
                else if (statusCode>500) {
                    [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                    [SVProgressHUD dismissWithDelay:2 completion:^{
                        failure(error);
                    }];
                }
            }];
            }
            
    }
    
}

@end
