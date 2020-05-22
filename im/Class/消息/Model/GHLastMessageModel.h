//
//  GHLastMessageModel.h
//  WangLawyer
//
//  Created by indulgeIn on 2019/10/08.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHLastMessageModel : NSObject

@property (nonatomic, assign) NSInteger messageID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger createTime;

@end


NS_ASSUME_NONNULL_END
