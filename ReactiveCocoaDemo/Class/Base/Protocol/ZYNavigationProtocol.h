//
//  ZYNavigationProtocol.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/5.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock)();

@protocol ZYNavigationProtocol <NSObject>

- (void)pushVcWithParams:(NSDictionary *)params animated:(BOOL)animated;

- (void)popVcAnimated:(BOOL)animated;

- (void)popToRootVcAnimated:(BOOL)animated;

- (void)presentVcWithParams:(NSDictionary *)params animated:(BOOL)animated completed:(VoidBlock)completed;

- (void)dismissVcAnimated:(BOOL)animated completed:(VoidBlock)completed;

- (void)resetRootVcWithParams:(NSDictionary *)params;
@end
