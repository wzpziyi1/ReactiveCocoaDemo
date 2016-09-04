//
//  ZYRequestHander.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/2.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYRequestHander.h"
#import "ZYHttpClient.h"
#import "ZYUrlAccessUtil.h"

@interface ZYRequestHander()
@property (nonatomic, strong) ZYHttpClient *client;
@end


static id _install = nil;
@implementation ZYRequestHander
+ (instancetype)shareHander
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (_install == nil)
        {
            _install = [[self alloc] init];
        }
        
    });
    return _install;
}

- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

/**
 *  字典参数的get请求
 *
 */
- (void)executeGetRequestWithURL:(NSString *)urlStr params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailedBlock)failure
{
    [self executeRequestWithUrl:urlStr method:ZYHttpClientTypeGet success:^(id obj) {
        if(success)
        {
            success(obj);
        }
    } failure:^(id obj) {
        if(failure)
        {
            failure(obj);
        }
    }];
}

//带缓存的get请求
-(void)executeGetRequestWithURL:(NSString *)urlStr cacheMark:(NSString *)cacheMark cache:(CacheBlock)cache success:(SuccessBlock)success failure:(FailedBlock)failure
{
    NSData *cacheData = nil;
    
    if (cacheMark)
    {
        cacheData = [ZYUrlAccessUtil readDataFromFileByUrl:urlStr];
    }
    
    if (cacheData)
    {
        id responseObject = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        
        if (responseObject)
        {
            @try {
                
                NSString *request = [responseObject objectForKey:@"request"];
                NSString *error_code = [responseObject objectForKey:@"error_code"];
                NSString *error = [responseObject objectForKey:@"error"];
                
                if (error == nil || error.length == 0)
                {
                    if (cache)
                    {
                        cache(responseObject);
                    }
                    
                }
                else
                {
                    if (failure)
                    {
                        NSDictionary *errDic = @{@"error_code": error_code,
                                                 @"error":error,
                                                 @"request":request};
                        failure(errDic);
//                        ZYLog(@"返回会的数据是  is %@",error);
                    }
                }
                
            } @catch (NSException *exception) {
                if (success)
                {
                    success(responseObject);
                }
            } @finally {
                
            }
            
        }
        
    }
    
    [self.client requestWithPath:urlStr method:ZYHttpClientTypeGet parameters:nil prepareExecute:^{
        //
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //服务端返回成功，返回数据，否则返回异常信息
        if (responseObject)
        {
            @try {
                
                //做缓存,在返回正确地请求数据之后
                NSData *cacheData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                [ZYUrlAccessUtil saveUrl:[NSString stringWithFormat:@"%@",cacheMark] withData:cacheData];
                
                NSString *request = [responseObject objectForKey:@"request"];
                NSString *error_code = [responseObject objectForKey:@"error_code"];
                NSString *error = [responseObject objectForKey:@"error"];
                
                if (error == nil || error.length == 0)
                {
                    if (success)
                    {
                        success(responseObject);
                    }
                }
                else
                {
                    
                    if (failure)
                    {
                        NSDictionary *errDic = @{@"error_code": error_code,
                                                 @"error":error,
                                                 @"request":request};
                        failure(errDic);
                    }
                    
                }
            } @catch (NSException *exception) {
                if (success)
                {
                    success(responseObject);
                }
            } @finally {
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        if (failure)
        {
            NSDictionary *errDic = @{@"error":@"网络异常"};
            failure(errDic);
        }
    }];
    
    
}




//带url和参数封装的post
- (void)executePostRequestWithURL:(NSString *)urlStr params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailedBlock)failure
{
    
    [self.client requestWithPath:urlStr method:ZYHttpClientTypePost parameters:params prepareExecute:^{
        //
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //服务端返回成功，返回数据，否则返回异常信息
        if (responseObject)
        {
            
            @try {
                NSString *request = [responseObject objectForKey:@"request"];
                NSString *error_code = [responseObject objectForKey:@"error_code"];
                NSString *error = [responseObject objectForKey:@"error"];
                if (error == nil || error.length == 0)
                {
                    if (success)
                    {
                        
                        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
                        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        ZYLog(@"返回会的数据是  is %@",str);
                        success(responseObject);
                    }
                }
                else
                {
                    if (failure)
                    {
                        NSDictionary *errDic = @{@"error_code": error_code,
                                                 @"error":error,
                                                 @"request":request};
                        ZYLog(@"返回会的数据是  is %@",error);
                        failure(errDic);
                    }
                }
                
            } @catch (NSException *exception) {
                if (success)
                {
                    success(responseObject);
                }
            } @finally {
                
            }
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        
        if (failure) {
            NSDictionary *errDic = @{@"error":@"当前网络不通畅,请重试"};
            ZYLog(@"返回会的数据是  is %@",[error localizedDescription]);
            failure(errDic);
            
        }
    }];
}

//图片上传
- (void)uploadImageWithURL:(NSString *)urlString parameters:(id)parameters image:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName success:(void(^)(id obj))success failure:(void(^)(id obj))failure
{
    [self.client uploadWithURL:urlString parameters:parameters image:image name:name fileName:fileName success:^(id responseObject) {
        
        //服务端返回成功，返回数据，否则返回异常信息
        if (responseObject)
        {
            @try {
                
                NSString *request = [responseObject objectForKey:@"request"];
                NSString *error_code = [responseObject objectForKey:@"error_code"];
                NSString *error = [responseObject objectForKey:@"error"];
                
                if (error == nil || error.length == 0)
                {
                    if (success)
                    {
                        success(responseObject);
                    }
                }
                else
                {
                    if (failure)
                    {
                        
                        NSDictionary *errDic = @{@"error_code": error_code,
                                                 @"error":error,
                                                 @"request":request};
                        failure(errDic);
                    }
                }
                
            } @catch (NSException *exception) {
                if (success)
                {
                    success(responseObject);
                }
            } @finally {
                
            }
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark ----private
//无缓存
-(void)executeRequestWithUrl:(NSString *)urlStr method:(NSInteger)method success:(SuccessBlock)success failure:(FailedBlock)failure
{
    
    
    [self.client requestWithPath:urlStr method:method parameters:nil prepareExecute:^{
        //
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //服务端返回成功，返回数据，否则返回异常信息
        if (responseObject)
        {
            @try {
                
                NSString *request = [responseObject objectForKey:@"request"];
                NSString *error_code = [responseObject objectForKey:@"error_code"];
                NSString *error = [responseObject objectForKey:@"error"];
                
                if (error == nil || error.length == 0)
                {
                    if (success)
                    {
                        success(responseObject);
                    }
                }
                else
                {
                    if (failure)
                    {
                        
                        NSDictionary *errDic = @{@"error_code": error_code,
                                                 @"error":error,
                                                 @"request":request};
                        failure(errDic);
                    }
                }
                
            } @catch (NSException *exception) {
                if (success)
                {
                    success(responseObject);
                }
            } @finally {
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        if (failure) {
            NSDictionary *errDic = @{@"error":@"当前网络不通畅,请重试"};
            failure(errDic);
        }
    }];
    
}


#pragma mark ----getter && setter
- (ZYHttpClient *)client
{
    if (_client == nil)
    {
        _client = [ZYHttpClient shareClient];
    }
    return _client;
}
@end
