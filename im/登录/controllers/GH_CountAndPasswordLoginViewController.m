//
//  GH_CountAndPasswordLoginViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_CountAndPasswordLoginViewController.h"
#import "GH_WeiXinAndQQLoginView.h"
#import "GH_RegisterViewController.h"
#import "GH_CodeLoginViewController.h"
#import "AppDelegate.h"
@interface GH_CountAndPasswordLoginViewController ()<AppThirdCodeDelegate,TencentSessionDelegate, WXApiDelegate>
@property (nonatomic, strong)GH_PublicTextFieldView * countTextField;
@property (nonatomic, strong)GH_PublicTextFieldView * passwordTextField;
@property (nonatomic, copy)NSString * countString;
@property (nonatomic, copy)NSString * passwordString;
@property (nonatomic, strong)TencentOAuth * tencentOAuth;
@end

@implementation GH_CountAndPasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"登录";
    [self creatUI];
    [self getThird];
    
    AppDelegate * delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.returnCode = self;
}


- (void)getThird{
    [GetManager httpManagerWithUrl:systemSet parameters:@{@"parameterName":@"third_party"} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        if ([data[@"value"] integerValue] == 1) {
            [self creatBottomView];
        }else{
            
        }
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}


- (void)creatUI{
    
//    //注册按钮
//    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
//    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchDown];
//    [registerButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
//    registerButton.titleLabel.font = Fonts(17);
//    [self.customNavBar addSubview:registerButton];
//    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.customNavBar.mas_right).mas_offset(-ZY_WidthScale(15));
//        make.bottom.equalTo(self.customNavBar.mas_bottom);
//        make.height.equalTo(@(44));
//    }];
    WeakSelf;
//    NSLog(@"%.f", [[UIApplication sharedApplication] statusBarFrame].size.height);
//    //账号
//    if ([[UIApplication sharedApplication] statusBarFrame].size.height > 20) {
//        self.countTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), Height_NavBar + ZY_HeightScale(61), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Login_Count" placeholder:@"请输入账号"];
//    }else{
//        self.countTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), 88 + ZY_HeightScale(61), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Login_Count" placeholder:@"请输入账号"];
//    }
    NSLog(@"%f",  [[UIApplication sharedApplication] statusBarFrame].size.height);
      self.countTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), Height_NavBar + ZY_HeightScale(61), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Login_Count" placeholder:@"请输入账号"];
    
    [self.view addSubview:self.countTextField];
//    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).mas_offset(Height_NavBar + ZY_HeightScale(61));
//        make.width.equalTo(@(screenWidth - ZY_WidthScale(76)));
//        make.height.equalTo(@(ZY_HeightScale(55)));
//    }];
    self.countTextField.block = ^(UITextField * _Nonnull textField) {
        weakSelf.countString = textField.text;
    };
    //密码
    self.passwordTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), self.countTextField.bottom + ZY_HeightScale(20), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Login_Password" placeholder:@"请输入密码"];
    self.passwordTextField.isScreat  = YES;
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.block = ^(UITextField * _Nonnull textField) {
        weakSelf.passwordString  = textField.text;
    };
    //忘记密码
    UIButton * forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassword setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
    forgetPassword.titleLabel.font = Fonts(15);
    [forgetPassword addTarget:self action:@selector(forgetPasswordClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:forgetPassword];
    [forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(ZY_WidthScale(48));
        make.top.equalTo(self.passwordTextField.mas_bottom).mas_offset(ZY_HeightScale(15));
    }];
    
    //手机号快速登录
    UIButton * phoneLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneLogin setTitle:@"没有账号去注册!" forState:UIControlStateNormal];
    [phoneLogin setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
    phoneLogin.titleLabel.font = Fonts(15);
    [phoneLogin addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:phoneLogin];
    [phoneLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(forgetPassword);
        make.right.equalTo(self.view.mas_right).mas_offset(-ZY_WidthScale(48));
    }];
    
    //登录
    UIButton * loginBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBt.layer addSublayer:[self changColorWithWidth:ZY_WidthScale(299) height:ZY_HeightScale(50)]];
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    [loginBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBt.titleLabel.font = Fonts(18);
    loginBt.layer.cornerRadius =ZY_WidthScale(25);
    loginBt.clipsToBounds = YES;
    [loginBt addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginBt];
    [loginBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).mas_offset(ZY_HeightScale(60));
        make.width.equalTo(@(ZY_WidthScale(299)));
        make.height.equalTo(@(ZY_HeightScale(50)));
    }];
}



