//
//  GH_AlredyBuyServiceDetaileViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_AlredyBuyServiceDetaileViewController.h"
#import "GH_BuyLawyerServiceTableViewCell.h"
#import "GH_LeaveMessageResultTableViewCell.h"
//#import "NIMSessionViewController.h"
#import "GH_ChatViewController.h"
@interface GH_AlredyBuyServiceDetaileViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)UILabel * serviceNumber;//服务号
@property (nonatomic, strong)UILabel * priceLable;//价格
@property (nonatomic, strong)UILabel * timeLable;//时间
@property (nonatomic, strong)UILabel * stateLable;//状态
@property (nonatomic, strong)UIButton * startChatButton;//开始沟通
@property (nonatomic, strong)UILabel * fenPeiLable;//分配lable
@property (nonatomic, strong)UILabel * fenPeiTimeLable;//分配时间

@property (nonatomic, assign)BOOL isHidden;//是否隐藏分配时间
@end

@implementation GH_AlredyBuyServiceDetaileViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor whiteColor];
        _table.dataSource = self;
        _table.delegate = self;
        _table.showsVerticalScrollIndicator = NO;
        [_table registerClass:[GH_BuyLawyerServiceTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        [_table registerClass:[GH_LeaveMessageResultTableViewCell class] forCellReuseIdentifier:@"GH_LeaveMessageResultTableViewCell"];
    }
    return _table;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.titleText = self.recommendModel.serviceName;
    }else if (self.type == 2){
        [self getData];
    }else{
    self.titleText = self.model.serviceName;
    }
    self.backText = @"";
    self.isHidden = YES;
    self.view.backgroundColor = Colors(@"#F8F8F8");
    [self creatUI];
}

