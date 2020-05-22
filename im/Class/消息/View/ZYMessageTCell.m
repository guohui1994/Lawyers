//
//  ZYMessageTCell.m
//  Lawyers_Use
//
//  Created by 郭军 on 2019/9/19.
//  Copyright © 2019 JG. All rights reserved.
//

#import "ZYMessageTCell.h"
#import "NIMKitInfo.h"
#import "NIMKit.h"
#import "NIMKitInfoFetchOption.h"
@interface ZYMessageTCell ()

@end


@implementation ZYMessageTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _Icon = [UIImageView new];
    _Icon.clipsToBounds = YES;
    _Icon.layer.cornerRadius = 15.0f;
    _Icon.backgroundColor = [UIColor redColor];
    //        _Icon.image = Image(@"Message_one");
    
    _NameLbl = [UILabel new];
    _NameLbl.textColor = Colors(@"333333");
    //        _NameLbl.text = @"系统消息";
    _NameLbl.font = Fonts(16);
    
    
    _DetailLbl = [UILabel new];
    _DetailLbl.textColor = Colors(@"#4C4C4C");
    //        _DetailLbl.text = @"是超级女神承诺书";
    _DetailLbl.font = Fonts(15);
    
    _TimeLbl = [UILabel new];
    _TimeLbl.textColor = Colors(@"#888888");
    //        _TimeLbl.text = @"2018/10/24";
    _TimeLbl.font = Fonts(13);
    
    
    //角标
    _BadgeView = [UILabel new];
    _BadgeView.textColor = [UIColor whiteColor];
    _BadgeView.font = Fonts(11);
    _BadgeView.clipsToBounds = YES;
    _BadgeView.layer.cornerRadius = 7.5f;
    _BadgeView.textAlignment = NSTextAlignmentCenter;
    _BadgeView.backgroundColor = [UIColor redColor];
    
    UIView *Line = [UIView new];
    Line.backgroundColor = Colors(@"#DEDDDD");
    
    [self addSubview:_Icon];
    [self addSubview:_NameLbl];
    [self addSubview:_DetailLbl];
    [self addSubview:_TimeLbl];
    [self addSubview:Line];
    [self addSubview:_BadgeView];
    

    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).mas_offset(15);
        make.width.height.equalTo(@(55));
    }];
    
  
    
    [_DetailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Icon.mas_centerY).mas_offset(5);
        make.left.equalTo(_NameLbl.mas_left);
        make.right.equalTo(self.mas_right).mas_offset(-40);
    }];
    
    [_TimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_NameLbl.mas_centerY);
        make.right.equalTo(self.mas_right).mas_offset(-15);
       
    }];
    [_NameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_Icon.mas_centerY).mas_offset(-5);
        make.left.equalTo(_Icon.mas_right).mas_offset(14);
         make.width.mas_lessThanOrEqualTo(ZY_WidthScale(160));
    }];
    [_BadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).mas_offset(-15);
        make.right.equalTo(_TimeLbl.mas_right);
        make.width.height.equalTo(@(15));
    }];
    
    
    [Line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self).with.insets(UIEdgeInsetsMake(0, 15, 0, 15));
        make.height.equalTo(@(1));
    }];
}

- (void)setSesson:(NIMRecentSession *)Sesson {
    _Sesson = Sesson;
    
    if (Sesson.unreadCount) {
        self.BadgeView.hidden = NO;
        self.BadgeView.text = @(Sesson.unreadCount).stringValue;
    }else{
        self.BadgeView.hidden = YES;
    }
    
//    NIMKitInfo *info = [[JGDataManger sharedInstance] GetInfoBySession:Sesson.session];
    NIMKitInfo * info = [self GetInfoBySession:Sesson.session];
    NSURL *url = info.avatarUrlString ? [NSURL URLWithString:info.avatarUrlString] : nil;
//    [_Icon sd_setImageWithURL:url placeholderImage:info.avatarImage];
//    [_Icon setImageWithURL:url placeholder:info.avatarImage];
    [_Icon sd_setImageWithURL:url placeholderImage:info.avatarImage];
//    [_Icon sd_setImageWithURL:[NSURL URLWithString:info.avatarUrlString]];
//    _NameLbl.text = info.showName;
}


//通过会话对象获取信息
- (NIMKitInfo *)GetInfoBySession:(NIMSession *)session {
    
    NIMKitInfo *info = nil;
    if (session.sessionType == NIMSessionTypeTeam)
    {
        info = [[NIMKit sharedKit] infoByTeam:session.sessionId option:nil];
    }
    else
    {
        NIMKitInfoFetchOption *option = [[NIMKitInfoFetchOption alloc] init];
        option.session = session;
        info = [[NIMKit sharedKit] infoByUser:session.sessionId option:option];
    }
    
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:info.infoId];
    
    
    return info;
}


//- (void)refresh:(NIMRecentSession*)recent{
//    self.nameLabel.nim_width = self.nameLabel.nim_width > NameLabelMaxWidth ? NameLabelMaxWidth : self.nameLabel.nim_width;
//    self.messageLabel.nim_width = self.messageLabel.nim_width > MessageLabelMaxWidth ? MessageLabelMaxWidth : self.messageLabel.nim_width;
//    if (recent.unreadCount) {
//        self.badgeView.hidden = NO;
//        self.badgeView.badgeValue = @(recent.unreadCount).stringValue;
//    }else{
//        self.badgeView.hidden = YES;
//    }
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
