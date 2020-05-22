//
//  Singgleton.h
//  XinYongKa
//
//  Created by Yasin on 2019/4/4.
//  Copyright © 2019 ZhiYuan Network. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject
+ (Singleton *)defaultSingleton;


/**
 token
 */
@property (nonatomic, copy)NSString * token;

/*用户名字*/
@property (nonatomic, copy)NSString * UserName;

/**
 手机号
 */
@property (nonatomic, copy)NSString * UserPhone;

/**
 用户ID
 */
@property (nonatomic, copy)NSString * userID;

/**
 用户头像
 */
@property(nonatomic, copy)NSString * UserHeaderImage;


/**
 用户性别
 */
@property(nonatomic, copy)NSString * UserSex;



/**
 是否登录
 */
@property(nonatomic, assign)BOOL isLogin;


@property (nonatomic, assign)BOOL isThirdLogin;


//网易云信账号
@property(nonatomic, copy)NSString * ccid;
//网易云信token
@property (nonatomic, copy)NSString * wyToken;
@end

NS_ASSUME_NONNULL_END
