//
//  ZYFilePathUtil.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, ZYFilePathType) {
    ZYFilePathTypeDocument,
    ZYFilePathTypeCache,
    ZYFilePathTypeLibrary,
    ZYFilePathTypeTmp
};

@interface ZYFilePathUtil : NSObject
/**  获取Document路径  */
+ (NSString *)documentPath;
/**  获取Cache路径  */
+ (NSString *)cachePath;
/**  获取Library路径  */
+ (NSString *)libraryPath;
/**  获取Tmp路径  */
+ (NSString *)tmpPath;
/**  此路径下是否有此文件存在  */
+ (BOOL)fileIsExists:(NSString *)path;

/**
 *  创建目录下文件
 *  一般来说，文件要么放在Document,要么放在Labrary下的Cache里面
 *  这里也是只提供这两种存放路径
 *
 *  @param fileName 文件名
 *  @param type     路径类型
 *  @param context  数据内容
 *
 *  @return 文件路径
 */
+ (NSString *)createFileName:(NSString *)fileName  type:(ZYFilePathType)type context:(NSData *)context;
@end
