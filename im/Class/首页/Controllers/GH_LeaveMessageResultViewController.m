//
//  GH_LeaveMessageResultViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_LeaveMessageResultViewController.h"
#import "GH_LeaveMessageResultTableViewCell.h"

#import "GH_ChatViewController.h"
@interface GH_LeaveMessageResultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)UILabel * consultingCountLabel;//咨询号
@property (nonatomic, strong)UILabel * consultingcategory;//咨询类别
@property (nonatomic, strong)UILabel * timeLable;//时间
@property (nonatomic, strong)UILabel * resultLable;//分配结果

@end

@implementation GH_LeaveMessageResultViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = Colors(@"#F8F8F8");
        _table.showsVerticalScrollIndicator = NO;
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
    self.titleText = @"咨询留言";
    self.backText = @"";
    self.view.backgroundColor = Colors(@"#F8F8F8");
    [self creatUI];
    if (self.type == 1) {
        [self getData];
    }else{
        
    }
//    [self getData];
}
- (void)creatUI{
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
    }];
}

- (void)getData{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:selectSeekById parameters:@{@"id":@(self.leaveMessageID)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        weakSelf.model = [GHLeaveMessageResultModel mj_objectWithKeyValues:data];
        [weakSelf.table reloadData];
        NSLog(@"%@", data);
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_LeaveMessageResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_LeaveMessageResultTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.model = self.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ZY_HeightScale(135);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * headerView = [self tableHeaderView];
    [view addSubview:headerView];
    
    UIView * orangeView = [UIView new];
    orangeView.backgroundColor = Colors(@"#FFA425");
    [view addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(headerView.mas_bottom).mas_offset(ZY_HeightScale(16));
        make.width.equalTo(@(ZY_WidthScale(8)));
        make.height.equalTo(@(ZY_HeightScale(9)));
    }];
    UILabel * servericeLabel = [UILabel new];
    servericeLabel.text = @"留言内容";
    servericeLabel.font = Fonts(15);
    servericeLabel.textColor = Colors(@"#666666");
    [view addSubview:servericeLabel];
    [servericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
        make.top.equalTo(headerView.mas_bottom).mas_offset(ZY_HeightScale(13));
    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.model.state == 1) {
        return ZY_HeightScale(149) + 10;
    }else{
    return ZY_HeightScale(109) + 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIView * grayView = [UIView new];
    grayView.backgroundColor = [UIColor clearColor];
    [view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.mas_right);
        make.top.equalTo(view.mas_top);
        make.height.equalTo(@(10));
    }];
    
    UILabel * wordsLable = [UILabel new];
    wordsLable.text = @"留言时间:";
    wordsLable.textColor = Colors(@"#666666");
    wordsLable.font = Fonts(15);
    [view addSubview:wordsLable];
    [wordsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(ZY_WidthScale(28));
        make.width.equalTo(@(ZY_WidthScale(70)));
        make.top.equalTo(grayView.mas_bottom).mas_offset(ZY_HeightScale(18));
    }];
    
    self.timeLable = [UILabel new];
    self.timeLable.text = [GH_Tools transToTimeStemp:self.model.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
    self.timeLable.textColor = Colors(@"#4C4C4C");
    self.timeLable.font = Fonts(15);
    [view addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wordsLable);
//        make.height.equalTo(@(ZY_HeightScale(12)));
        make.left.equalTo(wordsLable.mas_right).mas_offset(ZY_WidthScale(43));
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = Colors(@"#E5E5E5");
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
        make.width.equalTo(@(screenWidth - ZY_WidthScale(30)));
        make.top.equalTo(self.timeLable.mas_bottom).mas_offset(ZY_HeightScale(20));
        make.height.equalTo(@(1));
    }];
    
    UILabel * leaveLable = [UILabel new];
    leaveLable.text = @"分配时间:";
    leaveLable.font = Fonts(15);
    leaveLable.textColor = Colors(@"#666666");
    leaveLable.hidden = YES;
    [view addSubview:leaveLable];
    [leaveLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wordsLable);
        make.top.equalTo(wordsLable.mas_bottom).mas_offset(ZY_HeightScale(13));
    }];
    
    UILabel * leaveMessageLable = [UILabel new];
    leaveMessageLable.text = [GH_Tools transToTimeStemp:self.model.handleTime dateFormatter:@"yyyy-MM-dd HH:mm"];
    leaveMessageLable.textColor = Colors(@"#4C4C4C");
    leaveMessageLable.font = Fonts(15);
    [view addSubview:leaveMessageLable];
    leaveMessageLable.hidden = YES;
    [leaveMessageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leaveLable);
        make.left.equalTo(self.timeLable);
    }];
    
    UILabel * lawyerLable = [UILabel new];
    lawyerLable.text = @"一对一律师:";
    lawyerLable.textColor = Colors(@"#666666");
    lawyerLable.font = Fonts(15);
    [view addSubview:lawyerLable];
    [lawyerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wordsLable);
        make.top.equalTo(lineView.mas_bottom).mas_offset(ZY_HeightScale(22));
    }];
    
    self.resultLable = [UILabel new];
    
    self.resultLable.textColor = Colors(@"#4C4C4C");
    self.resultLable.font = Fonts(15);
    [view addSubview:self.resultLable];
    [self.resultLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLable);
        make.centerY.equalTo(lawyerLable);
        make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(111))
        ;    }];
    
    UIButton * chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chatButton setTitle:@"开始沟通" forState:UIControlStateNormal];
    [chatButton setTitleColor:Colors(@"#616CF2") forState:UIControlStateNormal];
    chatButton.titleLabel.font = Fonts(15);
    chatButton.hidden = YES;
    chatButton.layer.borderColor = Colors(@"#616CF2").CGColor;
    chatButton.layer.borderWidth = 1;
    chatButton.layer.cornerRadius = ZY_WidthScale(14);
    [chatButton addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchDown];
    [view addSubview:chatButton];
    [chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.resultLable);
        make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(15));
        make.width.equalTo(@(ZY_WidthScale(91)));
        make.height.equalTo(@(ZY_HeightScale(29)));
    }];
    
    if (self.model.state == 0) {
        self.resultLable.text = @"待分配";
        chatButton.hidden = YES;
       
    }else{
        self.resultLable.text =self.model.name;
        
        chatButton.hidden = NO;
        leaveMessageLable.hidden = NO;
        leaveLable.hidden = NO;
        [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leaveMessageLable.mas_bottom).mas_offset(ZY_HeightScale(19));
        }];
    }
    return view;
}


