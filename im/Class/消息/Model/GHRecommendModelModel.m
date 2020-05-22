//
//  GHRecommendModelModel.m
//  im
//
//  Created by indulgeIn on 2020/04/22.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "GHRecommendModelModel.h"


@implementation GHRecommendListServicesModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"serviceID":@"id"};
}
@end


@implementation GHRecommendListServicesOrderModel
@end


@implementation GHRecommendListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"lawyersID": @"id"};
}
@end


@implementation GHRecommendModelModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"GHRecommendListModel"};
}
@end


