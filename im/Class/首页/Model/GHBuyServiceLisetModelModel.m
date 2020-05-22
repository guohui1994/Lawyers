//
//  GHBuyServiceLisetModelModel.m
//  WangLawyer
//
//  Created by indulgeIn on 2019/09/24.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "GHBuyServiceLisetModelModel.h"


@implementation GHBuyServiceLisetListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"serviceID": @"id"};
}
@end


@implementation GHBuyServiceLisetModelModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"GHBuyServiceLisetListModel"};
}
@end


