//
//  GH_RegisterViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_RegisterViewController.h"
#import "GH_ AgreeView.h"
#import "GH_WebViewController.h"
#import "GH_XieYiViewController.h"
@interface GH_RegisterViewController ()
@property (nonatomic, strong)GH_PublicTextFieldView * phoneTextField;//手机号
@property (nonatomic, strong)GH_PublicTextFieldView * codeTextField;//验证码
@property (nonatomic, strong)GH_PublicTextFieldView * passwordTextField;//密码
@property (nonatomic, strong)GH_PublicTextFieldView * surePasswordTextFild;//确认密码
@property (nonatomic, strong)UIButton * getCodeButton;//获取验证码

@property (nonatomic, copy)NSString * phoneString;//手机号
@property (nonatomic, copy)NSString * codeString;//验证码
@property (nonatomic,copy)NSString * passwordString;//密码
@property(nonatomic, copy)NSString * surePasswordString;//确认密码


@property (nonatomic, assign)NSInteger time;
@property (nonatomic, strong)NSTimer * timer;
@end

@implementation GH_RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 0) {
         self.titleText = @"注册";
    }else if(self.type == 1){
        self.titleText = @"忘记密码";
    }else if(self.type == 3){
        self.titleText = @"绑定手机号";
    }else if (self.type == 4){
        self.titleText = @"绑定手机号";
    }else{
        self.titleText = @"修改密码";
    }
    self.phoneString = self.phone;
    self.backText = @"";
    [self creatUI];
}

- (void)creatUI{
    if (self.type == 0) {
        //登录按钮
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchDown];
        [loginButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
        loginButton.titleLabel.font = Fonts(17);
        [self.customNavBar addSubview:loginButton];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.customNavBar.mas_right).mas_offset(-ZY_WidthScale(15));
            make.bottom.equalTo(self.customNavBar.mas_bottom);
            make.height.equalTo(@(44));
        }];
    }else{
        
    }
    //灰色线条
    UIView * grayView = [UIView new];
    grayView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
        make.height.equalTo(@(10));
    }];
    WeakSelf;
    //账号
    
    if (self.type == 3 || self.type == 4) {
        self.phoneTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38),Height_NavBar+ ZY_HeightScale(61), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Register_Phone" placeholder:self.phone];
        self.phoneTextField.text = self.phoneString;
        [self.view addSubview:self.phoneTextField];
        self.phoneTextField.block = ^(UITextField * _Nonnull textField) {
            weakSelf.phoneString = textField.text;
        };
    }else{
        self.phoneTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38),Height_NavBar+ ZY_HeightScale(61), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Register_Phone" placeholder:@"请输入手机号"];
        [self.view addSubview:self.phoneTextField];
        self.phoneTextField.block = ^(UITextField * _Nonnull textField) {
            weakSelf.phoneString = textField.text;
        };
    }
    
    
    //验证码
    self.codeTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), self.phoneTextField.bottom+ ZY_HeightScale(20), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Register_Code" placeholder:@"请输入验证码"];
    self.codeTextField.width = 120;
    [self.view addSubview:self.codeTextField];
    self.codeTextField.block = ^(UITextField * _Nonnull textField) {
        weakSelf.codeString = textField.text;
    };
    //获取验证码
    self.getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeButton setTitle:@"获取" forState:UIControlStateNormal];
    [self.getCodeButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
    self.getCodeButton.titleLabel.font = Fonts(17);
    [self.getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchDown];
    [self.codeTextField addSubview:self.getCodeButton];
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.codeTextField.mas_right).mas_offset(-ZY_WidthScale(36));
        make.centerY.equalTo(self.codeTextField);
        
    }];
    
    //密码
    if (self.type == 0) {
         self.passwordTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), self.codeTextField.bottom+ ZY_HeightScale(20), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Login_Password" placeholder:@"请设置密码(至少六位)"];
    }else{
         self.passwordTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), self.codeTextField.bottom+ ZY_HeightScale(20), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Login_Password" placeholder:@"设置新密码(6-8位)"];
    }
    self.passwordTextField.isScreat = YES;
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.block = ^(UITextField * _Nonnull textField) {
        weakSelf.passwordString = textField.text;
    };
    //确认密码
    if (self.type == 0) {
        self.surePasswordTextFild = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), self.passwordTextField.bottom+ ZY_HeightScale(20), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Register_SurePassword" placeholder:@"请再次确认密码"];
    }else{
        self.surePasswordTextFild = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), self.passwordTextField.bottom+ ZY_HeightScale(20), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Register_SurePassword" placeholder:@"确认密码"];
    }
    self.surePasswordTextFild.isScreat = YES;
    [self.view addSubview:self.surePasswordTextFild];
    self.surePasswordTextFild.block = ^(UITextField * _Nonnull textField) {
        weakSelf.surePasswordString = textField.text;
    };
   
   
    
    
    //注册
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton.layer addSublayer:[self changColorWithWidth:ZY_WidthScale(299) height:ZY_HeightScale(50)]];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = Fonts(18);
    registerButton.layer.cornerRadius = ZY_WidthScale(25);
    registerButton.clipsToBounds = YES;
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.surePasswordTextFild.mas_bottom).mas_offset(ZY_HeightScale(60));
        make.width.equalTo(@(ZY_WidthScale(299)));
        make.height.equalTo(@(ZY_HeightScale(50)));
    }];
    if (self.type == 0) {
        //注册协议
        GH__AgreeView * agreeView= [GH__AgreeView new];
        //用户注册协议的点击方法
        agreeView.block = ^{
            GH_XieYiViewController * vc = [GH_XieYiViewController new];
//            vc.titleString = @"用户注册协议";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [self.view addSubview:agreeView];
        [agreeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.surePasswordTextFild.mas_bottom).mas_offset(ZY_HeightScale(19));
            make.width.equalTo(@(ZY_WidthScale(240)));
            make.height.equalTo(@(ZY_HeightScale(30)));
        }];
         [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }else{
         [registerButton setTitle:@"保存" forState:UIControlStateNormal];
    }
};

