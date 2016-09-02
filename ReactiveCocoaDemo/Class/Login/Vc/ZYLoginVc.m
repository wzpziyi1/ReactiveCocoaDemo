//
//  ZYLoginVc.m
//  ReactiveCocoaDemo
//
//  Created by 王志盼 on 16/8/31.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLoginVc.h"
#import "ZYUrlAccessUtil.h"

@interface ZYLoginVc () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ZYLoginVc

#pragma mark ----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.webView];
    
    
    
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
}

- (void)bindSignal
{
    [super bindSignal];
}

- (void)dealEvent
{
    [super dealEvent];
}


#pragma mark ----webViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    
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



@end
