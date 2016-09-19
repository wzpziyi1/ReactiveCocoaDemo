//
//  ZYHomeViewModel.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/7.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYHomeViewModel.h"
#import "ZYTokenEntity.h"
#import "ZYRequestHander.h"
#import "ZYStatusEntity.h"

@interface ZYHomeViewModel ()
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int pageSize;

@property (nonatomic, strong, readwrite) NSArray *statusArr;

@property (nonatomic, copy) kBlockNext blockHUD;
@end

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
    @weakify(self);
    self.pageSize = 20;
    self.blockHUD = ^(id x){
        @strongify(self);
        if ([x isKindOfClass:[NSString class]])
        {
            [MBProgressHUD showError:x];
        }
        else
        {
            self.statusArr = x;
        }
    };
    
    _loadStatusCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        
        NSDictionary *dict = @{
                               @"access_token": [ZYDefaultAccessUtil valueForKey:kAccessToken],
                               @"count": @(self.pageSize),
                               @"page": @(1)
                               };
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[ZYRequestHander shareHander] executeGetRequestWithURL:kApiFetchStatus params:dict success:^(id obj) {
                
                
                
                [ZYStatusEntity modelStrWithDict:[obj[@"statuses"] lastObject]];
                
                [subscriber sendNext:obj];
                [subscriber sendCompleted];
            } failure:^(id obj) {
                [subscriber sendNext:obj[@"error"]];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    
    [[_loadStatusCommand.executionSignals switchToLatest] subscribeNext:self.blockHUD];
    
    [[_loadStatusCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue])
        {
            [MBProgressHUD showMessage:@"正在加载..."];
        }
        else
        {
            [MBProgressHUD hideHUD];
        }
    }];
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
