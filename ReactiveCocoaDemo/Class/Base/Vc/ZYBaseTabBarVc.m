//
//  ZYBaseTabBarVc.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/5.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYBaseTabBarVc.h"
#import "ZYTabBarViewModel.h"
#import "ZYBaseViewController.h"
#import "ZYVcSettingEntity.h"
#import "ZYHomeVc.h"
#import "ZYMessageVc.h"
#import "ZYNullVc.h"
#import "ZYDiscoverVc.h"
#import "ZYProfileVc.h"


@interface ZYBaseTabBarVc ()
@property (nonatomic, strong) ZYTabBarViewModel *viewModel;

@property (nonatomic, strong) UIButton *composeBtn;
@end

@implementation ZYBaseTabBarVc



#pragma mark ----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupChildVc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBar addSubview:self.composeBtn];
    CGFloat width = kScreenW / 5.0;
    self.composeBtn.frame = CGRectMake(width * 2, 0, width, 49);
}

#pragma mark ----private

- (void)setupChildVc
{
    for (int i = 0; i < self.viewModel.vcSettings.count; i++)
    {
        ZYVcSettingEntity *entity = self.viewModel.vcSettings[i];
        [self addChildVcWithEntity:entity];
    }
}

- (void)addChildVcWithEntity:(ZYVcSettingEntity *)entity
{
    UIViewController *vc = [NSClassFromString(entity.vcName) viewController];
    vc.title = entity.title;
    vc.tabBarItem.image = [UIImage imageNamed:entity.imageName];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nvc];
}

#pragma mark ---- setter && getter
- (ZYTabBarViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [[ZYTabBarViewModel alloc] init];
    }
    return _viewModel;
}

- (UIButton *)composeBtn
{
    if (_composeBtn == nil)
    {
        _composeBtn = [[UIButton alloc] init];
        [_composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        [_composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [[_composeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"-------");
        }];
        
    }
    return _composeBtn;
}

@end
