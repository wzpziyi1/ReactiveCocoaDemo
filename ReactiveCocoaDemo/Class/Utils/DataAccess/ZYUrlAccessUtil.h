//
//  ZYUrlAccessUtil.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYUrlAccessUtil : NSObject

+ (NSData *)readDataFromFileByUrl:(NSString *)urlStr;

+ (void)saveUrl:(NSString *)urlStr withData:(NSData *)data;
@end
