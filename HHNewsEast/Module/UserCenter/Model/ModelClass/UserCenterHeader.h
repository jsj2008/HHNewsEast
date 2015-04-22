//
//  UserCenterHeader.h
//  MoblieCity
//
//  Created by Luigi on 14-7-17.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#ifndef MoblieCity_UserCenterHeader_h
#define MoblieCity_UserCenterHeader_h

typedef NS_ENUM(NSInteger, UserCenterItemType) {
    UserCenterItemUserInfomation,//我的资料
    UserCenterItemEditPwd       ,//修改密码
    UserCenterItemSettin        ,//设置
    UserCenterItemAboutUs       ,//关于我们
    UserCenterItemShare         ,//分享给好友
    UserCenterItemFeedBack      ,//意见反馈
    
    UserCenterItemCollect       ,//我的收藏
    UserCenterItemMessage       ,//我的消息
    UserCenterItemPublish       ,//我的发布
    
    UserCenterItemSales         ,//我的特卖
    UserCenterItemShops         ,//我的店铺
    UserCenterItemRecruitment     ,//我的招聘
    UserCenterItemVillageStyls   ,//乡村风采
    
};

typedef NS_ENUM(NSInteger, UserLevelType) {
    UserLevelTypeUnLogin    ,//未登录
    UserLevelTypeCommon     ,//普通会员
    UserLevelTypeCompany    ,//企业会员
    UserLevelTypeVillage    ,//乡村会员
};

#endif