- (void)getData{
    [GetManager httpManagerWithUrl:selectOrderById parameters:@{@"orderId":@(self.orderID)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        self.model = [GHAlreadyBuyServiceListListModel mj_objectWithKeyValues:data];
         self.titleText = self.model.serviceName;
        [self.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        
    }];
}

- (void)creatUI{
    //灰色线条
    UIView * grayView = [UIView new];
    grayView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
        make.height.equalTo(@(10));
    }];
    //table
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(grayView.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        GH_BuyLawyerServiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (self.type == 1) {
//
//        }else if (self.type == 2){
//
//        }else{
        cell.alreadyServiceModel = self.model;
//        }
        return cell;
    }else{
        GH_LeaveMessageResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_LeaveMessageResultTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.alreadyModel = self.model;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 0) {
        self.serviceNumber = [UILabel new];
        self.serviceNumber.text = self.model.orderNum;
        self.serviceNumber.textColor = Colors(@"#4C4C4C");
        self.serviceNumber.font = Fonts(15);
        [view addSubview:self.serviceNumber];
        [self.serviceNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
            make.bottom.equalTo(view.mas_bottom).mas_offset(-ZY_WidthScale(3));
        }];
    }else{
        UILabel * orangeView = [UILabel new];
        orangeView.backgroundColor = Colors(@"#FFA425");
        [view addSubview:orangeView];
        [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
            make.bottom.equalTo(view.mas_bottom).mas_offset(-ZY_HeightScale(5));
            make.width.height.equalTo(@(ZY_WidthScale(8)));
        }];
        
        //备注
        UILabel * beiZhuLabel = [UILabel new];
        beiZhuLabel.text = @"备注";
        beiZhuLabel.textColor = Colors(@"#666666");
        beiZhuLabel.font = Fonts(15);
        [view addSubview:beiZhuLabel];
        [beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
            make.bottom.equalTo(orangeView.mas_bottom).mas_offset(ZY_HeightScale(2));
        }];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ZY_HeightScale(36);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    if (section == 0) {
        
    }else{
        //灰色线条
        UIView * grayView = [UIView new];
        grayView.backgroundColor = Colors(@"#F8F8F8");
        [view addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(view);
            make.height.equalTo(@(10));
        }];
        //已付定金
        UIView * orangerView = [UIView new];
        orangerView.backgroundColor = Colors(@"#FFFDF6");
        [view addSubview:orangerView];
        [orangerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
            make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(15));
            make.top.equalTo(grayView.mas_bottom).mas_offset(ZY_HeightScale(17));
            make.height.equalTo(@(ZY_HeightScale(40)));
        }];
        //price
        self.priceLable = [UILabel new];
        self.priceLable.text = [NSString stringWithFormat:@"已支付预付款：￥%.2f", self.model.orderAmount];
        self.priceLable.textColor = Colors(@"#FFA425");
        self.priceLable.font = Fonts(16);
        [view addSubview:self.priceLable];
        [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orangerView).mas_offset(ZY_WidthScale(14));
            make.centerY.equalTo(orangerView);
        }];
        //购买时间
        UILabel * buyTimeLable = [UILabel new];
        buyTimeLable.text = @"购买时间:";
        buyTimeLable.font = Fonts(15);
        buyTimeLable.textColor = Colors(@"#666666");
        [view addSubview:buyTimeLable];
        [buyTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(28));
            make.top.equalTo(orangerView.mas_bottom).mas_offset(ZY_HeightScale(18));
        }];
        self.timeLable = [UILabel new];
        self.timeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(16)];
        self.timeLable.textColor = Colors(@"#4C4C4C");
        self.timeLable.text = [GH_Tools transToTimeStemp:self.model.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        [view addSubview:self.timeLable];
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(10));
            make.centerY.equalTo(buyTimeLable);
        }];
        
      
        
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = Colors(@"#E5E5E5");
        [view addSubview:lineView];
        
        if (self.model.account.length == 0) {
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).mas_offset(ZY_WidthScale(16));
                make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(16));
                make.top.equalTo(buyTimeLable.mas_bottom).mas_offset(ZY_HeightScale(19));
                make.height.equalTo(@(0.5));
            }];
        }else{
            self.fenPeiLable = [UILabel new];
            self.fenPeiLable.text = @"分配时间:";
            self.fenPeiLable.font = Fonts(15);
            self.fenPeiLable.textColor = Colors(@"#666666");
            [view addSubview:self.fenPeiLable];
            [self.fenPeiLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(buyTimeLable);
            make.top.equalTo(buyTimeLable.mas_bottom).mas_offset(ZY_HeightScale(13));
            }];
            
            self.fenPeiTimeLable = [UILabel new];
            self.fenPeiTimeLable = [UILabel new];
            self.fenPeiTimeLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(16)];
            self.fenPeiTimeLable.textColor = Colors(@"#4C4C4C");
            self.fenPeiTimeLable.text = [GH_Tools transToTimeStemp:self.model.handleTime dateFormatter:@"yyyy-MM-dd HH:mm"];
            [view addSubview:self.fenPeiTimeLable];
            [self.fenPeiTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.fenPeiLable);
                make.left.equalTo(self.timeLable);
            }];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).mas_offset(ZY_WidthScale(16));
                make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(16));
                make.top.equalTo(self.fenPeiTimeLable.mas_bottom).mas_offset(ZY_HeightScale(19));
                make.height.equalTo(@(0.5));
            }];
        }
        
        
        //分配状态
        UILabel * lawyerLabel = [UILabel new];
        lawyerLabel.text = @"一对一律师:";
        lawyerLabel.font = Fonts(15);
        lawyerLabel.textColor = Colors(@"#666666");
        [view addSubview:lawyerLabel];
        [lawyerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(28));
            make.top.equalTo(lineView.mas_bottom).mas_offset(ZY_HeightScale(22));
        }];
        self.stateLable = [UILabel new];
        self.stateLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(16)];
        self.stateLable.textColor = Colors(@"#4C4C4C");
        
      
        [view addSubview:self.stateLable];
        [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lawyerLabel);
            make.left.equalTo(self.timeLable);
            make.right.equalTo(view.mas_right).mas_offset(-116);
        }];
        
        self.startChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.startChatButton setTitle:@"开始沟通" forState:UIControlStateNormal];
        [self.startChatButton setTitleColor:Colors(@"#616CF2") forState:UIControlStateNormal];
        self.startChatButton.titleLabel.font = Fonts(15);
        self.startChatButton.layer.cornerRadius = ZY_WidthScale(14);
        self.startChatButton.clipsToBounds = YES;
        self.startChatButton.layer.borderWidth = 1;
        self.startChatButton.layer.borderColor = Colors(@"#616CF2").CGColor;
        [self.startChatButton addTarget:self action:@selector(startChat) forControlEvents:UIControlEventTouchDown];
        [view addSubview:self.startChatButton];
        [self.startChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(15));
            make.centerY.equalTo(self.stateLable);
            make.width.equalTo(@(ZY_WidthScale(91)));
            make.height.equalTo(@(ZY_HeightScale(29)));
        }];
        if (self.model.account.length == 0) {
            
            self.stateLable.text = @"待分配";
            self.startChatButton.hidden = YES;
        }else{
            self.stateLable.text = self.model.lawyerName;
            self.startChatButton.hidden = NO;
        }
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        if (self.model.state == 0) {
            return ZY_HeightScale(176);
        }else{
            return ZY_HeightScale(211);
        }
    }
}


//开始沟通
- (void)startChat{
    NSLog(@"开始沟通");
    
    NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"s_%@", self.model.account] type:NIMSessionTypeP2P];
    GH_ChatViewController *vc = [[GH_ChatViewController alloc] initWithSession:session];
    vc.infoId = [NSString stringWithFormat:@"s_%@", self.model.account];
    self.navigationController.navigationBar.hidden = NO;
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
