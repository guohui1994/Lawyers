//
//  GH_LeaveMessageServiceChooseTableViewCell.m
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/11.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import "GH_LeaveMessageServiceChooseTableViewCell.h"


@interface GH_LeaveMessageServiceChooseTableViewCell ()
@property (nonatomic, strong)NSMutableArray * temp;
@end

@implementation GH_LeaveMessageServiceChooseTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self creatUI];
    }
    return self;
}


- (void)setSelectLabelArray:(NSArray *)selectLabelArray{
    _selectLabelArray = selectLabelArray;
    self.temp = [NSMutableArray new];
//    NSArray * titleArray = @[@"财产继承", @"婚姻家庭", @"债权债务", @"劳动纠纷", @"公司法律", @"合同事务",@"财产继承", @"债权债务", @"其他"];
    for (int i = 0; i < selectLabelArray.count; i++) {
        GHLeaveMessageSelectLableModel * model = selectLabelArray[i];
        UIButton * serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        serviceButton.tag = 9000 + i;
        [serviceButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        [serviceButton setTitle:model.name forState:UIControlStateNormal];
        [serviceButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
        serviceButton.titleLabel.font = Fonts(16);
        serviceButton.backgroundColor = Colors(@"#FFFDF6");
        serviceButton.sd_cornerRadius = @(ZY_WidthScale(20));
        serviceButton.clipsToBounds = YES;
        [self.contentView addSubview:serviceButton];
        serviceButton.sd_layout
        .heightIs(ZY_HeightScale(40));
        [self.temp addObject:serviceButton];
    }
    [self.contentView setupAutoWidthFlowItems:self.temp withPerRowItemsCount:3 verticalMargin:15 horizontalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    [self setupAutoHeightWithBottomViewsArray:self.temp bottomMargin:10];
}

- (void)creatUI{
    self.temp = [NSMutableArray new];
    NSArray * titleArray = @[@"财产继承", @"婚姻家庭", @"债权债务", @"劳动纠纷", @"公司法律", @"合同事务",@"财产继承", @"债权债务", @"其他"];
    for (int i = 0; i < 9; i++) {
        UIButton * serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        serviceButton.tag = 9000 + i;
        [serviceButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        [serviceButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [serviceButton setTitleColor:Colors(@"#FFA425") forState:UIControlStateNormal];
        serviceButton.titleLabel.font = Fonts(16);
        serviceButton.backgroundColor = Colors(@"#FFFDF6");
        serviceButton.sd_cornerRadius = @(ZY_WidthScale(20));
        serviceButton.clipsToBounds = YES;
        [self.contentView addSubview:serviceButton];
        serviceButton.sd_layout
        .heightIs(ZY_HeightScale(40));
        [self.temp addObject:serviceButton];
    }
    [self.contentView setupAutoWidthFlowItems:self.temp withPerRowItemsCount:3 verticalMargin:15 horizontalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    [self setupAutoHeightWithBottomViewsArray:self.temp bottomMargin:10];
}

- (void)click:(UIButton *)sender{
    
    for (UIButton * bt in self.temp) {
        if (bt == sender) {
            sender.layer.borderColor = Colors(@"#FFA425").CGColor;
            sender.layer.borderWidth = 1;
        }else{
            bt.layer.borderColor = Colors(@"#FFFDF6").CGColor;
            bt.layer.borderWidth = 1;
        }
    }
    GHLeaveMessageSelectLableModel * model = self.selectLabelArray[sender.tag - 9000];
    if (self.block) {
        self.block(model.lableID);
    }
    
   
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
