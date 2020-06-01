//
//  GH_UserNameViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_UserNameViewController.h"

@interface GH_UserNameViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField * textField;
@property (nonatomic, copy)NSString * nameString;

@end

@implementation GH_UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"用户名";
    self.backText = @"";
    self.view.backgroundColor = Colors(@"#F8F8F8");
    [self creatUI];
}
- (void)creatUI{
    //完成按钮
    UIButton * OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [OkButton setTitle:@"完成" forState:UIControlStateNormal];
    [OkButton addTarget:self action:@selector(OKBt) forControlEvents:UIControlEventTouchDown];
    [OkButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
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
    
    UIView * whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(grayView.mas_bottom);
        make.height.equalTo(@(ZY_HeightScale(60)));
    }];
    
    self.textField = [UITextField new];
    self.textField.text = self.userName;
    self.textField.delegate = self;
    self.textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
    self.textField.textColor = Colors(@"#333333");
    self.textField.font = Fonts(16);
//    [self.textField setValue:Colors(@"#333333") forKeyPath:@"_placeholderLabel.textColor"];
//    [self.textField setValue:Fonts(16) forKeyPath:@"_placeholderLabel.font"];
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [whiteView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView).mas_offset(ZY_WidthScale(35));
        make.bottom.right.top.equalTo(whiteView);
    }];
}
//判断输入字符串的长度
- (void)changeText:(UITextField *)textField{
//    if (textField.text.length > 8) {
//        [self.textField resignFirstResponder];
//    }
}



//UITextField代理-----输入完成
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.nameString = textField.text;
}
    
- (void)OKBt{
    [self.textField resignFirstResponder];
    NSLog(@"用户名%@", self.nameString);
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:changeUserMessage parameters:@{@"nickName": self.nameString} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [[Singleton defaultSingleton]setUserName:weakSelf.nameString];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failture:^(NSString * _Nonnull Message) {
        [self AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
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
