//
//  GH_SetPhone.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Phone)(NSString * phoneString);
typedef void(^Code)(NSString * codeString);

@interface GH_SetPhone : UIView
@property (nonatomic, strong)Phone block;
@property (nonatomic, strong)Code block1;

@property (nonatomic, strong)UITextField * phoneTextField;//手机号输入框
@property (nonatomic, strong)UITextField * codeTextField;//验证码输入框
@property (nonatomic, strong)UIButton * getCodeButton;//g获取验证码按钮
@end

NS_ASSUME_NONNULL_END
