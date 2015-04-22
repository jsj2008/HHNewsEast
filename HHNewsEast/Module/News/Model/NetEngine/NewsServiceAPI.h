//
//  NewsServiceAPI.h
//  HomeTown
//
//  Created by d gl on 14-6-4.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NewsServiceAPI : NSObject
/**
 *  新闻类别URL
 *
 *  @return NSString
 */
+(NSString *)getNewsClassListURL;
/**
 *  新闻列表URL
 *
 *  @return NSString
 */
+(NSString *)getNewsListURL;
/**
 *  新闻详情URL
 *
 *  @return NSString
 */
+(NSString *)getNewsDetailURL;

/**
 *  获取评论列表
 *
 *  @return 
 */
+(NSString *)getNewsCommentListURL;

/**
 *  发表评论
 *
 *  @return NSString
 */
+(NSString *)publishCommentURL;

/**
 *  对新闻点赞
 *
 *  @return NSString
 */
+(NSString *)favourCommentURL;

/**
 *  离线下载新闻
 *
 *  @return NSString
 */
+(NSString *)offLineDownloadURL;

+(NSString *)searhNewsURL;
@end
