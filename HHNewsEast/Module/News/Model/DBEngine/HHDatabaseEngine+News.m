//
//  HHDatabaseEngine+News.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-10.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHDatabaseEngine+News.h"
#import "ArticleModel.h"
#import "HHFlowModel.h"
@implementation HHDatabaseEngine (News)
-(void)insertNewsClassIntoDBWithClassArray:(NSMutableArray *)array{
        if ([[HHDatabaseEngine sharedDBEngine] open]) {
            for (ArticleClassModel *classModel in array) {
                NSString *sqlStr=@"insert into NewsClassTable (NewsClassID,NewsClassName) values (?,?)";
               BOOL isSuccess= [[HHDatabaseEngine sharedDBEngine]  executeUpdate:sqlStr,classModel.articleClassID,classModel.articleClassName];
                if (isSuccess) {
                    DLog(@"INSER NewsClass Successed");
                }else{
                DLog(@"INSER NewsClass Failed");
                }
            }
        }
        [[HHDatabaseEngine sharedDBEngine] close];
}

-(void)insertNewsIntoDBWithNewsArray:(NSMutableArray *)array newsClassID:(NSString *)classID{
    
        if ([[HHDatabaseEngine sharedDBEngine] open]) {
            for (ArticleModel *model in array) {
                
                NSString *sqlStr=@"insert or ignore  into NewsTable   (NewsClassID,NewsID,NewsImage,NewsTitle,NewsVideoUrl,NewsBrief,NewsVisitNum,IsRead) values (?,?,?,?,?,?,?,?)";
               BOOL isSuccess= [[HHDatabaseEngine sharedDBEngine]  executeUpdate:sqlStr,classID,
                                model.articleID,
                                [NSString stringByReplaceNullString:model.articleImage],[NSString stringByReplaceNullString:model.articleTitle],[NSString stringByReplaceNullString:model.articleVideoUrl],[NSString stringByReplaceNullString:model.articleBrief],[NSString stringByReplaceNullString:model.articleVisitNum],@"0"];
                if (isSuccess) {
                    DLog(@"INSER News Successed");
                }

            }
        }
        [[HHDatabaseEngine sharedDBEngine] close];

}
-(void)updateNewsReadState:(NSInteger)state withNewsID:(NSString *)newID{
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *isRead=[NSString stringWithFormat:@"%ld",(long)state];
        NSString *sql=@"update NewsTable set IsRead=? WHERE NewsID=?";
        BOOL isSuccess=[[HHDatabaseEngine sharedDBEngine]  executeUpdate:sql,isRead,newID];
        if (isSuccess) {
            DLog(@"set is read success");
        }else{
            DLog(@"set is read Failed");
        }
    }
  //  [[HHDatabaseEngine sharedDBEngine] close];
}

