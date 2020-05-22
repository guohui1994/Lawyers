//
//  GH_SetPhoneViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_SetPhoneViewController.h"
#import "GH_SetPhone.h"
@interface GH_SetPhoneViewController ()
@property (nonatomic, strong)GH_SetPhone * setPhone;
@property (nonatomic, copy)NSString * phoneString;//手机号
@property (nonatomic, copy)NSString * codeString;//验证码
@property (nonatomic, assign)NSInteger time;
@property (nonatomic, strong)NSTimer * timer;
@end

@implementation GH_SetPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"设置手机号";
    self.backText = @"";
    self.view.backgroundColor = Colors(@"#F8F8F8");
    [self creatUI];
    // Do any additional setup after loading the view.
}
- (void)creatUI{
    //完成按钮
    UIButton * OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [OkButton setTitle:@"完成" forState:UIControlStateNormal];
    [OkButton addTarget:self action:@selector(OKBt) forControlEvents:UIControlEventTouchDown];
    [OkButton setTitleColor:Colors(@"#333333") forState:UIControlStateNormal];
    OkButton.titleLabel.font = Fonts(17);
    [self.customNavBar addSubview:OkButton];
    [OkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.customNavBar.mas_right).mas_offset(-ZY_WidthScale(15));
        make.bottom.equalTo(self.customNavBar.mas_bottom);
        make.height.equalTo(@(44));
    }];
    //灰色线条
    UIView * grayView = [UIView new];
    grayView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
        make.height.equalTo(@(10));
    }];
    self.setPhone = [GH_SetPhone new];
    self.setPhone.backgroundColor = [UIColor whiteColor];
    WeakSelf;
    //手机号
    self.setPhone.block = ^(NSString * _Nonnull phoneString) {
        weakSelf.phoneString = phoneString;
    };
    //验证码
    self.setPhone.block1 = ^(NSString * _Nonnull codeString) {
        weakSelf.codeString = codeString;
    };
    [self.setPhone.getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.setPhone];
    [self.setPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(grayView.mas_bottom);
        make.height.equalTo(@(ZY_HeightScale(120)));
    }];
}


- (void)getCode{
    [self.setPhone.phoneTextField resignFirstResponder];
    WeakSelf;
    if (self.phoneString.length == 0) {
        [self AutomaticAndBlackHudRemoveHudWithText:@"请输入手机号"];
    }else{
        [GetManager httpManagerNetWorkHudWithUrl:getCode parameters:@{@"type": @(5), @"phone":self.phoneString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            weakSelf.time = 60;
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeji) userInfo:nil repeats:YES];
        } failture:^(NSString * _Nonnull Message) {
            [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
        }];
    }
}

- (void)OKBt{
    [self.setPhone.phoneTextField resignFirstResponder];
    [self.setPhone.codeTextField resignFirstResponder];
    NSLog(@"手机号%@, 验证码%@", self.phoneString, self.codeString);
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:changUserPhone parameters:@{@"phone":self.phoneString, @"code":self.codeString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [[Singleton defaultSingleton]setUserPhone:weakSelf.phoneString];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

-(void)timeji
{
    //    if ([self.loginWayString isEqualToString:@"0"]) {
    if (_time == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.setPhone.getCodeButton.enabled=YES;
        [self.setPhone.getCodeButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        _time = 60;
    }else
    {
        [self.setPhone.getCodeButton setTitle:[NSString stringWithFormat:@"(%lds)",(long)_time] forState:UIControlStateNormal];
        self.setPhone.getCodeButton.enabled=NO;
        _time--;
    }
    
    
    
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
