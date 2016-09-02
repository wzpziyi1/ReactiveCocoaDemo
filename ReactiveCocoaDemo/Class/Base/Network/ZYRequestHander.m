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
- (void)executeGetRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    
}

//带缓存的get请求
-(void)executeGetRequestWithURL:(NSString *)url cacheMark:(NSString *)cacheMark cache:(CacheBlock)cache success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSData *cacheData = nil;
    
    if (cacheMark)
    {
        cacheData = [ZYUrlAccessUtil readDataFromFileByUrl:url];
    }
    
    if (cacheData)
    {
        id responseObject = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
        
        if (responseObject)
        {
            if (cache)
            {
                cache(responseObject);
            }
        }
    }
    
    
}




//带url和参数封装的post
- (void)executePostRequestWithURL:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    
}

//图片上传
- (void)uploadImageWithURL:(NSString *)urlString parameters:(id)parameters image:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName success:(void(^)(id obj))success failure:(void(^)(id obj))failure
{
    
}

#pragma mark ----private
//无缓存
-(void)executeRequestWithUrl:(NSString *)url method:(NSInteger)method success:(SuccessBlock)success failed:(FailedBlock)failed
{
    
    
    [self.client requestWithPath:url method:method parameters:nil prepareExecute:^{
        //
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //服务端返回成功，返回数据，否则返回异常信息
        if (responseObject)
        {
            @try {
                
                NSInteger errCode = [[responseObject objectForKey:@"errCode"] integerValue];
                NSString *error = [responseObject objectForKey:@"error"];
                
                if (errCode == 0)
                {
                    if (success)
                    {
                        id obj = [responseObject objectForKey:@"data"];
                        success(obj);
                    }
                }
                else
                {
                    if (failed)
                    {
                        id obj = [responseObject objectForKey:@"data"];
                        
                        NSDictionary *errDic = @{@"errCode":[NSNumber numberWithInteger:errCode],
                                                 @"error":error,
                                                 @"data":obj};
                        failed(errDic);
                    }
                }
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        if (failed) {
            NSDictionary *errDic = @{@"error":@"当前网络不通畅,请重试"};
            failed(errDic);
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
