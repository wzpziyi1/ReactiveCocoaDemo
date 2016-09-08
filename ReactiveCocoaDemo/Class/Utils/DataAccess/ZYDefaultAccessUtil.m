//
//  ZYDefaultAccessUtil.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYDefaultAccessUtil.h"

static NSUserDefaults *_userDefault = nil;

@implementation ZYDefaultAccessUtil

+ (void)load
{
    _userDefault = [NSUserDefaults standardUserDefaults];
}

+ (void)saveValue:(id)value forKey:(NSString *)key
{
    [_userDefault setObject:value forKey:key];
    
    [_userDefault synchronize];
}

+ (id)valueForKey:(NSString *)key
{
    return [_userDefault objectForKey:key];
}

+ (BOOL)boolValueWithKey:(NSString *)key
{
    return [_userDefault boolForKey:key];
}

+ (void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    [_userDefault setBool:value forKey:key];
    [_userDefault synchronize];
}

+ (NSInteger)integerValueWithKey:(NSString *)key
{
    return [_userDefault integerForKey:key];
}

+ (void)saveIntegerValue:(NSInteger)value withKey:(NSString *)key
{
    [_userDefault setInteger:value forKey:key];
    [_userDefault synchronize];
}

+ (void)removeValueWithKey:(NSString *)key
{
    [_userDefault removeObjectForKey:key];
    [_userDefault synchronize];
}

+ (void)print
{
    NSDictionary *dict = [_userDefault dictionaryRepresentation];
    ZYLog(@"%@", dict);
}

#pragma mark - UserDefaults存自定义对象
+ (void)persistObjAsData:(id)encodableObject forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:encodableObject];
    [_userDefault setObject:data forKey:key];
    [_userDefault synchronize];
}

+ (id)objectFromDataWithKey:(NSString*)key
{
    NSData *data = [self valueForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
