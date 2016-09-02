//
//  ZYHttpClient.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/2.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZYHttpClientType){
    ZYHttpClientTypeGet,
    ZYHttpClientTypePost,
    ZYHttpClientTypePut,
    ZYHttpClientTypeDelect
};

/**
 *  请求开始前预处理Block
 */
typedef void(^PrepareExecuteBlock)(void);

@interface ZYHttpClient : NSObject
+ (instancetype)shareClient;

/**
 *  HTTP请求（GET、POST、DELETE、PUT）
 *  @param path
 *  @param method      RESTFul请求类型
 *  @param parameters  请求参数
 *  @param prepare     请求前预处理块
 *  @param success     请求成功处理块
 *  @param failure     请求失败处理块
 */

//NSURLSessoin，iOS7.0之后
- (void)requestWithPath:(NSString *)urlStr method:(ZYHttpClientType)method parameters:(id)parameters prepareExecute:(PrepareExecuteBlock)prepare success:(void(^)(NSURLSessionDataTask *task,id responseObject))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;


/**
 *  HTTP请求（HEAD）
 
 *  @param path
 *  @param parameters
 *  @param success
 *  @param failure
 */
- (void)requestWithPathInHEAD:(NSString *)urlStr
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  图片上传方法
 *
 *  @param URL        请求url
 *  @param parameters 需要的参数
 *  @param image      上传的图片
 *  @param name       上传到服务器中接受该文件的字段名，不能为空
 *  @param fileName   存到服务器中的文件名，不能为空
 *  @param mimeType   要上传的文件类型，JPG:image/jpg, PNG:image/png, JSON:application/json
 */
- (void)uploadWithURL:(NSString *)urlStr
           parameters:(id)parameters
                image:(UIImage *)image
                 name:(NSString *)name
             fileName:(NSString *)fileName
              success:(void(^)(id responseObject))success
              failure:(void(^)(NSError *error))failure;


//看看网络是不是给力
- (BOOL)isConnectionAvailable;
@end
