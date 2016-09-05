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


@end
