//
//  GH_Tools.h
//  ExtendDemo
//
//  Created by ZhiYuan on 2019/8/8.
//  Copyright © 2019 ZhiYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GH_Tools : NSObject

//返回当前时间戳
+ (long)currentTimeStemp;
//时间戳转字符串
+(NSString *)transToTimeStemp:(long)timeStemp dateFormatter:(NSString *)formatter;
//生成model
+(void)beginCreatModelWithName:(NSString *)name data:(id)data;
/**
 判断网络状态
 @return 判断网络状态
 */
//+ (BOOL)isNetWorkReachable;
//获取当前时间戳  精确到毫秒
+ (NSString *)currentTimeStr;

/**
 自动消失, 延迟两秒不带菊花---黑色白字
 
 @param text 传入的text
 */
+ (void)AutomaticAndBlackHudRemoveHudWithText:(NSString *)text;
/**
 获取跟控制器
 
 @return 根控制器
 */
+ (UIViewController *)rootViewController;

/**
 获取当前活跃控制器
 
 @return 返回VC
 */
+ (UIViewController *)findVisibleViewController;

/**
 返回富文本

 @param string string
 @param color 颜色
 @param font 字体
 @param length 长度
 @return 富文本
 */
+(NSMutableAttributedString *)attributedStringWithString:(NSString *)string color:(NSString *)color font:(CGFloat)font length:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
