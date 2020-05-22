//
//  Singgleton.m
//  XinYongKa
//
//  Created by Yasin on 2019/4/4.
//  Copyright © 2019 ZhiYuan Network. All rights reserved.
//

#import "Singleton.h"



static Singleton * singleton = nil;

@implementation Singleton

+ (Singleton *)defaultSingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Singleton alloc]init];
    });
    return singleton;
}

- (NSString *)loadStringFromDefaultsWithKey:(NSString *)key
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return (str && str.length>0) ? str : @"";
    
}
#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey1:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//用户名字
- (void)setUserName:(NSString *)UserName{
    [UserName saveToNSDefaultsWithKey:KUserName];
}
-(NSString *)UserName{
    NSString * str = [self loadStringFromDefaultsWithKey:KUserName];
    str = [str trimString];
    if (!str || str.length < 1 || [str isEmptyString]) {
        str = @"";
    }
    return str;
}

//token
- (void)setToken:(NSString *)token{
    [token saveToNSDefaultsWithKey:KToken];
}

-(NSString *)token{
    NSString * str = [self loadStringFromDefaultsWithKey:KToken];
    str = [str trimString];
    if (!str || str.length < 1 || [str isEmptyString]) {
        str = @"";
    }
    return str;
}

//手机号
- (void)setUserPhone:(NSString *)UserPhone{
    [UserPhone saveToNSDefaultsWithKey:KUserPhone];
}
- (NSString *)UserPhone{
    NSString * str = [self loadStringFromDefaultsWithKey:KUserPhone];
    str = [str trimString];
    if (!str || str.length < 1 || [str isEmptyString]) {
        str = @"";
    }
    return str;
}

//用户ID
- (void)setUserID:(NSString *)userID{
    [userID saveToNSDefaultsWithKey:KUserID];
}
-(NSString *)userID{
     return   [self getString:KUserID];
}
//头像
- (void)setUserHeaderImage:(NSString *)UserHeaderImage{
    [UserHeaderImage saveToNSDefaultsWithKey:KUserHeaderImage];
}
- (NSString *)UserHeaderImage{
    return [self getString:KUserHeaderImage];
}

//性别
- (void)setUserSex:(NSString *)UserSex{
    [UserSex saveToNSDefaultsWithKey:KUserSex];
}
- (NSString *)UserSex{
    return [self getString:KUserSex];
}

//网易账号
- (void)setCcid:(NSString *)ccid{
    [ccid saveToNSDefaultsWithKey:KCCID];
}
- (NSString *)ccid{
    return [self getString:KCCID];
}

//网易token
- (void)setWyToken:(NSString *)wyToken{
    [wyToken saveToNSDefaultsWithKey:KWYToken];
}
- (NSString *)wyToken{
    return [self getString:KWYToken];
}



- (void)setIsLogin:(BOOL)isLogin{
    [[NSUserDefaults standardUserDefaults]setBool:isLogin forKey:KIsLogin];
     [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)isLogin{
    NSLog(@"%d",  [[NSUserDefaults standardUserDefaults] boolForKey:KIsLogin]);
    return [[NSUserDefaults standardUserDefaults] boolForKey:KIsLogin];
}

- (void)setIsThirdLogin:(BOOL)isThirdLogin{
    [[NSUserDefaults standardUserDefaults]setBool:isThirdLogin forKey:KIsThirdLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)isThirdLogin{
    return [[NSUserDefaults standardUserDefaults]boolForKey:KIsThirdLogin];
}

- (NSString *)getString:(NSString *)keyString{
    NSString * str = [self loadStringFromDefaultsWithKey:keyString];
    str = [str trimString];
    if (!str || str.length < 1 || [str isEmptyString]) {
        str = @"";
    }
    return str;
}



@end
