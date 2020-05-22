//
//  GH_MyInvitationViewController.m
//  im
//
//  Created by ZhiYuan on 2020/5/20.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_MyInvitationViewController.h"
#import "GH_MyIntitationTableViewCell.h"
#import "GHMyInvitationModel.h"
@interface GH_MyInvitationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)GHMyInvitationModel * model;

@end

@implementation GH_MyInvitationViewController

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_MyIntitationTableViewCell class] forCellReuseIdentifier:@"GH_MyIntitationTableViewCell"];
        WeakSelf;
        _table.mj_header = [GH_MJHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"我的邀请";
    self.backText = @"";
    [self creatUI];
    [self getData];
    [self.table.mj_header beginRefreshing];
}

- (void)getData{
    WeakSelf;
    [GetManager httpManagerWithUrl:myInvitation parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        weakSelf.model = [GHMyInvitationModel mj_objectWithKeyValues:data];
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf.table.mj_header endRefreshing];
        [GH_Tools AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}

- (void)creatUI{
    UIView * lineView = [UIView new];
    lineView.backgroundColor = Colors(@"#F2F2F2");
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(Height_NavBar);
        make.height.equalTo(@10);
    }];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(lineView.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZY_HeightScale(77);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_MyIntitationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_MyIntitationTableViewCell" forIndexPath:indexPath];
    cell.model = self.model.list[indexPath.row];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ZY_HeightScale(30);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel * registerLable = [UILabel new];
    registerLable.text = [NSString stringWithFormat:@"已注册:%ld人", self.model.registerUser];
    registerLable.font = Fonts(12);
    registerLable.textColor = Colors(@"#777777");
    [headerView addSubview:registerLable];
    [registerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).mas_offset(ZY_WidthScale(99));
    }];
    
    UILabel * loginLable = [UILabel new];
    loginLable.text = [NSString stringWithFormat:@"已登录:%ld人", self.model.login];
    loginLable.font = Fonts(12);
    loginLable.textColor = Colors(@"#777777");
    [headerView addSubview:loginLable];
    [loginLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView.mas_right).mas_offset(-ZY_WidthScale(99));
    }];
    return headerView;
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
