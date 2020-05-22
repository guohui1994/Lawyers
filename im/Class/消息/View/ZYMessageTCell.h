//
//  ZYMessageTCell.h
//  Lawyers_Use
//
//  Created by 郭军 on 2019/9/19.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYMessageTCell : UITableViewCell

@property(nonatomic, strong) UIImageView *Icon;
@property(nonatomic, strong) UILabel *NameLbl;
@property(nonatomic, strong) UILabel *DetailLbl;
@property(nonatomic, strong) UILabel *TimeLbl;
///角标（UIView）
@property(nonatomic, strong) UILabel *BadgeView;


@property (nonatomic, strong) NIMRecentSession *Sesson;

@end

NS_ASSUME_NONNULL_END
