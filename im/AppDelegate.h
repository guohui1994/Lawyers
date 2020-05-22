//
//  AppDelegate.h
//  im
//
//  Created by ZhiYuan on 2019/10/9.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AppThirdCodeDelegate <NSObject>
@optional
//微信code
- (void)returnWithCode:(NSString *)code;
//支付宝返回的状态
- (void)returnWithAlipayWith:(NSInteger)code;
//微信支付返回的状态码
- (void)returnWithWXPayWith:(NSInteger)code;
//启动图
- (void)returnGuideArray:(NSArray *)array;
//微信分享回调
- (void)backWeiXinCode:(NSString * )weiXinCode;
@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, weak)id<AppThirdCodeDelegate>returnCode;

- (void)setRootViewController;
@end

