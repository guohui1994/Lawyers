//
//  GH_AppraiceCompletedViewController.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/18.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_AppraiceCompletedViewController.h"
#import "GH_BuyLawyerServiceTableViewCell.h"
#import "GH_LeaveMessageResultTableViewCell.h"
#import "YYStarView.h"
#import "GH_OrderSelectPhotoAndTextTableViewCell.h"
@interface GH_AppraiceCompletedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView * table;
@property (nonatomic,strong)UILabel * placeOrderLable;//下单时间
@property (nonatomic, strong)UILabel * completedLable;//完成时间;
@property (nonatomic, strong)UILabel * appriaceCompletedLable;//评价完成时间
@property (nonatomic, strong)YYStarView * starView;//星星
@end

@implementation GH_AppraiceCompletedViewController

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[GH_BuyLawyerServiceTableViewCell class] forCellReuseIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        [_table registerClass:[GH_LeaveMessageResultTableViewCell class] forCellReuseIdentifier:@"GH_LeaveMessageResultTableViewCell"];
        [_table registerClass:[GH_OrderSelectPhotoAndTextTableViewCell class] forCellReuseIdentifier:@"GH_OrderSelectPhotoAndTextTableViewCell"];
    }
    return _table;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleText = @"订单详情";
    self.backText = @"";
    [self creatUI];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.table cellHeightForIndexPath:indexPath cellContentViewWidth:screenWidth tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        GH_BuyLawyerServiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_BuyLawyerServiceTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.stateString = @"已评价";
        cell.isShowStateLable = YES;
         cell.isShowWeiKuanLable = YES;
        cell.orderModel = self.model;
