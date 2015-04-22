//
//  HHNetWorkEngine+News.m
//  HHNewsEast
//
//  Created by Luigi on 14-7-31.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+News.h"
#import "ArticleModel.h"
#import "NewsServiceAPI.h"
#import "CommentModel.h"
#import "HHDatabaseEngine+News.h"
#import "HHFlowModel.h"
@implementation HHNetWorkEngine (News)
-(MKNetworkOperation *)getNewClassListOnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                           onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[NewsServiceAPI getNewsClassListURL];
    NSMutableDictionary*postDic=nil;
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:urlPath parmarDic:postDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=[self parseArticleClassToResposeResult:responseResult];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
        
    }];
    return op;
}
-(HHResponseResult *)parseArticleClassToResposeResult:(HHResponseResult *)responseResult{
    //  responseResult.responseMessage=[[responseResult.responseData objectForKey:@"message"] URLDecodedString];
    NSMutableArray *categoryMutableArray=[[NSMutableArray alloc] init];
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        NSArray *responseMutableArry=responseResult.responseData;
        for (NSDictionary *dic in responseMutableArry) {
            ArticleClassModel *articelClassModel=[[ArticleClassModel alloc]  init];
            articelClassModel.articleClassID=[dic objectForKey:@"topicID"];
            articelClassModel.articleClassName = [[dic objectForKey:@"topicName"]URLDecodedString];
            if (categoryMutableArray.count==0) {//类别存到本地
                [HHGlobalVarTool setNewsClassID:articelClassModel.articleClassID];
            }
            [categoryMutableArray addObject:articelClassModel];
        }
        responseResult.responseData=categoryMutableArray;
        [[HHDatabaseEngine sharedDBEngine] insertNewsClassIntoDBWithClassArray:categoryMutableArray];
    }else{
        responseResult.responseData=[[HHDatabaseEngine sharedDBEngine] getNewsClassListFromDB];
    }
    return responseResult;
}
-(MKNetworkOperation *)getNewsListWithClassID:(NSString *)classID
                                    pageIndex:(NSInteger)pageIndex
                                     pageSize:(NSInteger)pageSize
                          OnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                               onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString*urlPath=[NewsServiceAPI getNewsListURL];
    NSMutableDictionary*postDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:classID,@"categoriesId",
                                 [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                 [NSString stringWithFormat:@"%d",HHPageSize],@"pageRecord",
                                 [HHGlobalVarTool sortOrder],@"sortType", nil];
    MKNetworkOperation*op=[[HHNetWorkEngine sharedHHNetWorkEngine]requestWithUrlPath:urlPath parmarDic:postDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult*listResult=[self parseArticleListToResposeResult:responseResult classID:classID];
        completionResult(listResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
-(HHResponseResult *)parseArticleListToResposeResult:(HHResponseResult *)responseResult classID:(NSString *)classID{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        NSArray *banerArray=[responseResult.responseData objectForKey:@"banner"];
        
        NSMutableArray * banerNewsArray=[[NSMutableArray alloc]  init];
        if (banerArray.count) {
            for (NSDictionary *dic in banerArray) {
                HHFlowModel *bannerModel=[[HHFlowModel alloc]  init];
                bannerModel.flowSourceUrl=[[dic objectForKey:@"newUrl"] URLDecodedString];
                NSString *photoPath=[[dic objectForKey:@"photoUrl"] URLDecodedString];
                photoPath=[HHGlobalVarTool fullNewsImagePath:photoPath];
                bannerModel.flowImageUrl=photoPath;
                
                [banerNewsArray addObject:bannerModel];
            }
        }
        id itemReslut = [responseResult.responseData objectForKey:@"newslist"];
        NSMutableArray *responseMutableArry=[[NSMutableArray alloc] init];
        for (NSDictionary *dic  in itemReslut){
            ArticleModel  *article_Model=[[ArticleModel alloc] init];
            article_Model.articleID=[[dic objectForKey:@"topicDetailID"] URLDecodedString];
            article_Model.artictleClassID=classID;
            article_Model.articleTitle = [[dic objectForKey:@"topicTitle"]URLDecodedString];
            article_Model.articleImage = [NSString stringByReplaceNullString:[[dic objectForKey:@"topicURI"]URLDecodedString]];
            article_Model.articleVisitNum = [NSString stringByReplaceToZeroStringWithNullString:[[dic objectForKey:@"browse"] URLDecodedString]];
            article_Model.articleBrief = [[dic objectForKey:@"topicSubTitle"] URLDecodedString];
            article_Model.articleVideoUrl = [[dic objectForKey:@"topicVideo"] URLDecodedString];
            [responseMutableArry addObject:article_Model];
        }
       // dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[HHDatabaseEngine sharedDBEngine]  insertNewsIntoDBWithNewsArray:responseMutableArry newsClassID:classID];
            [[HHDatabaseEngine sharedDBEngine]  insertBanners:banerNewsArray classID:classID];
        //});
        banerNewsArray=[[HHDatabaseEngine sharedDBEngine]  getBannerListWithClassID:classID];
        responseMutableArry=[[HHDatabaseEngine sharedDBEngine]  getNewsListFromDBWithClassID:classID];
        NSDictionary *resultDic=[NSDictionary dictionaryWithObjectsAndKeys:responseMutableArry,@"newslist",banerNewsArray,@"banner", nil];
        responseResult.responseData=resultDic;
    }else{
        responseResult.responseData=[[HHDatabaseEngine sharedDBEngine]getNewsListFromDBWithClassID:classID];
        
    }
    return responseResult;
}
#pragma mark - 获取文章详情
-(MKNetworkOperation *)getArticleDetail:(NSString *)articleID
                    onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                         onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[NewsServiceAPI getNewsDetailURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    articleID,@"newsId", nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult*listResult=[self parseArticleInfoToResposeResult:responseResult];
        completionResult(listResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    return op;
}
-(HHResponseResult *)parseArticleInfoToResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        NSDictionary* dic = responseResult.responseData;
        ArticleModel  *article_Model=[[ArticleModel alloc] init];
        article_Model.articleID=[dic objectForKey:@"topicDetailID"];
        //article_Model.articleAuthor=[[dic objectForKey:@"empID"] URLDecodedString];
        article_Model.articleBrief=[[dic objectForKey:@"topicSubTitle"] URLDecodedString];
        article_Model.articleTitle = [[dic objectForKey:@"topicTitle"] URLDecodedString];
        article_Model.articlePublishTime = [[dic objectForKey:@"createDate"] URLDecodedString];
        article_Model.articleContent = [[dic objectForKey:@"topicContent"] URLDecodedString];
        article_Model.articleVideoUrl = [dic objectForKey:@"topicVideo"];
        article_Model.articleVisitNum  =[dic objectForKey:@"browse"];
        article_Model.articleImage=[[dic objectForKey:@"topicURI"] URLDecodedString];
        responseResult.responseData=article_Model;
    }
    return responseResult;
}
#pragma mark - 分页获取评论列表
-(MKNetworkOperation *)getCommentListwithpageIndex:(NSInteger )pageIndex
                                         articleid:(NSString *)articleid
                               onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                    onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[NewsServiceAPI getNewsCommentListURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",[NSString stringWithFormat:@"%d",HHPageSize],@"pageRecord",articleid,@"newsId",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=[self parseGetCommentListToResposeResult:responseResult];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
-(HHResponseResult *)parseGetCommentListToResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        
        id itemReslut = responseResult.responseData;
        // responseResult.responseMessage=[responseResult.responseData objectForKey:@"message"];
        NSMutableArray *responseMutableArry=[[NSMutableArray alloc] init];
        for (NSDictionary *dic  in itemReslut){
            CommentModel  *model=[[CommentModel alloc] init];
            model.commentId=[dic objectForKey:@"revID"];
            model.commentUserID=[dic objectForKey:@"empID"];
            model.commentUserName=[[dic objectForKey:@"empName"] URLDecodedString];
            model.commentUserImageUrl=[dic objectForKey:@"photoURI"];
            model.commentContent=[[dic objectForKey:@"revDesc"] URLDecodedString];
            model.commentFavorNum=[dic objectForKey:@"zan"];
            [responseMutableArry addObject:model];
        }
        responseResult.responseData=responseMutableArry;
    }
    return responseResult;
}
/**
 *  发表新闻的评论
 *
 *  @param userID           用户id（可以传空）
 *  @param newsID           新闻id
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)publishCommentWithUserID:(NSString *)userID
                                         newsID:(NSString *)newsID
                                 commentContent:(NSString *)content
                            onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                 onErrorHandler:(MKNKErrorBlock)errorBlock{
    userID=[NSString stringByReplaceNullString:userID];
    NSString *urlPath=[NewsServiceAPI publishCommentURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    userID,@"userId",
                                    newsID,@"newsId",
                                    [content URLEncodedString],@"data",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=[self parsePublishJosnComemntWithResposeResult:responseResult];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
-(HHResponseResult *)parsePublishJosnComemntWithResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        NSDictionary *dic=responseResult.responseData;
        CommentModel *commentModel=[[CommentModel alloc]  init];
        commentModel.commentId=[dic objectForKey:@"RevID"];
        commentModel.commentArtictleID=[dic objectForKey:@"TopicDetailID"];
        commentModel.commentUserID=[dic objectForKey:@"EmpID"];
        commentModel.commentUserName=[[dic objectForKey:@"EmpName"] URLDecodedString];
        commentModel.commentContent=[[dic objectForKey:@"ModDate"] URLDecodedString];
        commentModel.commentFavorNum=[dic objectForKey:@"zan"];
        commentModel.commentIsShow=[dic objectForKey:@"IsShow"];
        responseResult.responseData=commentModel;
    }
    return responseResult;
}
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
                                  onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[NewsServiceAPI favourCommentURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    commentID,@"revId",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=[self parseFavorComemntJosnWithResposeResult:responseResult];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
-(HHResponseResult *)parseFavorComemntJosnWithResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        
    }
    return responseResult;
}
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
                                           onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[NewsServiceAPI offLineDownloadURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    classID,@"categoriesId",
                                    [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                    [NSString stringWithFormat:@"%ld",(long)pageSize],@"pageRecord",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=[self parseOffLineDownLoadJosnWithResposeResult:responseResult];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
-(HHResponseResult *)parseOffLineDownLoadJosnWithResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        NSArray *reslultArray=responseResult.responseData;
        NSMutableArray *dataArrary=[[NSMutableArray alloc]  init];
        for (NSDictionary *dic in reslultArray) {
            ArticleModel  *article_Model=[[ArticleModel alloc] init];
            article_Model.articleID=[dic objectForKey:@"topicDetailID"];
            article_Model.articleTitle=[[dic objectForKey:@"topicTitle"] URLDecodedString];
            
            article_Model.articleContent = [[dic objectForKey:@"topicContent"] URLDecodedString];
            article_Model.articleVideoUrl = [dic objectForKey:@"topicVideo"];
            article_Model.articleVisitNum  =[dic objectForKey:@"browse"];
            article_Model.articleBrief=[[dic objectForKey:@"topicSubTitle"] URLDecodedString];//副标题
            article_Model.articleImage=[dic objectForKey:@"topicURI"];
            [dataArrary addObject:article_Model];
        }
        responseResult.responseData=dataArrary;
    }
    return responseResult;
}
-(MKNetworkOperation *)searchNewsWithKeys:(NSString *)keys
                                pageIndex:(NSInteger)pageIndex
                                 pageSize:(NSInteger)pageSize
                      onCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                           onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[NewsServiceAPI searhNewsURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [NSString stringByReplaceNullString:keys],@"TexdKey",
                                    [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                    [NSString stringWithFormat:@"%ld",(long)pageSize],@"pageRecord",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine]  requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=[self parseSearchJosnWithResposeResult:responseResult];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
-(HHResponseResult *)parseSearchJosnWithResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        NSArray *reslultArray=responseResult.responseData;
        NSMutableArray *dataArrary=[[NSMutableArray alloc]  init];
        for (NSDictionary *dic in reslultArray) {
            ArticleModel  *article_Model=[[ArticleModel alloc] init];
            article_Model.articleID=[dic objectForKey:@"topicDetailID"];
            article_Model.articleTitle=[[dic objectForKey:@"topicTitle"] URLDecodedString];
            
            article_Model.articleContent = [[dic objectForKey:@"topicContent"] URLDecodedString];
            article_Model.articleVideoUrl = [dic objectForKey:@"topicVideo"];
            article_Model.articleVisitNum  =[dic objectForKey:@"browse"];
            article_Model.articleBrief=[[dic objectForKey:@"topicSubTitle"] URLDecodedString];//副标题
            article_Model.articleImage=[dic objectForKey:@"topicURI"];
            [dataArrary addObject:article_Model];
        }
        responseResult.responseData=dataArrary;
    }
    return responseResult;
}

@end
