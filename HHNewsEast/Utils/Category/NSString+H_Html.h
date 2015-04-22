//
//  NSString+H_Html.h
//  MoblieCity
//
//  Created by Luigi on 14-7-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VillageItemModel;
@interface NSString (H_Html)
/**
 *  生成详情
 *
 *  @param title      标题
 *  @param time       时间
 *  @param author     作者
 *  @param visitCount 浏览量
 *  @param content    内从
 *
 *  @return HtmlString
 */
+(NSString *)htmlStringWithTitle:(NSString *)title
                            time:(NSString *)time
                          author:(NSString *)author
                      visitCount:(NSString *)visitCount
                         content:(NSString *)content;

+(NSString *)htmlStringWithTitle:(NSString *)title
                            time:(NSString *)time
                          author:(NSString *)author
                      visitCount:(NSString *)visitCount
                        videoUrl:(NSString *)videoUrl
                          posterUrl:(NSString *)posterUrl
                         content:(NSString *)content;

/**
 *  生成详情页面
 *
 *  @param title      标题
 *  @param time       时间
 *  @param author     作者
 *  @param visitCount 浏览人数
 *  @param imgArray   图片<必须是完整的图片的路径>
 *  @param content    内容
 *
 *  @return 你是string
 */
+(NSString *)htmlStringWithTitle:(NSString *)title
                            time:(NSString *)time
                          author:(NSString *)author
                      visitCount:(NSString *)visitCount
                          images:(NSArray *)imgArray
                         content:(NSString *)content;


@end

@interface NSString (StringBounds)
/**
 *  计算字符串size
 *
 *  @param font        font
 *  @param maxTextSize maxTextSize
 *
 *  @return cgsize
 */
- (CGSize)boundingRectWithfont:(UIFont *)font maxTextSize:(CGSize)maxTextSize;
@end