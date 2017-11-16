//
//  NetworkHelper.m
//  初步学习GCD
//
//  Created by 冯硕 on 2017/6/28.
//  Copyright © 2017年 冯硕. All rights reserved.
//

#import "NetworkHelper.h"


static NetworkHelper * helper;
@implementation NetworkHelper

+ (id)mianHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[NetworkHelper alloc] init];
    });
    return helper;
}


@end
