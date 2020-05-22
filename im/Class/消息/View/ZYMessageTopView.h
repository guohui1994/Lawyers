//
//  ZYMessageTopView.h
//  Lawyers_Use
//
//  Created by 郭军 on 2019/9/19.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHLastMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnBackInfo)(void);

@interface ZYMessageTopView : UIView

@property (nonatomic, copy) ReturnBackInfo backInfo;

@property (nonatomic, strong) GHLastMessageModel *SysMsgModel;


@end

NS_ASSUME_NONNULL_END
