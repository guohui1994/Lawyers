//
//  GH_CodeLoginViewController.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GH_CodeLoginViewController : BaseViewController
/**type 0 微信登录 1 QQ登录 2 手机验证码登录
 3 密码修改 4 手机号修改
 */
@property (nonatomic, assign)int type;

//需要传回后台
@property (nonatomic, strong)NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END
