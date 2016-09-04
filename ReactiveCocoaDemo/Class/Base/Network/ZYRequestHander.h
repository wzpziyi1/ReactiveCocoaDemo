//
//  ZYRequestHander.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/2.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
/**
 *  handler处理完后调用的Block
 */
typedef void (^CompleteBlock)();

/**
 *  handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id obj);

/**
 *  handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(id obj);

/**
 *  缓存数据block
 */
typedef void(^CacheBlock)(id obj);

@interface ZYRequestHander : NSObject
+ (instancetype)shareHander;

/**
 *  字典参数的get请求
 *
 */
- (void)executeGetRequestWithURL:(NSString *)urlStr params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailedBlock)failure;

//带缓存的get请求，参数拼接到url后面
-(void)executeGetRequestWithURL:(NSString *)urlStr cacheMark:(NSString *)cacheMark cache:(CacheBlock)cache success:(SuccessBlock)success failure:(FailedBlock)failure;


//带url和参数封装的post
- (void)executePostRequestWithURL:(NSString *)urlStr params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailedBlock)failure;

//图片上传
- (void)uploadImageWithURL:(NSString *)urlString parameters:(id)parameters image:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName success:(void(^)(id obj))success failure:(void(^)(id obj))failure;

@end
