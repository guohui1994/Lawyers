//
//  GHLeaveMessageResultModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/23.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHLeaveMessageResultModel : NSObject

@property (nonatomic, copy) NSString *account;//律师账号

@property (nonatomic, copy) NSString *name;//律师名称

@property (nonatomic, assign) NSInteger leaveMessageID;//留言ID

@property (nonatomic, copy) NSString *labelName;//标签名称

@property (nonatomic, copy) NSString *seekNum;//留言编号

@property (nonatomic, assign) NSInteger handleTime;//分配时间

@property (nonatomic, copy) NSString *seek;//留言

@property (nonatomic, assign) NSInteger state;//状态 0是未分配1是已分配

@property (nonatomic, assign) NSInteger createTime;//创建留言时间

@end


NS_ASSUME_NONNULL_END