//获取验证码
- (void)getCode{
    WeakSelf;
    self.phoneTextField.registerFirstRespoder = YES;
    if (self.phoneString.length == 0) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:@"请输入手机号"];
    }else{
    [GetManager httpManagerNetWorkHudWithUrl:getCode parameters:@{@"type":@(5), @"phone": self.phoneString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        weakSelf.time = 60;
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeji) userInfo:nil repeats:YES];
    } failture:^(NSString * _Nonnull Message) {
        [self AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
    }
}
-(void)timeji
{
    //    if ([self.loginWayString isEqualToString:@"0"]) {
    if (_time == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.getCodeButton.enabled=YES;
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"获取"] forState:UIControlStateNormal];
        _time = 60;
    }else
    {
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"(%lds)",(long)_time] forState:UIControlStateNormal];
       self.getCodeButton.enabled=NO;
        _time--;
    }
    
    

}




//登陆
- (void)loginButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//注册
- (void)registerButtonClick{
    WeakSelf;
    self.phoneTextField.registerFirstRespoder = YES;
    self.codeTextField.registerFirstRespoder = YES;
    self.passwordTextField.registerFirstRespoder = YES;
    self.surePasswordTextFild.registerFirstRespoder = YES;
    if (self.phoneString.length == 0) {
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入手机号"];
    }else if (self.codeString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入验证码"];
    }else if (self.passwordString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入密码"];
    }else if (self.surePasswordString.length == 0){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入确认密码"];
    }else if (![self.surePasswordString isEqualToString:self.passwordString]){
        [self AutomaticAndBlackHudRemoveHudWithText:@"请重新输入确认密码"];
    }else{
        if (self.type == 0) {
            //注册
            [GetManager httpManagerNetWorkHudWithUrl:UserLogin parameters:@{@"type":@(4),@"phone": self.phoneString, @"code":self.codeString, @"password":self.passwordString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                [weakSelf saveUserMessage:data];
            } failture:^(NSString * _Nonnull Message) {
                [self AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }else if(self.type == 1 || self.type == 5){
            //修改密码
            [GetManager httpManagerNetWorkHudWithUrl:forgetPassword parameters:@{@"phone":self.phoneString, @"code":self.codeString, @"password":self.passwordString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                [self AutomaticAndBlackHudRemoveHudWithText:@"修改成功"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } failture:^(NSString * _Nonnull Message) {
                [self AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }else if (self.type == 3){
         //微信绑定手机号
            [GetManager httpManagerNetWorkHudWithUrl:userFirstLogin parameters:@{@"phone":self.phoneString, @"code":self.codeString, @"type":@"wx",@"password":self.passwordString,@"data": self.dataDic} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                 [weakSelf saveUserMessage:data];
            } failture:^(NSString * _Nonnull Message) {
                [self AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }else if (self.type == 4){
            //QQ绑定手机号
            [GetManager httpManagerNetWorkHudWithUrl:userFirstLogin parameters:@{@"phone":self.phoneString, @"code":self.codeString, @"type":@"qq",@"password":self.passwordString, @"data":self.dataDic} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                 [weakSelf saveUserMessage:data];
            } failture:^(NSString * _Nonnull Message) {
                [self AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }
    }
}


- (void)saveUserMessage:(id)data{
    [[Singleton defaultSingleton]setValue:data[@"head"] forKey:KUserHeaderImage];
    [[Singleton defaultSingleton]setValue:[NSString stringWithFormat:@"%@", data[@"id"]] forKey:KUserID];
    [[Singleton defaultSingleton]setValue:data[@"token"] forKey:KToken];
    [[Singleton defaultSingleton]setValue:data[@"nickName"] forKey:KUserName];
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
    [[[NIMSDK sharedSDK] loginManager] login:data[@"wyAccid"] token:data[@"wyToken"] completion:^(NSError * _Nullable error) {
        NSLog(@"网易云信登录成功了");
//        [weakSelf loginWithData:data];
    }];
    NSString * alias = [NSString stringWithFormat:@"u_%@", data[@"id"]];
    [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%ld,%@, %ld", (long)iResCode, iAlias, (long)seq);
    } seq:0];
    NSSet * set = [NSSet setWithObjects:@"wanglvshi", nil];
    [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0];
    [UIApplication sharedApplication].keyWindow.rootViewController = [GH_TabBarViewController new];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
