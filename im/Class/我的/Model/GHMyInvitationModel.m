//
//  GHMyInvitationModel.m
//  im
//
//  Created by indulgeIn on 2020/05/20.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "GHMyInvitationModel.h"


@implementation GHMyInvitationListModel


@end


@implementation GHMyInvitationModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"GHMyInvitationListModel"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"registerUser": @"register"};
}

@end


