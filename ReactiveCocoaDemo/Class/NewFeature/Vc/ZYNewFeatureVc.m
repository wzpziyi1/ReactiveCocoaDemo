//
//  ZYNewFeatureVc.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/9/8.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYNewFeatureVc.h"
#import "ZYFeatureViewModel.h"

@interface ZYNewFeatureVc () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ZYFeatureViewModel *featureViewModel;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *shareBtn;
@end

@implementation ZYNewFeatureVc

+ (instancetype)viewController
{
    return [[self alloc] init];
}

#pragma mark ----life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    [self dealupImagsForScrollView];
    
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
    
    @weakify(self);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
        make.size.sizeOffset(CGSizeMake(200, 30));
    }];
}

- (void)bindSignal
{
    [super bindSignal];
    
}

- (void)dealEvent
{
    [super dealEvent];
    
    @weakify(self);
    [[self rac_signalForSelector:@selector(scrollViewDidScroll:) fromProtocol:@protocol(UIScrollViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UIScrollView *scrollView = [tuple first];
        self.pageControl.currentPage = scrollView.contentOffset.x / kScreenW + 0.5;
    }];
    
    [[self.shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ZYTransitionUtil startTabBarWithMainWindow:[UIApplication sharedApplication].keyWindow params:nil];
    }];
}

#pragma mark ----private

- (void)dealupImagsForScrollView
{
    int imageCount = (int)self.featureViewModel.imageNames.count;
    for (int i = 0; i < imageCount; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenW, 0, kScreenW, kScreenH)];
        imageView.image = [UIImage imageNamed:self.featureViewModel.imageNames[i]];
        [self.scrollView addSubview:imageView];
        
        if (i == imageCount - 1)
        {
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:self.shareBtn];
        }
    }
    self.scrollView.contentSize = CGSizeMake(self.featureViewModel.imageNames.count * kScreenW, 0);
}

#pragma mark ----scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {}

#pragma mark ----getter&&setter
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (ZYFeatureViewModel *)featureViewModel
{
    if (!_featureViewModel)
    {
        _featureViewModel = [[ZYFeatureViewModel alloc] init];
    }
    return _featureViewModel;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = self.featureViewModel.imageNames.count;
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = kColor6;
        _pageControl.currentPageIndicatorTintColor = ZYColor(253, 98, 42);
    }
    return _pageControl;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn)
    {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
        [_shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
       
        [_shareBtn setTitle:@"开始" forState:UIControlStateNormal];
        CGRect frame = _shareBtn.frame;
        frame.size = CGSizeMake(135, 35);
        _shareBtn.frame = frame;
        _shareBtn.center = CGPointMake(kScreenW * 0.5, kScreenH * 0.7);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    return _shareBtn;
}

@end