/**
 开始沟通
 */
- (void)chat{
    NSLog(@"开始沟通了");
    NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"s_%@", self.model.account] type:NIMSessionTypeP2P];
    GH_ChatViewController *vc = [[GH_ChatViewController alloc] initWithSession:session];
    vc.infoId = [NSString stringWithFormat:@"s_%@", self.model.account];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 表头

 @return 表头view
 */
- (UIView *)tableHeaderView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, ZY_HeightScale(105))];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView * grayView = [UIView new];
    grayView.backgroundColor = Colors(@"#F2F2F2");
    [view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.mas_right);
        make.top.equalTo(view.mas_top);
        make.height.equalTo(@(10));
    }];
    
    self.consultingCountLabel  = [UILabel new];
    self.consultingCountLabel.text = self.model.seekNum;
    self.consultingCountLabel.font = Fonts(15);
    self.consultingCountLabel.textColor = Colors(@"#4C4C4C");
    [view addSubview:self.consultingCountLabel];
    [self.consultingCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(grayView.mas_bottom).mas_offset(ZY_HeightScale(23));
    }];
    
    UIView * orangeView = [UIView new];
    orangeView.backgroundColor = Colors(@"#FFA425");
    [view addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(self.consultingCountLabel.mas_bottom).mas_offset(ZY_HeightScale(27));
        make.width.equalTo(@(ZY_WidthScale(8)));
        make.height.equalTo(@(ZY_HeightScale(9)));
    }];
    UILabel * servericeLabel = [UILabel new];
    servericeLabel.text = @"服务标签";
    servericeLabel.font = Fonts(15);
    servericeLabel.textColor = Colors(@"#666666");
    [view addSubview:servericeLabel];
    [servericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
        make.top.equalTo(self.consultingCountLabel.mas_bottom).mas_offset(ZY_HeightScale(23));
    }];
    
    self.consultingcategory  = [UILabel new];
    self.consultingcategory.text = self.model.labelName;
    self.consultingcategory.textColor = Colors(@"#4C4C4C");
    self.consultingcategory.font = Fonts(15);
    [view addSubview:self.consultingcategory];
    [self.consultingcategory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(servericeLabel);
        make.left.equalTo(servericeLabel.mas_right).mas_offset(ZY_WidthScale(33));
    }];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = Colors(@"#E5E5E5");
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).mas_offset(ZY_WidthScale(15));
        make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(15));
        make.bottom.equalTo(view.mas_bottom).mas_offset(-1);
        make.height.equalTo(@(0.5));
    }];
    return view;
}

@end
