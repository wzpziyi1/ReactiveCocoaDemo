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

@interface ZYHomeVc () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ZYHomeViewModel *homeViewModel;

@property (nonatomic, strong) ZYNotLoginView *notLoginView;

@property (nonatomic, strong) UITableView *tableView;
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
        [self.homeViewModel.loadStatusCommand execute:nil];
        [self setupNavBarForLogined];
        [self.view addSubview:self.tableView];
    }
    else
    {
        [self setupNavBarForNoLogined];
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

- (void)setupNavBarForLogined
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendattention" highImageName:@"navigationbar_friendattention_highlighted" target:self action:@selector(clickLeftItem)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"" highImageName:@"" target:self action:@selector(transformToQRcodeVc)];
}

- (void)setupNavBarForNoLogined
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItem)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
}

- (void)layoutPageSubviews
{
    [super layoutPageSubviews];
    
    @weakify(self);
    if (self.homeViewModel.isLogined)
    {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.view);
        }];
    }
    else
    {
        
        [self.notLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.view);
        }];
    }
    
}

- (void)bindSignal
{
    [super bindSignal];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kAppDidLoginNotification object:nil] subscribeNext:^(id x) {
        [self.notLoginView removeFromSuperview];
        [self.homeViewModel.loadStatusCommand execute:nil];
        [self setupNavBarForLogined];
        [self layoutPageSubviews];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kAppDidLogoutNotification object:nil] subscribeNext:^(id x) {
        [self.tableView removeFromSuperview];
        [self setupNavBarForNoLogined];
        [self layoutPageSubviews];
    }];
}

- (void)dealEvent
{
    [super dealEvent];
    
}

#pragma mark ----event method

- (void)clickLeftItem
{
    ZYLog(@"%s", __func__);
}

- (void)clickRightItem
{
    [ZYTransitionUtil startLoginVcWithBaseVc:self params:nil completion:nil animated:YES];
}

- (void)transformToQRcodeVc
{
    ZYLog(@"%s", __func__);
}

#pragma mark ----private

#pragma mark ----UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeViewModel.statusArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
