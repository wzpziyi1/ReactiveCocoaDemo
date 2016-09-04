//
//  ZYLoginViewModel.h.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/3.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYBaseViewModel.h"

@class ZYTokenEntity;

@interface ZYLoginViewModel : ZYBaseViewModel

@property (nonatomic, strong) ZYTokenEntity *tokenEntity;

@property (nonatomic, strong, readonly) NSURLRequest *request;

@property (nonatomic, strong, readonly) RACCommand *tokenCommand;

- (instancetype)initWithUrlStr:(NSString *)urlStr;

- (BOOL(^)(NSString *))isLoadingUrlWithCallbackUrlStr;
@end
