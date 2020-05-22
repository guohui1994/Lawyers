//
//  GH_SetSexView.h
//  WangLawyer
//
//  Created by ZhiYuan on 2019/9/12.
//  Copyright © 2019 郭徽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectSex)(NSInteger index);

@interface GH_SetSexView : UIView

@property (nonatomic, strong)NSString * sexString;


@property (nonatomic, strong)selectSex block;
@end

NS_ASSUME_NONNULL_END
