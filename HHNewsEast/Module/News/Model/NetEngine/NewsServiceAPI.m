//
//  NewsServiceAPI.m
//  HomeTown
//
//  Created by d gl on 14-6-4.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "NewsServiceAPI.h"

#define NewsSuffName            @"/App/AppServlet/"
#define GetNewsClassURL         @"getCategories"
#define GetNewsListURL          @"getNewsListAndBanner"
#define GetNewsInfoByIDURL      @"getNewsInfo"

#define GetNewsCommentList      @"getNewsReview"//获取新闻的列表
#define PublishNewsComment      @"saveReview"//发表新闻评论
#define FavorComment            @"savePoint"//点赞
#define OffLineDownloadNews     @"offLineDownload"//下载新闻

@implementation NewsServiceAPI
+(NSString *)getNewsClassListURL
{
    NSString *apiStr=[NewsSuffName stringByAppendingString:GetNewsClassURL];
    return apiStr;
}
+(NSString *)getNewsListURL
{
    NSString *apiStr=[NewsSuffName stringByAppendingString:GetNewsListURL];
    return apiStr;
}
+(NSString *)getNewsDetailURL
{
    NSString *apiStr=[NewsSuffName stringByAppendingString:GetNewsInfoByIDURL];
    return apiStr;
}
/**
 *  获取评论列表
 *
 *  @return
 */
+(NSString *)getNewsCommentListURL{
    NSString *apiStr=[NewsSuffName stringByAppendingString:GetNewsCommentList];
    return apiStr;
}

/**
 *  发表评论
 *
 *  @return NSString
 */
+(NSString *)publishCommentURL{
    NSString *apiStr=[NewsSuffName stringByAppendingString:PublishNewsComment];
    return apiStr;
}

/**
 *  对新闻点赞
 *
 *  @return NSString
 */
+(NSString *)favourCommentURL{
    NSString *apiStr=[NewsSuffName stringByAppendingString:FavorComment];
    return apiStr;
}

/**
 *  离线下载新闻
 *
 *  @return NSString
 */
+(NSString *)offLineDownloadURL{
    NSString *apiStr=[NewsSuffName stringByAppendingString:OffLineDownloadNews];
    return apiStr;
}
+(NSString *)searhNewsURL{
    NSString *apiStr=[NewsSuffName stringByAppendingString:@"getNewsListByKey"];
    return apiStr;
}
@end
