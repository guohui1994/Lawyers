//
//  GH_HomeViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_HomeViewController.h"
#import "GH_LeaveMessageViewController.h"
#import "GH_LeaveMessageResultViewController.h"
#import "GH_LawyerServiceListViewController.h"
#import "GHHomeBanaerModel.h"
#import "GHLeaveMessageStateModel.h"
#import "GH_LeaveMessageListViewController.h"
#import "SDCycleScrollView.h"
@interface GH_HomeViewController ()

@property (nonatomic, strong)SDCycleScrollView * headerImage;
@property (nonatomic, strong)GHHomeBanaerModel * model;
@property (nonatomic, strong)GHLeaveMessageStateModel * stateModel;
@property (nonatomic, strong)NSMutableArray * bannerArray;
@end

@implementation GH_HomeViewController

-(NSMutableArray *)bannerArray{
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray new];
    }
    return _bannerArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self getData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"首页";
    self.view.backgroundColor = Colors(@"#F8F8F8");
   
}
//获取banber
- (void)getData{
    [GetManager httpManagerNetWorkHudWithUrl:HomeBanner parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [self.bannerArray removeAllObjects];
        self.model = [GHHomeBanaerModel mj_objectWithKeyValues:data];
//         [self creatUI];
        NSArray * array = data[@"banner"];
        [self.bannerArray addObjectsFromArray:array];
        
        [self getLeaveMessageState];
    } failture:^(NSString * _Nonnull Message) {
        [self AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}
//获取留言状态
- (void)getLeaveMessageState{
    [GetManager httpManagerWithUrl:leaveState parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        self.stateModel = [GHLeaveMessageStateModel mj_objectWithKeyValues:data];
        [self creatUI];
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}


- (void)creatUI{
    //头部视图
    self.headerImage = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:self.bannerArray];
    self.headerImage.autoScrollTimeInterval = 3;
//    [self.headerImage setImageWithURL:[NSURL URLWithString:self.model.banner] placeholder:nil];
  
    [self.view addSubview:self.headerImage];
//    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view).mas_offset(Height_NavBar);
//        make.height.equalTo(@(ZY_HeightScale(210)));
//    }];
    self.headerImage.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.view, Height_NavBar)
    .rightEqualToView(self.view)
    .heightIs(ZY_HeightScale(210));
    
//    中间视图
    UIView * bgView = [UIView new];
    bgView.backgroundColor = Colors(@"#F8F8F8");
    [self.view addSubview:bgView];
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.headerImage.mas_bottom).mas_offset(ZY_HeightScale(23));
//        make.height
//    }];
    bgView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.headerImage, ZY_HeightScale(23))
    .rightEqualToView(self.view)
    .autoHeightRatio(0);
    
    
    NSMutableArray * temp = [NSMutableArray new];
    NSArray * imageArray = @[@"Home_leaveMessage", @"Home_buyLawyerServerice"];
    NSArray * titleArray = @[@"咨询留言", @"购买法律服务"];
    for (int i = 0; i < 2; i++) {
        UIButton * clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clickButton.tag = 9527 + i;
        [clickButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        [bgView addSubview:clickButton];
        clickButton.backgroundColor = [UIColor whiteColor];
        clickButton.sd_layout.heightIs(ZY_HeightScale(210));
        
        UIImageView * images = [UIImageView new];
        images.image = Images(imageArray[i]);
        [clickButton addSubview:images];
        images.sd_layout
        .centerXEqualToView(clickButton)
        .topSpaceToView(clickButton, ZY_HeightScale(28))
        .widthIs(ZY_WidthScale(118))
        .heightIs(ZY_WidthScale(118));
        images.sd_cornerRadius = @(ZY_WidthScale(25));
        images.clipsToBounds = YES;
        
        UILabel * titleLable = [UILabel new];
        titleLable.text = titleArray[i];
        titleLable.font = Fonts(16);
        titleLable.textColor = Colors(@"#666666");
        titleLable.textAlignment = NSTextAlignmentCenter;
        [clickButton addSubview:titleLable];
        titleLable.sd_layout
        .centerXEqualToView(clickButton)
        .topSpaceToView(images, ZY_HeightScale(22))
        .widthIs(150)
        .heightIs(ZY_HeightScale(15));
        
        [temp addObject:clickButton];
    }
    
    [bgView setupAutoWidthFlowItems:temp withPerRowItemsCount:2 verticalMargin:0 horizontalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
}

- (void)click:(UIButton *)sender{
    if (sender.tag - 9527 == 0) {
        if (self.stateModel.state == 0) {
            //留言咨询
            GH_LeaveMessageViewController * vc = [GH_LeaveMessageViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //留言咨询结果界面
//            GH_LeaveMessageResultViewController * resultVc = [GH_LeaveMessageResultViewController new];
//                    [self.navigationController pushViewController:resultVc animated:YES];
            GH_LeaveMessageListViewController * leaveMessageVC = [GH_LeaveMessageListViewController new];
            [self.navigationController pushViewController:leaveMessageVC animated:YES];
        }
    }else{
        //购买法律服务
        GH_LawyerServiceListViewController * vc = [GH_LawyerServiceListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
