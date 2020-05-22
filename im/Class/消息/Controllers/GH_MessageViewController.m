//
//  GH_MessageViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_MessageViewController.h"
#import "GH_MessageTableViewCell.h"
#import "GH_SystemMessageViewController.h"
@interface GH_MessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView * table;
@end

@implementation GH_MessageViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[GH_MessageTableViewCell class] forCellReuseIdentifier:@"GH_MessageTableViewCell"];
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"消息";
    [self creatUI];
}

- (void)creatUI{
    [self.view addSubview:self.table];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ZY_HeightScale(77);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_MessageTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_SystemMessageViewController * vc = [GH_SystemMessageViewController new];
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
