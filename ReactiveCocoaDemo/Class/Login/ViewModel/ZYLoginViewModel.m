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
#import "ZYRequestHander.h"
#import "MJExtension.h"

@interface ZYLoginViewModel()
@property (nonatomic, copy) NSString *weiboCode;

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
    ZYWeakSelf;
    [RACObserve(self, weiboCode) subscribeNext:^(id x) {
        
        [self.tokenCommand execute:weakSelf.weiboCode];
    }];
    
    _tokenCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSDictionary *dict = @{@"client_id": kWeiboAppKey,
                               @"client_secret": kWeiboAppSecret,
                               @"grant_type": @"authorization_code",
                               @"code": input,
                               @"redirect_uri": kWeiboCallBack
                               };
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[ZYRequestHander shareHander] executePostRequestWithURL:kApiAccessToken params:dict success:^(id obj) {
                ZYTokenEntity *entity = [ZYTokenEntity mj_objectWithKeyValues:obj];
                [subscriber sendNext:entity];
                [subscriber sendCompleted];
                
            } failure:^(id obj) {
                [subscriber sendNext:obj[@"error"]];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
    
    
    [[_tokenCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        
        if ([x isKindOfClass:[NSString class]])
        {
            [MBProgressHUD showError:x];
        }
        else
        {
            weakSelf.tokenEntity = (ZYTokenEntity *)x;
            [ZYDefaultAccessUtil persistObjAsData:weakSelf.tokenEntity forKey:kTokenEntityKey];
//            [self resetRootVcWithParams:<#(NSDictionary *)#>];
        }
        
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

#pragma mark ----ZYNavigationProtocol

- (void)resetRootVcWithParams:(NSDictionary *)params
{
    
}

@end
