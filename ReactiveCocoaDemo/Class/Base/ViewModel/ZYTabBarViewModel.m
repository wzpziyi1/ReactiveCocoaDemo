//
//  ZYTabBarViewModel.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/5.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYTabBarViewModel.h"
#import "ZYVcSettingEntity.h"
#import "MJExtension.h"

@implementation ZYTabBarViewModel
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
    
    [self dealupVcSettings];
}

#pragma mark ----private
- (void)dealupVcSettings
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MainVCSettings.json" ofType:nil];
    
    NSData *settingData = [[NSData alloc] initWithContentsOfFile:path];
    
    NSArray *settingArr = [NSJSONSerialization JSONObjectWithData:settingData options:NSJSONReadingMutableContainers error:nil];
    
    _vcSettings = [ZYVcSettingEntity mj_objectArrayWithKeyValuesArray:settingArr];
}

@end
