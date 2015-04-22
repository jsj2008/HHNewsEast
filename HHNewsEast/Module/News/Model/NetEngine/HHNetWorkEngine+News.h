//
//  HHNetWorkEngine+News.h
//  HHNewsEast
//
//  Created by Luigi on 14-7-31.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//


@interface HHNetWorkEngine (News)
#pragma mark -获取新闻类别
/**
 *  获取新闻类别
 *
 *  @param pID          类别id
 *  @param operatorID   运营商id
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)getNewClassListOnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                           onErrorHandler:(MKNKErrorBlock)errorBlock;


#pragma mark -获取新闻列表
/**
 *  获取新闻列表
 *
 *  @param classID          类别id
 *  @param areaID           区域id
 *  @param pageSize         页显示条数
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)getNewsListWithClassID:(NSString *)classID
                                          pageIndex:(NSInteger)pageIndex
                                     pageSize:(NSInteger)pageSize
                          OnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                               onErrorHandler:(MKNKErrorBlock)errorBlock;
/**
 *  获取文章的详情
 *
 *  @param articleID        文章ID
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return     
 */
-(MKNetworkOperation *)getArticleDetail:(NSString *)articleID
                    onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                         onErrorHandler:(MKNKErrorBlock)errorBlock;
/*
*  分页获取评论列表
*
*  @param page_index
*  @param article_id      文章id
*
*  @return 文章Model
*/
-(MKNetworkOperation *)getCommentListwithpageIndex:(NSInteger )pageIndex
                                         articleid:(NSString *)articleid
                               onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                    onErrorHandler:(MKNKErrorBlock)errorBlock;
/**
 *  发表新闻的评论
 *
 *  @param userID           用户id（可以传空）
 *  @param newsID           新闻id
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return commentModel
 */
-(MKNetworkOperation *)publishCommentWithUserID:(NSString *)userID
                                         newsID:(NSString *)newsID
                                 commentContent:(NSString *)content
                               onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                    onErrorHandler:(MKNKErrorBlock)errorBlock;
/**
 *  对评论进行点赞
 *
 *  @param commentID        评论的ID
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)favorComemntWithCommentID:(NSString *)commentID
                            onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                 onErrorHandler:(MKNKErrorBlock)errorBlock;
/**
 *  下载新闻
 *
 *  @param classID          类别ID
 *  @param pageIndex        第几页
 *  @param pageSize         分页
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return 
 */
-(MKNetworkOperation *)offLineDownloadNewsWithNewsClassID:(NSString *)classID
                                                pageIndex:(NSInteger)pageIndex
                                                 pageSize:(NSInteger)pageSize
                                            onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                 onErrorHandler:(MKNKErrorBlock)errorBlock;

/**
 *  搜索新闻
 *
 *  @param keys
 *  @param pageIndex
 *  @param pageSize
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)searchNewsWithKeys:(NSString *)keys
                                                pageIndex:(NSInteger)pageIndex
                                                 pageSize:(NSInteger)pageSize
                                      onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                           onErrorHandler:(MKNKErrorBlock)errorBlock;

@end
