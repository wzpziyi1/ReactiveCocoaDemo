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
    
    ZYTokenEntity *entity = [ZYDefaultAccessUtil objectFromDataWithKey:kTokenEntityKey];
    
    if (entity && [entity isTokenUseable])
    {
        return YES;
    }
    
    return NO;
}

@end
