//
//  GH_LeaveMessageViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_LeaveMessageViewController.h"
#import "GH_LeaveMessageServiceChooseTableViewCell.h"
#import "GHLeaveMessageSelectLableModel.h"
@interface GH_LeaveMessageViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (nonatomic, strong)UITableView * table;
@property (nonatomic, strong)UITextView * textView;
@property (nonatomic, copy)NSString * submitText;
@property (nonatomic, assign)NSInteger selectIndex;
@property (nonatomic, strong)NSMutableArray * datasourceArray;//标签数组
@end

@implementation GH_LeaveMessageViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[GH_LeaveMessageServiceChooseTableViewCell class] forCellReuseIdentifier:@"GH_LeaveMessageServiceChooseTableViewCell"];
        _table.tableFooterView = [self tableFooterView];
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"咨询留言";
    self.backText = @"";
    self.selectIndex = -1;
    self.datasourceArray = [NSMutableArray new];
    [self creatUI];
    [self getData];
}

- (void)creatUI{
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Height_NavBar);
        make.bottom.equalTo(self.view);
    }];
}

- (void)getData{
    WeakSelf;
    [GetManager httpManagerWithUrl:selectLabel parameters:@{} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
        NSLog(@"-----%@", data);
        NSArray * array = [GHLeaveMessageSelectLableModel mj_objectArrayWithKeyValuesArray:data];
        for (GHLeaveMessageSelectLableModel * model in array) {
            [self.datasourceArray addObject:model];
        }
        [weakSelf.table reloadData];
    } failture:^(NSString * _Nonnull Message) {
        [weakSelf AutomaticAndBlackHudRemoveHudWithText:Message];
    }];
}


#pragma mark --tabele的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return   [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GH_LeaveMessageServiceChooseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_LeaveMessageServiceChooseTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectLabelArray = self.datasourceArray;
    WeakSelf;
    cell.block = ^(NSInteger index) {
        NSLog(@"%ld", index);
        weakSelf.selectIndex = index;
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ZY_HeightScale(65);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIView * grayView = [UIView new];
    grayView.backgroundColor = Colors(@"#F2F2F2");
        [view addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(@(10));
        }];
    
    UIView * orangeView = [UIView new];
    orangeView.backgroundColor = Colors(@"#FFA425");
        [view addSubview:orangeView];
        [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
            make.top.equalTo(grayView.mas_bottom).mas_offset(ZY_HeightScale(26));
            make.width.equalTo(@(ZY_WidthScale(8)));
            make.height.equalTo(@(ZY_HeightScale(9)));
        }];
    UILabel * servericeLabel = [UILabel new];
    servericeLabel.text = @"选择服务标签(单选）";
    servericeLabel.font = Fonts(15);
    servericeLabel.textColor = Colors(@"#666666");
        [view addSubview:servericeLabel];
        [servericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
            make.top.equalTo(grayView.mas_bottom).mas_offset(ZY_HeightScale(23));
        }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return ZY_HeightScale(270);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [UIView new];
    UIView * orangeView = [UIView new];
    orangeView.backgroundColor = Colors(@"#FFA425");
    [footerView addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).mas_offset(ZY_WidthScale(15));
        make.top.equalTo(footerView).mas_offset(ZY_HeightScale(26));
        make.width.equalTo(@(ZY_WidthScale(8)));
        make.height.equalTo(@(ZY_HeightScale(9)));
    }];
    UILabel * servericeLabel = [UILabel new];
    servericeLabel.text = @"咨询留言内容";
    servericeLabel.font = Fonts(15);
    servericeLabel.textColor = Colors(@"#666666");
    [footerView addSubview:servericeLabel];
    [servericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
        make.top.equalTo(footerView.mas_top).mas_offset(ZY_HeightScale(23));
    }];
    
    self.textView = [UITextView new];
    self.textView.text = @"请详细的输入您的留言内容，便于我们更好的为您解答!";
    self.textView.textColor = Colors(@"#999999");
    self.textView.font = Fonts(15);
    self.textView.backgroundColor = Colors(@"#FEFBEF");
    self.textView.delegate = self;
    [footerView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).mas_offset(ZY_WidthScale(15));
        make.right.equalTo(footerView.mas_right).mas_offset(-ZY_WidthScale(15));
        make.top.equalTo(servericeLabel.mas_bottom).mas_offset(ZY_HeightScale(21));
        make.height.equalTo(@(ZY_HeightScale(215)));
    }];
    return footerView;
}



#pragma mark ---TextView代理
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:@"请详细的输入您的留言内容，便于我们更好的为您解答!"]) {
        self.textView.text = @"";
    }else{
        self.textView.text = self.submitText;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"%@", textView.text);
    self.submitText = textView.text;
}


/**
 提交button
 */
- (UIView *)tableFooterView{
    UIView * submitView = [UIView new];
    submitView.frame = CGRectMake(0, 0, screenWidth, ZY_HeightScale(110));
    UIButton * submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton.layer addSublayer:[self changColorWithWidth:ZY_WidthScale(299) height:ZY_HeightScale(50)]];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.titleLabel.font = Fonts(18);
    submitButton.layer.cornerRadius = ZY_WidthScale(25);
    submitButton.clipsToBounds = YES;
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];
    [submitView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(submitView);
        make.width.equalTo(@(ZY_WidthScale(299)));
        make.height.equalTo(@(ZY_HeightScale(50)));
    }];
    return submitView;
}

/**
 提交的方法
 */
- (void)submit{
    [self.textView resignFirstResponder];
    if (self.selectIndex == -1) {
        NSLog(@"请选择标签");
        [self AutomaticAndHudRemoveHudWithText:@"请选择标签"];
    }else if (self.submitText.length == 0){
        NSLog(@"请输入提交意见");
        [self AutomaticAndHudRemoveHudWithText:@"请输入提交意见"];
    }else{
        WeakSelf
        [GetManager httpManagerNetWorkHudWithUrl:leaveMessage parameters:@{@"labelId":@(self.selectIndex),@"seek":self.submitText} httpModel:POST success:^(id  _Nonnull data, NSString * _Nonnull Message) {
            NSLog(@"%@", data);
            [weakSelf customeNoticeHudWithTitle:@"提交成功" content:@"等待后台为您分配律师"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } failture:^(NSString * _Nonnull Message) {
            [weakSelf AutomaticAndHudRemoveHudWithText:Message];
        }];
        
    }
}

@end
