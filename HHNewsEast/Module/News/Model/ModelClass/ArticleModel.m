//
//  ArticleModel.m
//  SeaArticle
//
//  Created by x f on 14-3-24.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "ArticleModel.h"
#import "NSString+H_Html.h"
@implementation ArticleModel
-(NSString  *)htmlString{
   NSString * title=[NSString stringByReplaceNullString:self.articleTitle];
   NSString *  time=[NSString stringByReplaceNullString:self.articlePublishTime];
    NSString * author=[NSString stringByReplaceNullString:self.articleAuthor];
    NSString * visitCount=[NSString stringByReplaceNullString:self.articleVisitNum];
   NSString *  content=[NSString stringByReplaceNullString:self.articleContent];
    NSString *posterUrl=[HHGlobalVarTool fullNewsImagePath:self.articleImage];
    NSString *templeteHtml=[NSString htmlStringWithTitle:title time:time author:author visitCount:visitCount videoUrl:self.articleVideoUrl posterUrl:posterUrl  content:content];
    return templeteHtml;
}

@end


@implementation ArticleClassModel

-(id)init{
    self=[super init];
    if (self) {
       _articleClassID=_articleClassName=@"";
        _artictleListArry=[[NSMutableArray alloc]  init];
        _artictleBannerArray=[[NSMutableArray alloc]  init];
    }
    return self;
}
@end

@implementation BannerModel



@end