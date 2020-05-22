//
//  GH_MyViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_MyViewController.h"
#import "GH_MyHeaderView.h"
#import "GH_MyCenterView.h"
#import "GH_PersionMessageViewController.h"
#import "GH_FinancingViewController.h"
#import "GH_WebViewController.h"
#import "GH_RegisterViewController.h"
#import "GH_CountAndPasswordLoginViewController.h"
#import "GH_QuestionViewController.h"
#import "GH_QuestionFeedBackViewController.h"
#import "GH_InvitationViewController.h"
#import "GH_MyInvitationViewController.h"
@interface GH_MyViewController ()
@property (nonatomic, strong)GH_MyHeaderView * headerView;
@property (nonatomic, copy)NSString * urlString;//用户协议
@property (nonatomic, copy)NSString * aboutsUs;//关于我们
@property (nonatomic, strong)GH_MyCenterView * centerView;
@end

@implementation GH_MyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
     [self creatUI];
    [self getText];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.hidden = YES;
    self.view.backgroundColor = Colors(@"#F8F8F8");
    [self getData];
    
}
- (void)creatUI{
    __weak typeof(self) weakSelf= self;
    self.headerView = [GH_MyHeaderView new];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.headerView addGestureRecognizer:tap];
    [self.view addSubview:self.headerView];
    self.headerView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .widthIs(self.view.width)
    .heightIs(ZY_HeightScale(200));
    
    UILabel * lable = [UILabel new];
    [self.headerView addSubview:lable];
    lable.text = @"我的";
    lable.font = Fonts(18);
    lable.textColor = [UIColor whiteColor];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerView).mas_offset(ZY_HeightScale(33.5));
    }];
    
    
    GH_MyCenterView * centerView = [GH_MyCenterView new];
    centerView.backgroundColor = [UIColor whiteColor];
    self.centerView = centerView;
    /*
     中间六个按钮的点击方法
     */
    
    centerView.block = ^(NSInteger index) {
        if (index == 0) {
            //我要融资
            GH_FinancingViewController * vc = [GH_FinancingViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else if (index == 1){
            //常见问题
            GH_QuestionViewController * vc = [GH_QuestionViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 2){
            //问题反馈
           GH_QuestionFeedBackViewController  * vc = [GH_QuestionFeedBackViewController new];
//            vc.titleString = @"问题反馈";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 3){
            
            GH_InvitationViewController * vc = [GH_InvitationViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
          
           
        }else if (index == 4){
          
            //修改密码
                      NSLog(@"%ld", index);
            GH_RegisterViewController * vc = [GH_RegisterViewController new];
                       vc.type = 5;
                       [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else if(index == 5){
              //关于我们
            GH_WebViewController * vc = [GH_WebViewController new];
            vc.titleString = @"关于我们";
            vc.urlString = self.aboutsUs;
            [self.navigationController pushViewController:vc animated:YES];
           
        
        }else if (index == 6){
            //我的u邀请
            GH_MyInvitationViewController * vc = [GH_MyInvitationViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            //用户协议
            GH_WebViewController * vc = [GH_WebViewController new];
            vc.titleString = @"用户协议";
            vc.urlString = self.urlString;
            [self.navigationController pushViewController:vc animated:YES];
        };
        };

    
    
    [self.view addSubview:centerView];
    centerView.sd_layout
    .leftSpaceToView(self.view, ZY_WidthScale(0))
    .rightSpaceToView(self.view, ZY_WidthScale(0))
    .topSpaceToView(self.headerView, ZY_HeightScale(0));

    
    
    UIButton * outLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [outLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    [outLogin addTarget:self action:@selector(outLogin) forControlEvents:UIControlEventTouchDown];
    [outLogin setTitleColor:Colors(@"#616CF2") forState:UIControlStateNormal];
    outLogin.titleLabel.font = Fonts(16);
    outLogin.backgroundColor = Colors(@"#F0F0F2");
    outLogin.layer.cornerRadius = ZY_WidthScale(23);
    outLogin.clipsToBounds = YES;
    [self.view addSubview:outLogin];
    [outLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(centerView.mas_bottom).mas_offset(ZY_HeightScale(43));
        make.width.equalTo(@(ZY_WidthScale(170)));
        make.height.equalTo(@(ZY_HeightScale(45)));
    }];

}

- (void)getText{
    WeakSelf;
    [GetManager httpManagerWithUrl:systemSet parameters:@{@"parameterName" : @"rongzi"} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        weakSelf.centerView.titleString = data[@"value"];
       
    } failture:^(NSString * _Nonnull Message) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

- (void)getData{
    
    [GetManager httpManagerWithUrl:systemSet parameters:@{@"parameterName" : @"user_agreement"} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        
         NSString *url = data[@"value"];
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        managers.requestSerializer = [AFHTTPRequestSerializer serializer];
        managers.responseSerializer = [AFHTTPResponseSerializer serializer];
            managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream",nil];
      
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [managers GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               self.urlString  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                [self->wekWeb loadHTMLString:str baseURL:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        });
    } failture:^(NSString * _Nonnull Message) {
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
    
    [GetManager httpManagerNetWorkHudWithUrl:systemSet parameters:@{@"parameterName" : @"about_us"} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"%@", data);
        
        NSString *url = data[@"value"];
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        managers.requestSerializer = [AFHTTPRequestSerializer serializer];
        managers.responseSerializer = [AFHTTPResponseSerializer serializer];
         managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream",nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [managers GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                self.aboutsUs  = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                //                [self->wekWeb loadHTMLString:str baseURL:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        });
    } failture:^(NSString * _Nonnull Message) {
         [GH_Tools AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
    
    
}


/**
 退出登录
 */
- (void)outLogin{
    
//    GH_InvitationViewController * vc = [GH_InvitationViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error) {
        [[Singleton defaultSingleton]setUserHeaderImage:@""];
        [[Singleton defaultSingleton]setUserID:@""];
        [[Singleton defaultSingleton]setToken:@""];
        [[Singleton defaultSingleton]setUserName:@""];
        [[Singleton defaultSingleton]setUserPhone:@""];
        [[Singleton defaultSingleton]setIsLogin:NO];
        [[Singleton defaultSingleton]setUserSex:@""];
        [[Singleton defaultSingleton]setWyToken:@""];
        [[Singleton defaultSingleton]setCcid:@""];
        GH_CountAndPasswordLoginViewController * loginVC = [GH_CountAndPasswordLoginViewController new];
        GH_NavViewController * nav = [[GH_NavViewController alloc]initWithRootViewController:loginVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }];
    
    
}

/**
 个人中心
 */
- (void)tap{
    GH_PersionMessageViewController * vc = [GH_PersionMessageViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
