//
//  GH_WebViewController.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GH_WebViewController : BaseViewController
@property (nonatomic, copy)NSString * titleString;
@property (nonatomic, copy)NSString * urlString;
#pragma mark ---WKWebView
@property (nonatomic, strong)WKWebViewConfiguration * config ;
@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, strong)WKUserContentController* wKUserContentController;
@end

NS_ASSUME_NONNULL_END
