//
//  ZYHomeViewModel.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/7.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYHomeViewModel.h"
#import "ZYTokenEntity.h"

@implementation ZYHomeViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        [self commitInit];
    }
    return self;
}

- (void)commitInit
{
    
}

- (BOOL)isLogined
{
    id isLogin = [ZYDefaultAccessUtil valueForKey:kIsLogin];
    
    if (isLogin && [isLogin boolValue])
    {
        return YES;
    }
    return NO;
}

@end
