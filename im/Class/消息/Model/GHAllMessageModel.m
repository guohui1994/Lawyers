//
//  GHAllMessageModel.m
//  WangLawyer
//
//  Created by indulgeIn on 2019/10/08.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "GHAllMessageModel.h"


@implementation GHAllMessageListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"messageID" : @"id"};
}

@end


@implementation GHAllMessageModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"GHAllMessageListModel"};
}
@end