-(NSMutableArray *)getNewsClassListFromDB{
    NSMutableArray *newsClassList=nil;
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *sqlStr=@"select * from NewsClassTable";
        FMResultSet *resultSet=[[HHDatabaseEngine sharedDBEngine] executeQuery:sqlStr];
        while  ([resultSet next]) {
            ArticleClassModel *classModel=[[ArticleClassModel alloc]  init];
            classModel.articleClassID=[resultSet stringForColumn:@"NewsClassID"];
            classModel.articleClassName=[resultSet stringForColumn:@"NewsClassName"];
          
            NSMutableArray *bannerArray=[self getBannerListWithClassID:classModel.articleClassID inDB:[HHDatabaseEngine sharedDBEngine]];
            classModel.artictleBannerArray=bannerArray;
            if (nil==newsClassList) {
                newsClassList=[[NSMutableArray alloc]  init];
            }
            [newsClassList addObject:classModel];
        }
    }
    [[HHDatabaseEngine sharedDBEngine]  close];
    return newsClassList;
}
-(NSMutableArray *)getBannerListWithClassID:(NSString *)classID inDB:(FMDatabase *)db{
    NSMutableArray *bannerArray=nil;
    NSString *bannerSql=@"select * from Banner where ClassID=?";
    FMResultSet *banerResult=[db  executeQuery:bannerSql,classID];
    while ([banerResult next]) {
        HHFlowModel *flowModel=[[HHFlowModel alloc]  init];
        flowModel.flowImageUrl=[banerResult stringForColumn:@"BannerImageUrl"];
        flowModel.flowSourceUrl=[banerResult stringForColumn:@"BannerSourceUrl"];
        if(nil==bannerArray) {
            bannerArray=[[NSMutableArray alloc]  init];
        }
        [bannerArray addObject:flowModel];
    }
    return bannerArray;
}
-(NSMutableArray *)getNewsListFromDBWithClassID:(NSString *)classID{
    NSMutableArray *newsListArray=[[NSMutableArray alloc]  init];
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *sqlStr=@"select * from NewsTable where NewsClassID=?";
        FMResultSet *resultSet=[[HHDatabaseEngine sharedDBEngine] executeQuery:sqlStr,classID];
      
        while ([resultSet next]) {
            ArticleModel *model=[[ArticleModel alloc]  init];
            model.articleID=[resultSet stringForColumn:@"NewsID"];
            model.articleImage=[resultSet stringForColumn:@"NewsImage"];
            model.articleTitle=[resultSet stringForColumn:@"NewsTitle"];
            model.articleVideoUrl=[resultSet stringForColumn:@"NewsVideoUrl"];
            model.articleBrief=[resultSet stringForColumn:@"NewsBrief"];
            model.articleVisitNum=[resultSet stringForColumn:@"NewsVisitNum"];
            model.isRead=[[resultSet stringForColumn:@"IsRead"]  boolValue];
            if (nil==newsListArray) {
                newsListArray=[[NSMutableArray alloc]  init];
            }
            [newsListArray addObject:model];
        }
    }
  //  [[HHDatabaseEngine sharedDBEngine] close];
    return newsListArray;
}
-(void)insertBanners:(NSMutableArray *)banersArray classID:(NSString *)classID{
    if ([[HHDatabaseEngine sharedDBEngine]  open]) {
        NSString *deleteSql=@"delete from Banner where classID=?";
        BOOL isDelSuccess=[[HHDatabaseEngine sharedDBEngine]  executeUpdate:deleteSql,classID];
        if (isDelSuccess) {
            DLog(@"DELETE  Banner Success");
        }
        for (HHFlowModel *flowModel in banersArray) {
            
            NSString *sqlStr=@"insert into Banner (ClassID, BannerImageUrl,BannerSourceUrl) values (?,?,?)";
            BOOL isSuccess=[[HHDatabaseEngine sharedDBEngine]  executeUpdate:sqlStr,classID,[NSString stringByReplaceNullString:flowModel.flowImageUrl],[NSString stringByReplaceNullString:flowModel.flowSourceUrl]];
            if (isSuccess) {
                DLog(@"insert into Banner success");
            }else{
                DLog(@"insert Banner failed");
            }
            
        }
    }
    [[HHDatabaseEngine sharedDBEngine]  close];
}
-(NSMutableArray *)getBannerListWithClassID:(NSString *)classID{
    NSMutableArray *bannerArray=[[NSMutableArray alloc]  init];
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        
        NSString *bannerSql=@"select * from Banner where ClassID=?";
        FMResultSet *banerResult=[[HHDatabaseEngine sharedDBEngine]  executeQuery:bannerSql,classID];
        while ([banerResult next]) {
            HHFlowModel *flowModel=[[HHFlowModel alloc]  init];
            flowModel.flowImageUrl=[banerResult stringForColumn:@"BannerImageUrl"];
            flowModel.flowSourceUrl=[banerResult stringForColumn:@"BannerSourceUrl"];
            if(nil==bannerArray) {
                bannerArray=[[NSMutableArray alloc]  init];
            }
            [bannerArray addObject:flowModel];
        }
    }
   // [[HHDatabaseEngine sharedDBEngine] close];
    return bannerArray;
}
-(ArticleModel *)getNewsDetailFromDBWithNewsID:(NSString *)newsID{
    ArticleModel *model=nil;
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *sqlStr=@"select * from NewsTable where NewID=?";
        FMResultSet *resultSet=[[HHDatabaseEngine sharedDBEngine] executeQuery:sqlStr,newsID];
        while ([resultSet next]) {
            model.articleID=[resultSet stringForColumn:@"NewsID"];
            model.articleImage=[resultSet stringForColumn:@"NewsImage"];
            model.articleTitle=[resultSet stringForColumn:@"NewTitle"];
            model.articleVideoUrl=[resultSet stringForColumn:@"NewsVideoUrl"];
            model.articleBrief=[resultSet stringForColumn:@"NewsBrief"];
            model.articleVisitNum=[resultSet stringForColumn:@"NewsVisitNum"];
            model.articleContent=[resultSet stringForColumn:@"NewsContent"];
        }
    }
    [[HHDatabaseEngine sharedDBEngine] close];
    return model;
}
-(BOOL)updateCollectStateWithNewsID:(NSString *)newsID state:(NSString *)state{
    BOOL isSuccess=NO;
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *sqlStr=@"update NewsTable set CollectedState =? where NewsID=?";
         isSuccess= [[HHDatabaseEngine sharedDBEngine] executeUpdate:sqlStr,state,newsID];
        if (isSuccess) {
            DLog(@"colelct News Successed");
        }
    }
    return isSuccess;
}
-(BOOL)addCollectWithNewsModel:(ArticleModel *)model withUserID:(NSString *)userID{
  __block  BOOL isSuccess=NO;
    userID=@"-100";
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
      isSuccess=  [self deleteOneCollectArtictle:model.articleID withUserID:userID];
        NSString *sqlStr=@"insert into MyCollect (NewsID,NewsImage,NewsTitle,NewsVideoUrl,NewsBrief,NewsVisitNum,NewsContent,UserID) values (?,?,?,?,?,?,?,?)";
         isSuccess= [[HHDatabaseEngine sharedDBEngine]  executeUpdate:sqlStr,
                        [NSString stringByReplaceNullString: model.articleID],
                        [NSString stringByReplaceNullString: model.articleImage],
                        [NSString stringByReplaceNullString: model.articleTitle],
                        [NSString stringByReplaceNullString: model.articleVideoUrl],
                        [NSString stringByReplaceNullString: model.articleBrief],
                        [NSString stringByReplaceNullString: model.articleVisitNum],
                         [NSString stringByReplaceNullString: model.articleContent],userID];
        if (isSuccess) {
            DLog(@"INSER NewsCollect Successed");
        }
    }
    return isSuccess;
}
-(NSMutableArray *)getCollectArtictleListWithUserID:(NSString *)userID pageIndex:(NSInteger)pid pageSize:(NSInteger)size{
    userID=@"-100";
    NSMutableArray *newsListArray;
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *pageIndes=[NSString stringWithFormat:@"%d",(pid-1)*size];
        NSString *pageSize=[NSString stringWithFormat:@"%d",size];
        NSString *sqlStr=@"select * from MyCollect where UserID=? limit ?,?";
        FMResultSet *resultSet=[[HHDatabaseEngine sharedDBEngine] executeQuery:sqlStr,userID,pageIndes,pageSize];
        
        while ([resultSet next]) {
            ArticleModel *model=[[ArticleModel alloc]  init];
            model.articleID=[resultSet stringForColumn:@"NewsID"];
            model.articleImage=[resultSet stringForColumn:@"NewsImage"];
            model.articleTitle=[resultSet stringForColumn:@"NewsTitle"];
            model.articleVideoUrl=[resultSet stringForColumn:@"NewsVideoUrl"];
            model.articleBrief=[resultSet stringForColumn:@"NewsBrief"];
            model.articleVisitNum=[resultSet stringForColumn:@"NewsVisitNum"];
            if (nil==newsListArray) {
                newsListArray=[[NSMutableArray alloc]  init];
            }
            [newsListArray addObject:model];
        }
    }
    [[HHDatabaseEngine sharedDBEngine] close];
    return newsListArray;

}
-(BOOL)deleteOneCollectArtictle:(NSString *)artictleID withUserID:(NSString *)userID{
  __block  BOOL isSuccess=NO;
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *sqlStr=@"delete from MyCollect where NewsID=?";
        isSuccess= [[HHDatabaseEngine sharedDBEngine] executeUpdate:sqlStr,artictleID];
        if (isSuccess) {
            DLog(@"delete colelct News Successed");
        }
    }
    return isSuccess;
}
-(BOOL)clearAllData{
    __block BOOL isSuccess=NO;
    if ([[HHDatabaseEngine sharedDBEngine] open]) {
        NSString *sql=@"delete from MyCollect";
        isSuccess=[[HHDatabaseEngine sharedDBEngine]  executeUpdate:sql];
        NSString *sql2=@"delete from NewsTable";
         isSuccess=[[HHDatabaseEngine sharedDBEngine]  executeUpdate:sql2];
    }
    [[HHDatabaseEngine sharedDBEngine] close];
    return isSuccess;
}
@end
