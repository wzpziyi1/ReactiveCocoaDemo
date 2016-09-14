//
//  ZYTransitionUtil.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/13.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZYBaseViewController;

typedef void (^emptyBlock)();

@interface ZYTransitionUtil : NSObject
/**
 *  跳转到版本特色界面
 *
 */
+ (void)startNewFeatureWithMainWindow:(UIWindow *)window params:(NSDictionary *)params;

/**
 *  跳转到主界面
 *
 */
+ (void)startTabBarWithMainWindow:(UIWindow *)window params:(NSDictionary *)params;

/**
 *  跳转到登陆界面
 *
 */
+ (void)startLoginVcWithBaseVc:(ZYBaseViewController *)baseVc params:(NSDictionary *)params completion:(emptyBlock)completion animated:(BOOL)animated;
@end
