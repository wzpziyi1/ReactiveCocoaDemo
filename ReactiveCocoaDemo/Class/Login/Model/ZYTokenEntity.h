//
//  ZYTokenEntity.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/4.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYBaseEntity.h"

@interface ZYTokenEntity : ZYBaseEntity
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *remind_in;
@property (nonatomic, copy) NSString *uid;
@end
