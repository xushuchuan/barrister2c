//
//  HomePageProxy.m
//  barrister
//
//  Created by 徐书传 on 16/3/22.
//  Copyright © 2016年 Xu. All rights reserved.
//

#import "HomePageProxy.h"

#define HomePageDataUrl @"appHome.do"
#define GetSwitchUrl @"getLatestVersion.do"
#define GetOnlineSerListUrl @"onlineBizUserList.do"
#define WebAuthUrl @"webAuth.do"


@implementation HomePageProxy

/**
 *  获取首页全部数据接口
 *
 *  @param params 请求参数
 *  @param aBlock 返回处理Block
 */

-(void)getHomePageDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:HomePageDataUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }
    } fail:^(NSError *error) {
        aBlock(CommonNetErrorTip,NO);
    }];
}




/**
 *  获取开关数据
 *
 *  @param params
 *  @param aBlock
 */

-(void)getHidePayDataWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:GetSwitchUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }
    } fail:^(NSError *error) {
        aBlock(CommonNetErrorTip,NO);
    }];

}


/**
 *  线上专项服务接口
 *
 *  @param params
 *  @param aBlock
 */
-(void)getOnlineServiceListWithParams:(NSDictionary *)params Block:(ServiceCallBlock)aBlock
{
    [XuNetWorking getWithUrl:GetOnlineSerListUrl params:params success:^(id response) {
        if ([self isCommonCorrectResultCodeWithResponse:response]) {
            aBlock(response,YES);
        }
        else
        {
            aBlock(CommonNetErrorTip,NO);
        }
    } fail:^(NSError *error) {
        aBlock(CommonNetErrorTip,NO);
    }];
    
}

/**
 *  web授权接口
 *
 *  @param params
 *  @param aBlock
 */
-(void)webAuthWithParams:(NSMutableDictionary *)params block:(ServiceCallBlock)aBlock
{
    [self appendCommonParamsWithDict:params];
    [XuNetWorking postWithUrl:WebAuthUrl params:params success:^(id response) {
        if (aBlock) {
            aBlock(response,YES);
        }
    } fail:^(NSError *error) {
        if (aBlock) {
            aBlock(error,YES);
        }
    }];
    
}




@end
