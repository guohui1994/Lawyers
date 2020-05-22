//
//  GHOrderListModel.m
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/25.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "GHOrderListModel.h"


@implementation GHOrderListListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"orderID" : @"id"};
}
@end


@implementation GHOrderListModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"GHOrderListListModel"};
}
@end


