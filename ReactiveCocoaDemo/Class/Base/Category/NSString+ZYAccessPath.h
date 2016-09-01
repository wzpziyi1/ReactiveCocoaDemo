//
//  NSString+ZYAccessPath.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *(^pathBlock)();

@interface NSString (ZYAccessPath)
- (pathBlock)cachePath;

- (pathBlock)documentPath;

- (pathBlock)tmpPath;

- (pathBlock)libraryPath;
@end