#pragma mark ---微信
//第三方登录
- (void)creatBottomView{
    WeakSelf;
    GH_WeiXinAndQQLoginView * thirdView = [GH_WeiXinAndQQLoginView new];
    thirdView.block = ^(NSInteger index) {
        if (index == 0) {
            //微信登录
            [weakSelf weixinLogin];
        }else if (index == 1){
         //qq登录
            [weakSelf QQLogin];
        }else{
         //手机号快速登录
            [weakSelf phoneLogin:2 data:nil];
        }
    };
    [self.view addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(ZY_HeightScale(183)));
    }];
}
//微信返回的code
- (void)returnWithCode:(NSString *)code{
    NSLog(@"%@", code);
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:UserLogin parameters:@{@"type":@(0), @"code":code} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        if ([data[@"id"] integerValue]  == -1) {
            [weakSelf phoneLogin:0 data:data[@"data"]];
        }else{
//            [weakSelf saveUserMessage:data];
            [[[NIMSDK sharedSDK] loginManager] login:data[@"wyAccid"] token:data[@"wyToken"] completion:^(NSError * _Nullable error) {
                NSLog(@"网易云信登录成功了");
                [weakSelf saveUserMessage:data];
            }];
        }
    } failture:^(NSString * _Nonnull Message) {
        [self AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

- (void)onReq:(BaseReq *)req{
    if ([req isMemberOfClass:[SendAuthResp class]])  {
        NSLog(@"******************获得的微信登录授权******************");
        
        SendAuthResp *aresp = (SendAuthResp *)req;
        if (aresp.errCode != 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [self showError:@"微信授权失败"];
            });
            return;
        }
        //授权成功获取 OpenId
        NSString *code = aresp.code;
        [self returnWithCode:code];
        //        [self getWeiXinOpenId:code];
    }
}

/**
 微信登录
 */
- (void)weixinLogin{
    SendAuthReq *req = [[SendAuthReq alloc] init];
    if ([WXApi isWXAppInstalled]) {
        
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendReq:req];
    }else {
        //                [self GH_MBProgressHUDText:@"未安装微信应用或版本过低"];
        [WXApi sendAuthReq:req viewController:self delegate:self];
    }
}


#pragma mark ----QQ
- (void)QQLogin{
    //QQ或者TIM已安装
//    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
//        
//        NSArray* permissions = [self getPermissions];//授权列表数组 根据实际需要添加
//        self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"1106195866" andDelegate:self];
//    //        _tencentOAuth.authShareType = AuthShareType_QQ;
//        [self.tencentOAuth authorize:permissions inSafari:YES];
//    }
    
    NSArray* permissions = [self getPermissions];//授权列表数组 根据实际需要添加
    self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"101832402" andDelegate:self];
    //        _tencentOAuth.authShareType = AuthShareType_QQ;
    [self.tencentOAuth authorize:permissions inSafari:YES];
}
//授权列表数组 根据实际需要添加
- (NSMutableArray*)getPermissions{
    NSMutableArray * g_permissions = [[NSMutableArray alloc] initWithObjects:@"get_user_info",@"get_simple_userinfo",nil];
    return g_permissions;
}

#pragma mark ---QQ代理
- (void)tencentDidLogin{
     NSLog(@"%@ -- %@",self.tencentOAuth.accessToken, self.tencentOAuth.openId);
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:UserLogin parameters:@{@"type":@(1),@"accessToken":self.tencentOAuth.accessToken} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"1111%@", data);
        if ([data[@"id"] integerValue]  == -1) {
            [weakSelf phoneLogin:1 data:data[@"data"]];
        }else{
//            [weakSelf saveUserMessage:data];
            [[[NIMSDK sharedSDK] loginManager] login:data[@"wyAccid"] token:data[@"wyToken"] completion:^(NSError * _Nullable error) {
                NSLog(@"网易云信登录成功了");
                [weakSelf saveUserMessage:data];
            }];
        }
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    if(cancelled) {
//        [self GH_MBProgressHUDText:@"取消登录"];
    }
    
}