//        cell.isShowStateLable = YES;
       
        return cell;
    }else if(indexPath.section == 1){
        GH_LeaveMessageResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_LeaveMessageResultTableViewCell"];
        cell.orderModel = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        GH_OrderSelectPhotoAndTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GH_OrderSelectPhotoAndTextTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.appriceString = self.model.evaluateText;
        //string转data
        NSData * jsonData = [self.model.evaluatePic dataUsingEncoding:NSUTF8StringEncoding];
        //json解析
        NSArray * obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        cell.photoArrayUrl = obj;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if(section == 1){
        return ZY_HeightScale(30);
    }else{
        return ZY_HeightScale(88);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        UIView * orangeView = [UIView new];
        orangeView.backgroundColor = Colors(@"#FFA425");
        [view addSubview:orangeView];
        [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
            make.top.equalTo(view.mas_top).mas_offset(ZY_HeightScale(16));
            make.width.equalTo(@(ZY_WidthScale(8)));
            make.height.equalTo(@(ZY_HeightScale(9)));
        }];
        UILabel * servericeLabel = [UILabel new];
        servericeLabel.text = @"备注";
        servericeLabel.font = Fonts(15);
        servericeLabel.textColor = Colors(@"#666666");
        [view addSubview:servericeLabel];
        [servericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
            make.top.equalTo(view.mas_top).mas_offset(ZY_HeightScale(13));
        }];
        return view;
    }else if (section == 2){
        
        UIView * orangeView = [UIView new];
        orangeView.backgroundColor = Colors(@"#FFA425");
        [view addSubview:orangeView];
        [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(15));
            make.top.equalTo(view.mas_top).mas_offset(ZY_HeightScale(16));
            make.width.equalTo(@(ZY_WidthScale(8)));
            make.height.equalTo(@(ZY_HeightScale(9)));
        }];
        UILabel * servericeLabel = [UILabel new];
        servericeLabel.text = @"评价内容";
        servericeLabel.font = Fonts(15);
        servericeLabel.textColor = Colors(@"#666666");
        [view addSubview:servericeLabel];
        [servericeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(orangeView.mas_right).mas_offset(ZY_WidthScale(6));
            make.top.equalTo(view.mas_top).mas_offset(ZY_HeightScale(13));
        }];
        UILabel * lable = [UILabel new];
        lable.text = @"满意程度";
        lable.textColor = Colors(@"#4C4C4C");
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZY_WidthScale(15)];
        [view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(28));
            make.top.equalTo(servericeLabel.mas_bottom).mas_offset(ZY_HeightScale(24));
        }];
        self.starView = [YYStarView new];
        //可以默认是几个星星
            self.starView.starScore = self.model.evaluateStar;
        //1是不可以选择2是可以选择
        self.starView.type = 1;
        //每颗星的大小，如果不设置，则按照图片大小自适应
        self. starView.starSize = CGSizeMake(18, 18);
   
        self.starView.starDarkImageName = @"Star_Gray";
        self.starView.starBrightImageName = @"Star_Light";
        self.starView.starSpacing = 8;
        [view addSubview:self.starView];
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable);
            make.left.equalTo(lable.mas_right).mas_offset(ZY_WidthScale(20));
        }];
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = Colors(@"#E5E5E5");
        [view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(16));
            make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(16));
            make.top.equalTo(lable.mas_bottom).mas_offset(ZY_HeightScale(15));
            make.height.equalTo(@(ZY_HeightScale(0.5)));
        }];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return ZY_HeightScale(134);
    }else{
        return 0.1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        
        UIView * grayView = [UIView new];
        grayView.backgroundColor = Colors(@"#F8F8F8");
        [view addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.equalTo(@(10));
        }];
        
        UILabel * xiaDanlable = [UILabel new];
        xiaDanlable.text = @"下单时间:";
        xiaDanlable.font = Fonts(15);
        xiaDanlable.textColor = Colors(@"#666666");
        [view addSubview:xiaDanlable];
        [xiaDanlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(21));
            make.top.equalTo(grayView.mas_bottom).mas_offset(ZY_HeightScale(18));
        }];
        
        self.placeOrderLable = [UILabel new];
        self.placeOrderLable.text = [GH_Tools transToTimeStemp:self.model.createTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        self.placeOrderLable.textColor = Colors(@"#4C4C4C");
        self.placeOrderLable.font = Fonts(15);
        [view addSubview:self.placeOrderLable];
        [self.placeOrderLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(xiaDanlable);
            make.right.equalTo(view.mas_right).mas_offset(-ZY_WidthScale(15));
        }];
        
        UILabel * wanchenglable = [UILabel new];
        wanchenglable.text = @"完成时间:";
        wanchenglable.font = Fonts(15);
        wanchenglable.textColor = Colors(@"#666666");
        [view addSubview:wanchenglable];
        [wanchenglable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(21));
            make.top.equalTo(xiaDanlable.mas_bottom).mas_offset(ZY_HeightScale(13));
        }];
        
        self.completedLable = [UILabel new];
        self.completedLable.text = [GH_Tools transToTimeStemp:self.model.finishTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        self.completedLable.textColor = Colors(@"#4C4C4C");
        self.completedLable.font = Fonts(15);
        [view addSubview:self.completedLable];
        [self.completedLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wanchenglable);
            make.centerX.equalTo(self.placeOrderLable);
        }];
        
        
        UILabel * pingjialable = [UILabel new];
        pingjialable.text = @"评价时间:";
        pingjialable.font = Fonts(15);
        pingjialable.textColor = Colors(@"#666666");
        [view addSubview:pingjialable];
        [pingjialable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(21));
            make.top.equalTo(wanchenglable.mas_bottom).mas_offset(ZY_HeightScale(13));
        }];
        
        self.appriaceCompletedLable = [UILabel new];
        self.appriaceCompletedLable.text = [GH_Tools transToTimeStemp:self.model.evaluateTime dateFormatter:@"yyyy-MM-dd HH:mm"];
        self.appriaceCompletedLable.textColor = Colors(@"#4C4C4C");
        self.appriaceCompletedLable.font = Fonts(15);
        [view addSubview:self.appriaceCompletedLable];
        [self.appriaceCompletedLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(pingjialable);
            make.centerX.equalTo(self.placeOrderLable);
        }];
        UIView * lineVIew = [UIView new];
        //使用贝塞尔曲线画输入框的虚线
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake((screenWidth - ZY_WidthScale(32)), 0)];
        CAShapeLayer * layers = [CAShapeLayer layer];
        [layers setFillColor:[UIColor clearColor].CGColor];
        [layers setStrokeColor:Colors(@"#E5E5E5").CGColor];
        layers.path = path.CGPath;
        layers.lineWidth = 0.5;
        layers.lineDashPattern = @[@(3.0),@(3.0)];
        [lineVIew.layer addSublayer:layers];
        [view addSubview:lineVIew];
        [lineVIew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).mas_offset(ZY_WidthScale(16));
            make.width.equalTo(@(screenWidth - ZY_WidthScale(32)));
            make.top.equalTo(self.appriaceCompletedLable.mas_bottom).mas_offset(ZY_HeightScale(20));
            make.height.equalTo(@(0.5));
        }];
        
        return view;
    }
    return nil;
}

@end
