//
//  GH_ AgreeView.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/16.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^agreeClick)(void);
@interface GH__AgreeView : UIView
@property (nonatomic, strong)agreeClick  block;
@end

NS_ASSUME_NONNULL_END
