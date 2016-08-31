//
//  ZYBaseViewController.h
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/8/31.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYBaseViewController : UIViewController

+ (instancetype)viewController;

- (void)layoutPageSubviews;

- (void)bindSignal;

- (void)dealEvent;
@end
