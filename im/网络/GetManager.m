//
//  GetManager.m
//  AudioChang
//
//  Created by ZhiYuan on 2019/8/26.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GetManager.h"
#import <Security/Security.h>
#include <CommonCrypto/CommonHMAC.h>
#import "GH_CountAndPasswordLoginViewController.h"
@implementation GetManager
/**
 不带小菊花
 
 @param url 地址
 @param parameters 需要传入的参数
 @param httpModel 请求方式
 @param success 成功回调
 @param failture 失败回调
 */

+(void)httpManagerWithUrl:(NSString *)url parameters:(NSDictionary *)parameters httpModel:(HTTPModel)httpModel success:(void (^)(id _Nonnull, NSString * _Nonnull))success failture:(void (^)(NSString * _Nonnull))failture{
    AFHTTPSessionManager * manager = [GetManager mannagerWithUrl:url];
    NSString * URL = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    //POST
    if (httpModel == 0) {
        [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([result[@"event"] isEqualToString:@"SUCCESS"]) {
                success(result[@"data"], result[@"describe"]);
            }else if([result[@"event"] isEqualToString:@"UNAUTHORIZED"]){
                [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error) {
                    [[Singleton defaultSingleton]setUserHeaderImage:@""];
                    [[Singleton defaultSingleton]setUserID:@""];
                    [[Singleton defaultSingleton]setToken:@""];
                    [[Singleton defaultSingleton]setUserName:@""];
                    [[Singleton defaultSingleton]setUserPhone:@""];
                    [[Singleton defaultSingleton]setIsLogin:NO];
                    [[Singleton defaultSingleton]setUserSex:@""];
                    [[Singleton defaultSingleton]setWyToken:@""];
                    [[Singleton defaultSingleton]setCcid:@""];
                    GH_CountAndPasswordLoginViewController * loginVC = [GH_CountAndPasswordLoginViewController new];
                    GH_NavViewController * nav = [[GH_NavViewController alloc]initWithRootViewController:loginVC];
                    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                }];
            }else{
                failture(result[@"describe"]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failture([error errorMessage]);
        }];
    }else{//get
        
    }
}

/**
 带小菊花
 
 @param url 地址
 @param parameters 需要传入的参数
 @param httpModel 请求方式
 @param success 成功回调
 @param failture 失败回调
 */


+(void)httpManagerNetWorkHudWithUrl:(NSString *)url parameters:(NSDictionary *)parameters httpModel:(HTTPModel)httpModel success:(void (^)(id _Nonnull, NSString * _Nonnull))success failture:(void (^)(NSString * _Nonnull))failture{
    AFHTTPSessionManager * manager = [GetManager mannagerWithUrl:url];
    NSString * URL = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];;
    hud.label.text = @"加载中~";
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [hud showAnimated:YES];
    //POST
    if (httpModel == 0) {
        [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [hud removeFromSuperview];
            NSDictionary * result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([result[@"event"] isEqualToString:@"SUCCESS"]) {
                success(result[@"data"], result[@"describe"]);
            }else  if([result[@"event"] isEqualToString:@"UNAUTHORIZED"]){
                [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error) {
                    [[Singleton defaultSingleton]setUserHeaderImage:@""];
                    [[Singleton defaultSingleton]setUserID:@""];
                    [[Singleton defaultSingleton]setToken:@""];
                    [[Singleton defaultSingleton]setUserName:@""];
                    [[Singleton defaultSingleton]setUserPhone:@""];
                    [[Singleton defaultSingleton]setIsLogin:NO];
                    [[Singleton defaultSingleton]setUserSex:@""];
                    [[Singleton defaultSingleton]setWyToken:@""];
                    [[Singleton defaultSingleton]setCcid:@""];
                    GH_CountAndPasswordLoginViewController * loginVC = [GH_CountAndPasswordLoginViewController new];
                    GH_NavViewController * nav = [[GH_NavViewController alloc]initWithRootViewController:loginVC];
                    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                }];
            }else{
                failture(result[@"describe"]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [hud removeFromSuperview];
            failture([error errorMessage]);
        }];
    }else{//get
        
    }
}
+(MBProgressHUD *)mbprogressHud{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    hud.label.text = @"正在加载~~";
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [hud showAnimated:YES];
    return hud;
}

#pragma mark - 请求头设置
+ (AFHTTPSessionManager *)mannagerWithUrl : (NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"charset=utf-8", nil];
    
    NSString *timestamp = [NSString stringWithFormat:@"%@000",[GetManager getNowTime]];
    //如果有token就传，没有就传空
        NSString *token = [Singleton defaultSingleton].token;//如果有单利保存的token就用这个;
//    NSString * token = @"";
    //版本号
    NSString *Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *device = @"ios";
    //拼接 device + timeStamp+ version
    NSString *dtvValue = [NSString stringWithFormat:@"%@\n%@\n%@",device,timestamp,Version];
    //     NSString *dtvValue = [NSString stringWithFormat:@"%@\n%@\n%@",@"ios",@"1558525030",@"1.0"];
    //签名
    NSString *signatureStr = [self HmacSha1:url data:dtvValue];
    //拼接 base 编码
    NSString *base = [NSString stringWithFormat:@"%@:%@",token,signatureStr];
    NSString *signBaseStr = [GetManager rb_base64EncodingString:base];
    NSString *AuthStr = [GetManager pureStrWithOriginStr:signBaseStr];
    //授权信息
    [manager.requestSerializer setValue:AuthStr forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:Version forHTTPHeaderField:@"Authorization-Version"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Authorization-Timestamp"];
    [manager.requestSerializer setValue:device forHTTPHeaderField:@"Authorization-Device"];
    
    return manager;
}


//!!!!: 2. HmacSHA1加密；
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)value
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, [keyData bytes], [keyData length], [valueData bytes], [valueData length], result);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:result
                                          length:sizeof(result)];
    //    NSLog(@"%d行  %@",__LINE__,HMAC);
    NSString *str =  [GetManager convertDataToHexStr:HMAC];
    //    NSLog(@"%d行  %@",__LINE__,str);
    
    return str;
}

//base64编码
+ (NSString *)rb_base64EncodingString:(NSString *)ss {
    NSData *data = [ss dataUsingEncoding:(NSUTF8StringEncoding)];
    
    return [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
}

//NSdata转16进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
+ (NSString *)pureStrWithOriginStr:(NSString *)originStr {
    // 去掉换行符号 与下面👇注释代码效果一样
    originStr = [originStr stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    originStr = [originStr stringByReplacingOccurrencesOfString:@" " withString:@""]; // 1-10这个只能取出普通空格。对于系统通讯录中的空格无能为力。
    
    originStr = [originStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    originStr = [originStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    originStr = [originStr stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    return originStr;
}

//获取期间字符串
+ (NSString *)getNowTime{
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];//@"1517468580"
    return timeSp;
}

@end
