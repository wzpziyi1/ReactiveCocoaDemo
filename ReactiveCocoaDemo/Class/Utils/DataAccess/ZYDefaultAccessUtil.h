//
//  ZYDefaultAccessUtil.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/1.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYDefaultAccessUtil : NSObject

+ (void)saveValue:(id)value forKey:(NSString *)key;

+ (id)valueForKey:(NSString *)key;

+ (BOOL)boolValueWithKey:(NSString *)key;

+ (void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+ (NSInteger)integerValueWithKey:(NSString *)key;

+ (void)saveIntegerValue:(NSInteger)value withKey:(NSString *)key;

+ (void)removeValueWithKey:(NSString *)key;

+ (void)print;

#pragma mark - UserDefaults存自定义对象
+ (void)persistObjAsData:(id)encodableObject forKey:(NSString *)key;

+ (id)objectFromDataWithKey:(NSString*)key;

@end
