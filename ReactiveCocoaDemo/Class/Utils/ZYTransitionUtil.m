//
//  ZYTransitionUtil.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/13.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYTransitionUtil.h"
#import "ZYBaseTabBarVc.h"
#import "ZYNewFeatureVc.h"
#import "ZYLoginVc.h"

@implementation ZYTransitionUtil
+ (void)startNewFeatureWithMainWindow:(UIWindow *)window params:(NSDictionary *)params
{
    ZYNewFeatureVc *vc = [ZYNewFeatureVc viewController];
    window.rootViewController = vc;
}

+ (void)startTabBarWithMainWindow:(UIWindow *)window params:(NSDictionary *)params
{
    ZYBaseTabBarVc *vc = [[ZYBaseTabBarVc alloc] init];
    window.rootViewController = vc;
}

+ (void)startLoginVcWithBaseVc:(ZYBaseViewController *)baseVc params:(NSDictionary *)params completion:(emptyBlock)completion animated:(BOOL)animated
{
    
    ZYLoginVc *vc = [ZYLoginVc viewController];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [baseVc presentViewController:nvc animated:animated completion:completion];
}

@end
