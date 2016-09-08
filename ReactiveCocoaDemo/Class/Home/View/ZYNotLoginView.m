//
//  ZYNotLoginView.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/7.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYNotLoginView.h"

@interface ZYNotLoginView()
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *wheelView;

@end

@implementation ZYNotLoginView
+ (instancetype)createNotLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZYNotLoginView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commitInit];
}

- (void)commitInit
{
    self.backgroundColor = kColor2;
    
    self.focusBtn.layer.borderColor = kColor6.CGColor;
    self.focusBtn.layer.borderWidth = 0.5;
}

- (void)bindSignal
{
    [[self.focusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ZYLog(@"focusBtn click");
    }];
}

- (void)startAnimation
{
    CAKeyframeAnimation *keyAnimation = [[CAKeyframeAnimation alloc] init];
    keyAnimation.keyPath = @"transform.rotation";
    keyAnimation.values = @[@0, @M_PI, @(2 * M_PI)];
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.duration = 4;
    keyAnimation.delegate = self;
    keyAnimation.repeatCount = MAXFLOAT;
    [self.wheelView.layer addAnimation:keyAnimation forKey:@"wheelRotaion"];
}

@end
