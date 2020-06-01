//
//  GH_XieYiViewController.h
//  im
//
//  Created by ZhiYuan on 2019/10/9.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GH_XieYiViewController : BaseViewController
#pragma mark ---WKWebView
@property (nonatomic, strong)WKWebViewConfiguration * config ;
@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, strong)WKUserContentController* wKUserContentController;
@end

NS_ASSUME_NONNULL_END
