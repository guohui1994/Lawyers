//
//  GetManager.h
//  AudioChang
//
//  Created by ZhiYuan on 2019/8/26.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger){
    POST = 0,
    GET = 1,
}HTTPModel;

@interface GetManager : NSObject
/**
 不带小菊花
 
 @param url 地址
 @param parameters 需要传入的参数
 @param httpModel 请求方式
 @param success 成功回调
 @param failture 失败回调
 */
+ (void)httpManagerWithUrl:(NSString *)url
                parameters:(NSDictionary *)parameters
                 httpModel:(HTTPModel)httpModel
                   success:(void(^)(id data, NSString * Message))success
                  failture:(void(^)(NSString * Message))failture;

/**
 带小菊花
 
 @param url 地址
 @param parameters 需要传入的参数
 @param httpModel 请求方式
 @param success 成功回调
 @param failture 失败回调
 */
+ (void)httpManagerNetWorkHudWithUrl:(NSString *)url
                          parameters:(NSDictionary *)parameters
                           httpModel:(HTTPModel)httpModel
                             success:(void(^)(id data, NSString * Message))success
                            failture:(void(^)(NSString * Message))failture;


@end

NS_ASSUME_NONNULL_END
