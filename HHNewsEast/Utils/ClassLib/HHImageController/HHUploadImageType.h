//
//  HHUploadImageType.h
//  MoblieCity
//
//  Created by Luigi on 14-7-17.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#ifndef MoblieCity_HHUploadImageType_h
#define MoblieCity_HHUploadImageType_h

typedef NS_ENUM(NSInteger, HHUploadImageMark){//上传图片的模块
    HHUploadImageUserHeaderImage              =0,//用户头像
    HHUploadImageUserPhoto          =1,//会员
    HHUploadImageOldGoods           =2,//二手物品
    HHUploadImageOldCar             =3,//二手车
    HHUploadImageVillage            =4,//乡村
    HHUploadImageScenery            =5,//旅游景点
    HHUploadImageNews               =6,//新闻管理
    HHUploadImageBusiness           =7,//行业
    HHUploadImageMerchantClass      =8,//商家类别
    HHUploadImageMerchantInfo       =9,//商家信息
    HHUploadImageSales              =10,//特卖
    HHUploadImageSystem             =11,//系统设置
};

#endif