-(void)tencentDidNotNetWork{
//    [self GH_MBProgressHUDText:@"网络连接错误"];
}
-(void)didGetUnionID{
    
    NSLog(@"UnionId==================%@",self.tencentOAuth.unionid);
    
    //    [BMWUserDefaults setObject:_tencentOAuth.unionid forKey:QQAppUnionid];
    
    //因为我是在getUserInfoResponse方法里调用的后台接口，为了保证调用接口之前已经获取到**Unionid**，在这里调用获取用户信息的方法。
    
    [self.tencentOAuth getUserInfo];
    
}

-(void)getUserInfoResponse:(APIResponse*)response

{
    
    NSLog(@"response -- %@", response.jsonResponse);
    
//    NSDictionary*dic = response.jsonResponse;
//    
//    NSString*sex;
//    
    
    
    //    NSDictionary *LoginDataDic = @{@"openid":_tencentOAuth.openId,@"unionid":[BMWUserDefaults objectForKey:QQAppUnionid],@"nickname":dic[@"nickname"],@"headimgurl":dic[@"figureurl_2"],@"sex":sex};
    //
    //后台QQ登录授权接口
    
    //    [self getQQLoginData:LoginDataDic];
    
}
#pragma maek ---账号密码登录
/**
 登录
 */
- (void)login{
    self.countTextField.registerFirstRespoder = YES;
    self.passwordTextField.registerFirstRespoder = YES;
    WeakSelf;
    if (self.countString.length == 0) {
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入账号"];
    }else if (self.passwordString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入密码"];
    }else{
        NSLog(@"账号%@, 密码%@", self.countString, self.passwordString);
        
        [GetManager httpManagerNetWorkHudWithUrl:UserLogin parameters:@{@"type": @(3), @"phone":self.countString, @"password":self.passwordString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            NSLog(@"%@", data);
           
            
            [[[NIMSDK sharedSDK] loginManager] login:data[@"wyAccid"] token:data[@"wyToken"] completion:^(NSError * _Nullable error) {
                NSLog(@"网易云信登录成功了");
                 [weakSelf saveUserMessage:data];
            }];
//            NSString * alias = [NSString stringWithFormat:@"u_%@", data[@"id"]];
//            [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                NSLog(@"%ld,%@, %ld", (long)iResCode, iAlias, (long)seq);
//            } seq:0];
//            NSSet * set = [NSSet setWithObjects:@"wanglvshi", nil];
//            [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//
//            } seq:0];
        } failture:^(NSString * _Nonnull Message) {
            [self AutomaticAndBlackHudRemoveHudWithText:Message];
        }];
        
    }
}

/**
 注册
 */
- (void)registerButtonClick{
    NSLog(@"注册");
   
    [self resiterVCWithType:0];
}

/**
 忘记密码
 */
- (void)forgetPasswordClick{
    [self resiterVCWithType:1];
}


- (void)resiterVCWithType:(int)type{
    GH_RegisterViewController * vc = [GH_RegisterViewController new];
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)phoneLogin:(int)type data:(NSDictionary*)data{
    GH_CodeLoginViewController * vc = [GH_CodeLoginViewController new];
    vc.type = type;
    vc.dataDic = data;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)saveUserMessage:(id)data{
    [[Singleton defaultSingleton]setUserHeaderImage:data[@"head"]];
    [[Singleton defaultSingleton]setUserID:[NSString stringWithFormat:@"%@", data[@"id"]]];
    [[Singleton defaultSingleton]setToken:data[@"token"]];
    [[Singleton defaultSingleton]setUserName:data[@"nickName"]];
    [[Singleton defaultSingleton]setUserPhone:data[@"phone"]];
    [[Singleton defaultSingleton]setIsLogin:YES];
    [[Singleton defaultSingleton]setCcid:data[@"wyAccid"]];
    [[Singleton defaultSingleton]setWyToken:data[@"wyToken"]];
    int sex = [data[@"sex"] intValue];
    if (sex == 0) {
        [[Singleton defaultSingleton]setUserSex:@"未知"];
    }else if (sex == 1){
        [[Singleton defaultSingleton]setUserSex:@"男"];
    }else{
        [[Singleton defaultSingleton]setUserSex:@"女"];
    }
    NSString * alias = [NSString stringWithFormat:@"u_%@", data[@"id"]];
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld,%@, %ld", (long)iResCode, iAlias, (long)seq);
    } seq:0];
    NSSet * set = [NSSet setWithObjects:@"wanglvshi", nil];
    [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0];
    [UIApplication sharedApplication].keyWindow.rootViewController = [GH_TabBarViewController new];
}



@end
