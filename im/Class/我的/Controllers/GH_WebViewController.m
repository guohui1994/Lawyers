//
//  GH_WebViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_WebViewController.h"

@interface GH_WebViewController ()

@end

@implementation GH_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = self.titleString;
    
    self.backText = @"";
    [self creatWKWebView:self.urlString];
    // Do any additional setup after loading the view.
}
#pragma mark --- 创建WKWebview
- (void )creatWKWebView:(NSString *)url{
    self.config = [[WKWebViewConfiguration alloc]init];
    self.config.preferences = [WKPreferences new];
    self.config.preferences.javaScriptEnabled = YES;
    self.config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    self.config.userContentController = [[WKUserContentController alloc]init];
    if (Height_NavBar == 88.0f) {
        self. webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, Height_NavBar, screenWidth, screenHeight -88 ) configuration:self.config];
    }else{
        self. webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, Height_NavBar, screenWidth, screenHeight -64 ) configuration:self.config];
    }
    
//    self. webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, Height_NavBar, screenWidth, screenHeight) configuration:self.config];
    self. wKUserContentController = _webView.configuration.userContentController;
    self.config.userContentController = self.wKUserContentController;
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
//    self. webView.UIDelegate = self;
    [self.webView.scrollView setShowsVerticalScrollIndicator:NO];
    [self.webView.scrollView setShowsHorizontalScrollIndicator:NO];
    [_webView setAllowsBackForwardNavigationGestures:YES];
//    self. webView.navigationDelegate = self;
    [_webView.scrollView setAlwaysBounceVertical:YES];
    [self.view addSubview:_webView];
    if (url.length == 0) {
        
    }else{
    [self.webView loadHTMLString:url baseURL:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
