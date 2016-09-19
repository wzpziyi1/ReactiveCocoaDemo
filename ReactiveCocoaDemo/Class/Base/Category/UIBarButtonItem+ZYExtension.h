//
//  UIBarButtonItem+ZYExtension.h
//  Template
//
//  Created by 王志盼 on 15/10/8.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZYExtension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title font:(CGFloat)font target:(UIViewController *)target action:(SEL)action;
@end
