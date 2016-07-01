//
//  LawerListProxy.m
//  barrister2c
//
//  Created by 徐书传 on 16/6/26.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "LawerListProxy.h"

#define LawerListUrl @"barristerList"

@implementation LawerListProxy

-(void)getLawerListWithParams:(NSDictionary *)params block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:LawerListUrl params:params success:^(id response) {
        if (aBlock) {
            aBlock(response,YES);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,NO);
        }
    }];

}

@end