//
//  ZYHomeViewModel.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/7.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYBaseViewModel.h"

@interface ZYHomeViewModel : ZYBaseViewModel
@property (nonatomic, assign, readonly) BOOL isLogined;

@property (nonatomic, strong, readonly) RACCommand *loadStatusCommand;
@end
