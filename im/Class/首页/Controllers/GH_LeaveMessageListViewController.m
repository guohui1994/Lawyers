//
//  GH_LeaveMessageListViewController.m
//  im
//
//  Created by ZhiYuan on 2020/4/21.
//  Copyright © 2020 郭徽. All rights reserved.
//

#import "GH_LeaveMessageListViewController.h"
#import "GH_LawyerServiceListTableViewCell.h"
#import "GHLeaveMessageResultModel.h"
#import "GH_LeaveMessageResultViewController.h"
#import "GH_LeaveMessageViewController.h"
@interface GH_LeaveMessageListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * table;

@property (nonatomic, strong)NSMutableArray * datasourceArray;

@property (nonatomic, assign)NSInteger pageNum;

@property (nonatomic, assign)NSInteger allPage;
@end

@implementation GH_LeaveMessageListViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
         [_table registerClass:[GH_LawyerServiceListTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        WeakSelf;
        _table.mj_header = [GH_MJHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
        _table.mj_footer = [GH_MJFooter footerWithRefreshingBlock:^{
            [weakSelf getMoreData];
        }];
    };
    return _table;
}
- (NSMutableArray *)datasourceArray{
    if (!_datasourceArray) {
        _datasourceArray = [NSMutableArray new];
    }
    return _datasourceArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [self.table.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"留言列表";
    self.backText = @"";
    self.pageNum = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    
    
    
}

- (void)getData{
    WeakSelf;
    [GetManager httpManagerNetWorkHudWithUrl:leaveMessageResult parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        [weakSelf.datasourceArray removeAllObjects];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        weakSelf.table.mj_footer.hidden = NO;
        weakSelf.allPage = [data[@"pages"] integerValue];
//        if (weakSelf.allPage == 1) {
//            weakSelf.table.mj_footer.hidden = YES;
//        }else{
//             weakSelf.table.mj_footer.hidden = NO;
//        }
        
        NSArray * array = [GHLeaveMessageResultModel mj_objectArrayWithKeyValuesArray:data[@"list"]];
        for (GHLeaveMessageResultModel * model in array) {
            [weakSelf.datasourceArray addObject:model];
        }
        [weakSelf.table reloadData];
        weakSelf.pageNum = 1;
        NSLog(@"%@", data);
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}
- (void)getMoreData{
    WeakSelf;
    self.pageNum ++;
    NSLog(@"%ld", self.pageNum);
    [GetManager httpManagerNetWorkHudWithUrl:leaveMessageResult parameters:@{@"pageNum":@(self.pageNum)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
           [weakSelf.table.mj_header endRefreshing];
           [weakSelf.table.mj_footer endRefreshing];
           NSArray * array = [GHLeaveMessageResultModel mj_objectArrayWithKeyValuesArray:data[@"list"]];
           for (GHLeaveMessageResultModel * model in array) {
               [weakSelf.datasourceArray addObject:model];
           }
        if (weakSelf.allPage == weakSelf.pageNum) {
            weakSelf.table.mj_footer.hidden = YES;
        }
           [weakSelf.table reloadData];
           NSLog(@"%@", data);
       } failture:^(NSString * _Nonnull Message) {
           [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
           self.pageNum--;
       }];
}


- (void)creatUI{
    //已购买过的服务按钮
    UIButton * buySeiviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buySeiviceButton setTitle:@"留言" forState:UIControlStateNormal];
    [buySeiviceButton addTarget:self action:@selector(buyServiceButtonClick) forControlEvents:UIControlEventTouchDown];
    [buySeiviceButton setTitleColor:Colors(@"#333333") forState:UIControlStateNormal];
    buySeiviceButton.titleLabel.font = Fonts(15);
    [self.customNavBar addSubview:buySeiviceButton];
    [buySeiviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.customNavBar.mas_right).mas_offset(-ZY_WidthScale(15));
        make.bottom.equalTo(self.customNavBar.mas_bottom);
        make.height.equalTo(@(44));
    }];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).mas_offset(UIEdgeInsetsMake(Height_NavBar, 0, 0, 0));
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZY_HeightScale(110);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_LawyerServiceListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.leaveMessageModel = self.datasourceArray[indexPath.section];
    cell.isHiddenServiceNumber = YES;
    cell.isHiddenMoney = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_LeaveMessageResultViewController * vc = [GH_LeaveMessageResultViewController new];
    vc.model = self.datasourceArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }else{
        return 0.1;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //在这里实现删除操作
    WeakSelf;
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"确认删除留言?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GHLeaveMessageResultModel * model = self.datasourceArray[indexPath.section];
        [GetManager httpManagerNetWorkHudWithUrl:deleteLeaveMessage parameters:@{@"id":@(model.leaveMessageID)} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            [GH_Tools AutomaticAndBlackHudRemoveHudWithText:@"删除成功"];
            [weakSelf.table.mj_header beginRefreshing];
        } failture:^(NSString * _Nonnull Message) {
            
        }];
    }];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:cancle];
    [alter addAction:sure];
    [self presentViewController:alter animated:YES completion:nil];
   
    
}
- (void)buyServiceButtonClick{
    GH_LeaveMessageViewController * vc = [GH_LeaveMessageViewController new];
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
