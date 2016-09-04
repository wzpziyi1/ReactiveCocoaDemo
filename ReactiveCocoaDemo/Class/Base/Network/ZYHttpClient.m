//
//  ZYHttpClient.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/2.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYHttpClient.h"
#import "AFNetworking.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>

@interface ZYHttpClient()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

static id _install = nil;
@implementation ZYHttpClient
+ (instancetype)shareClient
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
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.weibo.com/"]];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"application/json", nil];
        
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = 10;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        //添加http的header
        [self.manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        NSString *userAgent=[NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleNameKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
        
        //拼接客户端相关信息
        [self.manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
        
        AFSecurityPolicy *securityPolicy=[AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates=YES;
        securityPolicy.validatesDomainName = NO;
        self.manager.securityPolicy=securityPolicy;
        
    }
    return self;
}

- (void)requestWithPath:(NSString *)urlStr method:(ZYHttpClientType)method parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepare success:(void(^)(NSURLSessionDataTask *task,id responseObject))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
{
    if ([self isConnectionAvailable])
    {
        
        if (prepare)
        {
            prepare();
        }
        
        switch (method)
        {
                
            case ZYHttpClientTypeGet:
            {
                [self.manager GET:urlStr parameters:parameters progress:nil success:success failure:failure];
            }
            break;
                
            case ZYHttpClientTypePost:
            {
                [self.manager POST:urlStr parameters:parameters progress:nil success:success failure:failure];
            }
            break;
                
            case ZYHttpClientTypePut:
            {
                [self.manager PUT:urlStr parameters:parameters success:success failure:failure];
            }
            break;
                
            case ZYHttpClientTypeDelect:
            {
                [self.manager DELETE:urlStr parameters:parameters success:success failure:failure];
            }
            break;
                
            default:
                break;
        }
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkErrorNotification object:nil];
    }
}

- (void)requestWithPathInHEAD:(NSString *)urlStr
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([self isConnectionAvailable])
    {
        
        [self.manager HEAD:urlStr parameters:parameters success:success failure:failure];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkErrorNotification object:nil];
    }
}

- (void)uploadWithURL:(NSString *)urlStr
           parameters:(id)parameters
                image:(UIImage *)image
                 name:(NSString *)name
             fileName:(NSString *)fileName
              success:(void(^)(id responseObject))success
              failure:(void(^)(NSError *error))failure
{
    [self.manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *mimeType = @"image/jpg";
        
        /**
         拼接data到 HTTP body
         mimeType JPG:image/jpg, PNG:image/png, JSON:application/json
         */
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

//看看网络是不是给力
- (BOOL)isConnectionAvailable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        ZYLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark ----getter && setter




@end
