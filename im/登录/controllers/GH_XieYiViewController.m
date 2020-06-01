//
//  GH_XieYiViewController.m
//  im
//
//  Created by ZhiYuan on 2019/10/9.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_XieYiViewController.h"

@interface GH_XieYiViewController ()

@end

@implementation GH_XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"用户注册协议";
    self.backText = @"";
    [self creatWKWebView];
    [self getData];
    
}

- (void)getData{
    WeakSelf;
    [GetManager httpManagerWithUrl:systemSet parameters:@{@"parameterName" : @"user_agreement"} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        
        NSString *url = data[@"value"];
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        managers.requestSerializer = [AFHTTPRequestSerializer serializer];
        managers.responseSerializer = [AFHTTPResponseSerializer serializer];
        managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream",nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [managers GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString * urlString  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                [weakSelf.webView loadHTMLString:urlString baseURL:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        });
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

#pragma mark --- 创建WKWebview
- (void )creatWKWebView{
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
//    if (url.length == 0) {
//
//    }else{
//        [self.webView loadHTMLString:url baseURL:nil];
//    }
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
