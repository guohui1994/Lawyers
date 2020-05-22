//
//  GH_MyHeaderView.h
//  AudioChang
//
//  Created by ZhiYuan on 2019/9/2.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^messageAndSetClick)(NSInteger index);
@interface GH_MyHeaderView : UIView
@property (nonatomic, strong)messageAndSetClick block;

@end

NS_ASSUME_NONNULL_END
