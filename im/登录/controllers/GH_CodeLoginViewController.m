//
//  GH_CodeLoginViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_CodeLoginViewController.h"
#import "GH_RegisterViewController.h"
@interface GH_CodeLoginViewController ()
@property (nonatomic, strong)GH_PublicTextFieldView * phoneTextField;//手机号
@property (nonatomic, strong)GH_PublicTextFieldView * codeTextField;//验证码
@property (nonatomic, strong)UIButton * getCodeButton;//获取验证码
@property (nonatomic, copy)NSString * phoneString;//手机号
@property (nonatomic, copy)NSString * codeString;//验证码
@property (nonatomic, assign)int flag;
@property (nonatomic, assign)NSInteger time;
@property (nonatomic, strong)NSTimer * timer;
@end

@implementation GH_CodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 2) {
        self.titleText = @"手机号登录";
    }else{
         self.titleText = @"绑定手机号";
    }
    self.backText = @"";
    [self creatUI];
}

-(void)creatUI{
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
    self.phoneTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38),Height_NavBar+ ZY_HeightScale(61), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Register_Phone" placeholder:@"请输入手机号"];
    [self.view addSubview:self.phoneTextField];
    self.phoneTextField.block = ^(UITextField * _Nonnull textField) {
        weakSelf.phoneString = textField.text;
    };
    //验证码
    self.codeTextField = [[GH_PublicTextFieldView alloc]initWithFrame:CGRectMake(ZY_WidthScale(38), self.phoneTextField.bottom+ ZY_HeightScale(20), screenWidth - ZY_WidthScale(76), ZY_HeightScale(55)) headerImage:@"Register_Code" placeholder:@"请输入验证码"];
    self.codeTextField.width = 120;
    [self.view addSubview:self.codeTextField];
    self.codeTextField.block = ^(UITextField * _Nonnull textField) {
        weakSelf.codeString = textField.text;
    };
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
    //注册
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton.layer addSublayer:[self changColorWithWidth:ZY_WidthScale(299) height:ZY_HeightScale(50)]];
    [registerButton setTitle:@"登录" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = Fonts(18);
    registerButton.layer.cornerRadius = ZY_WidthScale(25);
    registerButton.clipsToBounds = YES;
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.codeTextField.mas_bottom).mas_offset(ZY_HeightScale(60));
        make.width.equalTo(@(ZY_WidthScale(299)));
        make.height.equalTo(@(ZY_HeightScale(50)));
    }];
}

//获取验证码
- (void)getCode{
    WeakSelf;
     self.phoneTextField.registerFirstRespoder = YES;
    if (self.phoneString.length == 0) {
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入手机号"];
    }else{
        
        //获取验证码
        [GetManager httpManagerNetWorkHudWithUrl:getCode parameters:@{@"type":@(self.type), @"phone":self.phoneString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            NSLog(@"%@", data);
            weakSelf.time = 60;
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeji) userInfo:nil repeats:YES];
            weakSelf.flag = [data[@"flag"] intValue];
            //绑定成功有密码已经注册过
            if ([data[@"flag"] integerValue] == 2) {
                
            }else if([data[@"flag"] integerValue] == 1){//没有密码需要跳转到注册界面
                //微信绑定
                if (self.type == 0) {
                    [weakSelf bandPhoneWithType:3 data:self.dataDic];
                    //QQ绑定
                }else if (self.type == 1){
                    [weakSelf bandPhoneWithType:4 data:self.dataDic];
                }else{
                    //注册
                    [weakSelf bandPhoneWithType:0 data:nil];
                }
            }else{//失败
                [weakSelf AutomaticAndBlackHudRemoveHudWithText:@"获取验证码失败"];
            }
            
        } failture:^(NSString * _Nonnull Message) {
            [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
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
//绑定手机号
- (void)bandPhoneWithType:(int)type data:(id)data{
    GH_RegisterViewController * vc = [GH_RegisterViewController new];
    vc.type = type;
    vc.dataDic = data;
    if (type == 3 || type == 4) {
        vc.phone = self.phoneString;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


//注册或登录
- (void)registerButtonClick{
    WeakSelf;
    self.phoneTextField.registerFirstRespoder = YES;
    self.codeTextField.registerFirstRespoder = YES;
    if (self.phoneString.length == 0) {
        [self AutomaticAndHudRemoveHudWithText:@"请输入手机号"];
    }else if (self.codeString.length == 0){
        [self AutomaticAndHudRemoveHudWithText:@"请输入验证码"];
    }else{
        
        if (self.type == 2) {//手机号登录
            [GetManager httpManagerNetWorkHudWithUrl:UserLogin parameters:@{@"type": @(2), @"phone": self.phoneString, @"code": self.codeString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                
                [[[NIMSDK sharedSDK] loginManager] login:data[@"wyAccid"] token:data[@"wyToken"] completion:^(NSError * _Nullable error) {
                    NSLog(@"网易云信登录成功了");
                   [weakSelf loginWithData:data];
                }];
//                NSString * alias = [NSString stringWithFormat:@"u_%@", data[@"id"]];
//                [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                    NSLog(@"%ld,%@, %ld", (long)iResCode, iAlias, (long)seq);
//                } seq:0];
            } failture:^(NSString * _Nonnull Message) {
                [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
            }];
        }else{//微信QQ绑定手机号
        if (self.flag == 2) {
            NSString * types = @"";
            if (self.type == 0) {
                types = @"wx";
            }else if (self.type == 1){
                types = @"qq";
            }else{

            }
            [GetManager httpManagerNetWorkHudWithUrl:userFirstLogin parameters:@{@"phone":self.phoneString,@"code": self.codeString, @"type":types, @"data":self.dataDic} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
                NSLog(@"%@", data);
                [[[NIMSDK sharedSDK] loginManager] login:data[@"wyAccid"] token:data[@"wyToken"] completion:^(NSError * _Nullable error) {
                    NSLog(@"网易云信登录成功了");
                    [weakSelf loginWithData:data];
                }];
//                NSString * alias = [NSString stringWithFormat:@"u_%@", data[@"id"]];
//                [JPUSHService setAlias:alias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                    NSLog(@"%ld,%@, %ld", (long)iResCode, iAlias, (long)seq);
//                } seq:0];
            } failture:^(NSString * _Nonnull Message) {
                [weakSelf AutomaticAndHudRemoveHudWithText:Message];
            }];
        }else if(self.flag == 1){
           
        }
        }
      
    }
    
}


- (void)loginWithData:(id)data{
    [[Singleton defaultSingleton]setUserHeaderImage:data[@"head"]];
    [[Singleton defaultSingleton]setUserID:[NSString stringWithFormat:@"%@", data[@"id"]]];
    [[Singleton defaultSingleton]setToken:data[@"token"]];
    [[Singleton defaultSingleton]setUserName:data[@"nickName"]];
    [[Singleton defaultSingleton]setUserPhone:data[@"phone"]];
    [[Singleton defaultSingleton]setCcid:data[@"wyAccid"]];
    [[Singleton defaultSingleton]setWyToken:data[@"wyToken"]];
    [[Singleton defaultSingleton]setIsLogin:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
