//
//  GHAlreadyBuyServiceListModel.m
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/25.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "GHAlreadyBuyServiceListModel.h"


@implementation GHAlreadyBuyServiceListListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"alreadyBuyServiceID" : @"id"};
}
@end


@implementation GHAlreadyBuyServiceListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"GHAlreadyBuyServiceListListModel"};
}
@end


