//
//  HHDatabaseEngine+News.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-10.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHDatabaseEngine.h"
@class ArticleModel;

@interface HHDatabaseEngine (News)

-(void)insertNewsClassIntoDBWithClassArray:(NSMutableArray *)array;

-(void)insertNewsIntoDBWithNewsArray:(NSMutableArray *)array newsClassID:(NSString *)classID;

-(NSMutableArray *)getNewsClassListFromDB;

-(NSMutableArray *)getNewsListFromDBWithClassID:(NSString *)classID;
-(NSMutableArray *)getBannerListWithClassID:(NSString *)classID;
-(void)insertBanners:(NSMutableArray *)banersArray classID:(NSString *)classID;
-(ArticleModel *)getNewsDetailFromDBWithNewsID:(NSString *)newsID;
-(void)updateNewsReadState:(NSInteger)state withNewsID:(NSString *)newID;

    //添加收藏
-(BOOL)addCollectWithNewsModel:(ArticleModel *)model withUserID:(NSString *)userID;
-(NSMutableArray *)getCollectArtictleListWithUserID:(NSString *)userID pageIndex:(NSInteger)pid pageSize:(NSInteger)size;
-(BOOL)deleteOneCollectArtictle:(NSString *)artictleID withUserID:(NSString *)userID;



-(BOOL)clearAllData;
@end
