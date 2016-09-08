//
//  ZYHomeVc.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/5.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYHomeVc.h"
#import "ZYHomeViewModel.h"
#import "ZYNotLoginView.h"

@interface ZYHomeVc ()
@property (nonatomic, strong) ZYHomeViewModel *homeViewModel;

@property (nonatomic, strong) ZYNotLoginView *notLoginView;
@end

@implementation ZYHomeVc

+ (instancetype)viewController
{
    return [[ZYHomeVc alloc] initWithNibName:@"ZYHomeVc" bundle:nil];
}

#pragma mark ----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.homeViewModel.isLogined)
    {
        
    }
    else
    {
        [self.view addSubview:self.notLoginView];
    }
    
    [self layoutPageSubviews];
    [self bindSignal];
    [self dealEvent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----flow method
- (void)layoutPageSubviews
{
    [super layoutPageSubviews];
    
    if (self.homeViewModel.isLogined)
    {
        
    }
    else
    {
        @weakify(self);
        [self.notLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.view);
        }];
    }
    
}

- (void)bindSignal
{
    [super bindSignal];
}

- (void)dealEvent
{
    [super dealEvent];
}


#pragma mark ----getter && setter

- (ZYHomeViewModel *)homeViewModel
{
    if (!_homeViewModel)
    {
        _homeViewModel = [[ZYHomeViewModel alloc] init];
    }
    return _homeViewModel;
}

- (ZYNotLoginView *)notLoginView
{
    if (!_notLoginView)
    {
        _notLoginView = [ZYNotLoginView createNotLoginView];
        [_notLoginView startAnimation];
    }
    return _notLoginView;
}

@end
