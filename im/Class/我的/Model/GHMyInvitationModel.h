//
//  GHMyInvitationModel.h
//  im
//
//  Created by indulgeIn on 2020/05/20.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface GHMyInvitationListModel : NSObject

@property (nonatomic, copy) NSString *userStatus;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger createTime;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *head;

@end


@interface GHMyInvitationModel : NSObject

@property (nonatomic, assign) NSInteger login;

@property (nonatomic, copy) NSArray<GHMyInvitationListModel *> *list;

@property (nonatomic, assign) NSInteger registerUser;

@end


NS_ASSUME_NONNULL_END
