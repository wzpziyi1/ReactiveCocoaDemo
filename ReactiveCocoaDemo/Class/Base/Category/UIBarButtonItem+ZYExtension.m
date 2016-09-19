//
//  UIBarButtonItem+ZYExtension.m
//  Template
//
//  Created by 王志盼 on 15/10/8.
//  Copyright © 2015年 王志盼. All rights reserved.
//

#import "UIBarButtonItem+ZYExtension.h"

@implementation UIBarButtonItem (ZYExtension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)hightImageName target:(id)target action:(SEL)action
{
    UIButton *bnt = [[UIButton alloc] init];
    
    [bnt setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [bnt setBackgroundImage:[UIImage imageNamed:hightImageName] forState:UIControlStateHighlighted];
    [bnt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    bnt.frame = CGRectMake(0, 0, bnt.currentBackgroundImage.size.width, bnt.currentBackgroundImage.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:bnt];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title font:(CGFloat)font target:(UIViewController *)target action:(SEL)action
{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [bnt setTitle:title forState:UIControlStateNormal];
    [bnt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bnt setTitle:title forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [bnt setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    bnt.titleLabel.font = [UIFont systemFontOfSize:font];
    [bnt sizeToFit];
    [bnt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:bnt];
}
@end
