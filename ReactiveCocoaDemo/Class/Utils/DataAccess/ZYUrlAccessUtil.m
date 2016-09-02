//
//  ZYUrlAccessUtil.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYUrlAccessUtil.h"
#import "NSString+Hashing.h"

@implementation ZYUrlAccessUtil
+ (NSData *)readDataFromFileByUrl:(NSString *)url
{
    NSString *md5 = [url MD5Hash];
    NSString *dir = [NSHomeDirectory() stringByAppendingFormat:@"%@",@"/Library/urlCaches"];
    NSString *path = [NSString stringWithFormat:@"%@/%@",dir,md5];
    
    //时间间隔超过了规定时间
    //    if ((now - fileTime) > maxTimeout) {
    //        return nil;
    //    }
    
    return [NSData dataWithContentsOfFile:path];
}

+ (void)saveUrl:(NSString *)url withData:(NSData *)data
{
    NSString *md5 = [url MD5Hash];
    NSString *dir = [NSHomeDirectory() stringByAppendingFormat:@"%@",@"/Library/urlCaches"];
    //DLog(@"缓存数据 dir %@",dir);
    
    [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *path = [NSString stringWithFormat:@"%@/%@",dir,md5];
    //DLog(@"保存数据 path %@",path);
    
    //把NSData写入到文件path中
    [data writeToFile:path atomically:YES];
    
}
@end
