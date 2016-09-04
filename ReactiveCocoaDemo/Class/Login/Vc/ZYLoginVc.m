//
//  ZYLoginVc.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/8/31.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLoginVc.h"
#import "ZYUrlAccessUtil.h"
#import "ZYLoginViewModel.h"

@interface ZYLoginVc () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) ZYLoginViewModel *loginViewModel;
@end

@implementation ZYLoginVc

#pragma mark ----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.webView];
    
    [self layoutPageSubviews];
    
    [self bindSignal];
    
    [self dealEvent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----must implementation

+ (instancetype)viewController
{
    return [[self alloc] initWithNibName:@"ZYLoginVc" bundle:nil];
}


#pragma mark ----flow method
- (void)layoutPageSubviews
{
    [super layoutPageSubviews];
    
    ZYWeakSelf;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)bindSignal
{
    [super bindSignal];
    
    [[self rac_signalForSelector:@selector(webViewDidStartLoad:) fromProtocol:@protocol(UIWebViewDelegate)] subscribeNext:^(id x) {

        [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
        
    }];
    
    [[self rac_signalForSelector:@selector(webViewDidFinishLoad:) fromProtocol:@protocol(UIWebViewDelegate)] subscribeNext:^(id x) {
        
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
    [[self rac_signalForSelector:@selector(webView:didFailLoadWithError:) fromProtocol:@protocol(UIWebViewDelegate)] subscribeNext:^(id x) {
        [MBProgressHUD hideHUDForView:self.view];
//        [MBProgressHUD showError:@"网络异常，请重新加载"];
    }];
}

- (void)dealEvent
{
    [super dealEvent];
    
    [self.webView loadRequest:self.loginViewModel.request];
}


#pragma mark ----webViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return self.loginViewModel.isLoadingUrlWithCallbackUrlStr(request.URL.absoluteString);
}

#pragma mark ----setter && getter
- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

- (ZYLoginViewModel *)loginViewModel
{
    if (!_loginViewModel)
    {
        _loginViewModel = [[ZYLoginViewModel alloc] initWithUrlStr:kApiAuthorize];
    }
    return _loginViewModel;
}


@end
