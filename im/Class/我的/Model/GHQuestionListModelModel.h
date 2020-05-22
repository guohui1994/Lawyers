//
//  GHQuestionListModelModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/20.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHQuestionListModelModel : NSObject

@property (nonatomic, copy) NSString *answer;//问题内容

@property (nonatomic, assign) NSInteger questionID;//问题ID

@property (nonatomic, assign) NSInteger updateTime;//更新时间

@property (nonatomic, copy) NSString *question;//问题

@property (nonatomic, copy) NSString *adminName;

@property (nonatomic, assign) NSInteger adminId;

@property (nonatomic, assign) NSInteger createTime;//创建时间

@end


NS_ASSUME_NONNULL_END
