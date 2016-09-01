//
//  NSString+ZYAccessPath.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "NSString+ZYAccessPath.h"

@implementation NSString (ZYAccessPath)

- (pathBlock)cachePath
{
    return ^{
        return [kCachePath stringByAppendingPathComponent:self];
    };
}

- (pathBlock)documentPath
{
    return ^{
        return [kDocumentPath stringByAppendingPathComponent:self];
    };
}

- (pathBlock)tmpPath
{
    return ^{
        return [kTmpPath stringByAppendingPathComponent:self];
    };
}

- (pathBlock)libraryPath
{
    return ^{
        return [kLibraryPath stringByAppendingPathComponent:self];
    };
}

@end
