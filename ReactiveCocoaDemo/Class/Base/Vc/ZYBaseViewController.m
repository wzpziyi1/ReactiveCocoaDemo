//
//  ZYBaseViewController.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/8/31.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYBaseViewController.h"

@interface ZYBaseViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *endEdtingRecognizer;

@end

@implementation ZYBaseViewController

#pragma mark ----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addGestureRecognizer:self.endEdtingRecognizer];
    
    [self layoutPageSubviews];
    [self bindSignal];
    [self dealEvent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----must implement

- (void)layoutPageSubviews
{
    
}

- (void)bindSignal
{
    
}

- (void)dealEvent
{
    [[self.endEdtingRecognizer rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *recognizer) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }];
}

#pragma mark ---- getter && setter

- (UITapGestureRecognizer *)endEdtingRecognizer
{
    if (!_endEdtingRecognizer)
    {
        _endEdtingRecognizer = [[UITapGestureRecognizer alloc] init];
    }
    return _endEdtingRecognizer;
}


@end
