//
//  NewsDetailViewController.h
//  HHNewsEast
//
//  Created by Luigi on 14-7-31.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "BaseViewController.h"
typedef  NS_ENUM(NSInteger, NewsDetailControlelrType) {
    NewsDetailControlelrTypeForBanner      =10 ,//广告
    NewsDetailControlelrTypeForNews         ,//新闻
};

@interface NewsDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *artictleID;

//@property(nonatomic,strong)ArticleModel *artictleModel;
@property(nonatomic,copy)NSString *bannerUrl;

@property(nonatomic,assign)NewsDetailControlelrType newsDetailType;
@end
