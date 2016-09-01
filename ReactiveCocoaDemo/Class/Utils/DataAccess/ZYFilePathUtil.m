//
//  ZYFilePathUtil.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYFilePathUtil.h"



@implementation ZYFilePathUtil


+ (NSString *)getRootPath:(ZYFilePathType)type
{
    switch (type) {
        case ZYFilePathTypeDocument:
            return [self documentPath];
            break;
        case ZYFilePathTypeCache:
            return [self cachePath];
            break;
        case ZYFilePathTypeLibrary:
            return [self libraryPath];
            break;
        case ZYFilePathTypeTmp:
            return [self tmpPath];
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
}

+ (NSString *)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)libraryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)tmpPath
{
    return NSTemporaryDirectory();
}

+ (BOOL)fileIsExists:(NSString *)path
{
    if (path == nil || path.length == 0) {
        return false;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+ (NSString *)createFileName:(NSString *)fileName  type:(ZYFilePathType)type context:(NSData *)context
{
    if (fileName == nil || fileName.length == 0) {
        return nil;
    }
    NSString *path = [[self getRootPath:type] stringByAppendingString:fileName];
    if ([self fileIsExists:path]) {
        if (![[NSFileManager defaultManager] removeItemAtPath:path error:nil]) {
            return nil;
        }
    }
    [[NSFileManager defaultManager] createFileAtPath:path contents:context attributes:nil];
    return path;
}
@end
