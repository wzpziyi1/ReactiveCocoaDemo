//
//  ZYLoginViewModel.h.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/3.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLoginViewModel.h"
#import "ZYHttpClient.h"
#import "ZYTokenEntity.h"

@interface ZYLoginViewModel()
@property (nonatomic, copy) NSString *weiboCode;
@property (nonatomic, copy) ZYTokenEntity *tokenEntity;
@end

@implementation ZYLoginViewModel
- (instancetype)initWithUrlStr:(NSString *)urlStr
{
    if (self = [super init])
    {
        _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
        
        [self commitInit];
        
    }
    return self;
}

- (void)commitInit
{
    [RACObserve(self, weiboCode) subscribeNext:^(id x) {
        [_tokenCommand execute:self.weiboCode];
    }];
    
    _tokenCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSDictionary *dict = @{@"client_id": kWeiboAppKey,
                               @"client_secret": kWeiboAppSecret,
                               @"grant_type": @"authorization_code",
                               @"code": input,
                               @"redirect_uri": kWeiboCallBack
                               };
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[ZYHttpClient shareClient] requestWithPath:kApiAccessToken method:ZYHttpClientTypePost parameters:dict prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"%@", str);
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
            return nil;
        }];
    }];
    
    [[_tokenCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        
    }];
    
    [_tokenCommand.executing subscribeNext:^(id x) {
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

- (BOOL(^)(NSString *))isLoadingUrlWithCallbackUrlStr
{
    return ^(NSString *urlStr){
        NSString *str = [NSString stringWithFormat:@"%@?code=",kWeiboCallBack];
        NSRange range = [urlStr rangeOfString:str];
        if (range.length != 0)
        {
            int index = (int)range.location + (int)range.length;
            self.weiboCode = [urlStr substringFromIndex:index];
            return NO;
        }
        return YES;
    };
}
@end
