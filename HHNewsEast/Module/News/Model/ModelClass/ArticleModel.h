//
//  ArticleModel.h
//  SeaArticle
//
//  Created by x f on 14-3-24.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
@property(nonatomic,copy)NSString *articleID;
@property(nonatomic,copy)NSString *artictleClassID;
@property(nonatomic,copy)NSString *articleAuthor;
@property(nonatomic,copy)NSString *articleTitle;
@property(nonatomic,copy)NSString *articleBrief;
@property(nonatomic,copy)NSString *articlePublishTime;
@property(nonatomic,copy)NSString *articleContent;                //内容详情
@property(nonatomic,copy)NSString *articleImage;
@property(nonatomic,copy)NSString *articleCommentCount;            //文章总数
@property(nonatomic,copy)NSString *articleVisitNum;              //浏览量
@property(nonatomic,copy)NSString *articleVideoUrl;              //视频地址
@property(nonatomic,assign)BOOL isRead;

-(NSString  *)htmlString;

@end


/**
 *  文章类别的Model
 */
@interface ArticleClassModel : NSObject
@property(nonatomic,copy)NSString *articleClassID;
@property(nonatomic,copy)NSString *articleClassName;
@property(nonatomic,strong)NSMutableArray *artictleListArry;//类别下边的文章Model 的数组
@property(nonatomic,copy)NSString *articleClassAtentionNum;
@property(nonatomic,strong)NSMutableArray *artictleBannerArray;//类别下边的广告
@end
//广告model
@interface BannerModel : NSObject
@property(nonatomic,copy)NSString *bannerUrl;
@property(nonatomic,copy)NSString *bannerImageUrl;
@property(nonatomic,copy)NSString *bannerID;
@end