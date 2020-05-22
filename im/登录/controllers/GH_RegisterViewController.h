//
//  GH_RegisterViewController.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GH_RegisterViewController : BaseViewController
//type 0是注册 1是忘记密码 3是微信 4是QQ 5是修改密码
@property(nonatomic, assign)int type;

//需要传给后台的data
@property (nonatomic, strong)NSDictionary * dataDic;

@property (nonatomic, copy)NSString * phone;

@end

NS_ASSUME_NONNULL_END
