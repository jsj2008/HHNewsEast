//
//  HHGlobalVarTool.h
//  MoblieCity
//
//  Created by Luigi on 14-8-21.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHGlobalVarTool : NSObject
+(NSString *)domianName;


/**
 *  数据库的路径
 *
 *  @return Nsstring
 */
+(NSString *)dataBasePath;

+(CGFloat)pageSize;

    //主题背景颜色
+(UIColor *)themeBgColor;

#pragma mark- cache
//（根据返回的图片的名字, 获取完整的图片路径）
+(NSString *)severCompletionPath:(NSString *)path;
    //私信图片地址
+(NSString  *)chatMessageImageDir;
    //私信语音地址
+(NSString  *)chatMessageVoiceDir;
+(NSString *)fullUserHeaderImagePath:(NSString *)imgPath;
+(NSString *)fullNewsImagePath:(NSString *)imgPath;
#pragma mark- token
+(NSString *)deviceToken;
+(void)setDeviceToken:(NSString *)deviceToken;

    //设置排序的方式
+(NSString *)sortOrder;
+(void)setSortOrder:(NSString *)order;
    //存数一个类别，方便下载离线新闻
+(NSString *)newsClassID;
+(void)setNewsClassID:(NSString *)classID;
#pragma mark- app
+(NSString *)appName;
+(NSString *)appVersion;
+(NSString *)appStoreDownloadUrl;
#pragma mark- share
+(NSString *)shareUrlWithType:(NSInteger)type objectID:(NSString *)objectID;
+(NSString *)shareDownloadUrl;//分享的下载连接
+(NSString *)shareUMKey;
+(NSString *)shareQQKey;
+(NSString *)shareQQID;
+(NSString *)shareWeiXinID;
+(NSString *)shareWeiXinSecret;
+(NSString *)shareSinaWeiBoRedirectURI;
+(NSString *)shareSinaKey;
+(NSString *)shareSinaSecret;
#pragma mark- weixin login
+(NSString *)weixinLoignStateStr;//微信登陆的时候secion
@end
