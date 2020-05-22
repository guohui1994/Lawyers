//
//  GH_SetSexViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_SetSexViewController.h"
#import "GH_SetSexView.h"
@interface GH_SetSexViewController ()
@property(nonatomic, assign)int  setSex;//性别选择
@end

@implementation GH_SetSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"设置性别";
    self.backText = @"";
    self.view.backgroundColor = Colors(@"#F8F8F8");
    [self creatUI];
}

- (void)creatUI{
    //完成按钮
    UIButton * OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [OkButton setTitle:@"完成" forState:UIControlStateNormal];
    [OkButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
    OkButton.titleLabel.font = Fonts(17);
    [OkButton addTarget:self action:@selector(Ok) forControlEvents:UIControlEventTouchDown];
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
    GH_SetSexView * sex = [GH_SetSexView new];
    sex.sexString = @"男";
    self.setSex = 1;
    //1是男2是女
    WeakSelf;
    sex.block = ^(NSInteger index) {
        if (index == 0) {
            NSLog(@"选择男");
            weakSelf.setSex = 1;
        }else{
            NSLog(@"选择女");
            weakSelf.setSex = 2;
        }
    };
    [self.view addSubview:sex];
    [sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(grayView.mas_bottom);
        make.height.equalTo(@(ZY_HeightScale(121)));
    }];
}

- (void)Ok{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:changeUserMessage parameters:@{@"sex":@(self.setSex)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        if (weakSelf.setSex == 1) {
            [[Singleton defaultSingleton]setUserSex:@"男"];
        }else{
            [[Singleton defaultSingleton]setUserSex:@"女"];
        }
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
