//
//  ZYFeatureViewModel.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/9.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYFeatureViewModel.h"

@interface ZYFeatureViewModel()

@end

@implementation ZYFeatureViewModel

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
    NSMutableArray *nameArr = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++)
    {
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        [nameArr addObject:name];
    }
    _imageNames = nameArr;
}



@end
