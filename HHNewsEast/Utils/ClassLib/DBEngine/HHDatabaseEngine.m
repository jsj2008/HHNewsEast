//
//  HHDatabaseEngine.m
//  HomeTown
//
//  Created by d gl on 14-6-20.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHDatabaseEngine.h"

#define  HHDataBaseName @"NewsDB.db"
static HHDatabaseEngine *__hhDataBaseEengine;
@implementation HHDatabaseEngine
+(instancetype)sharedDBEngine{
    @synchronized(self){
        if (nil==__hhDataBaseEengine) {
            __hhDataBaseEengine=[HHDatabaseEngine databaseWithPath:[__gDocumentPath stringByAppendingPathComponent:HHDataBaseName]];
            [__hhDataBaseEengine creatNewsClassTable];
        } 
    }
    return __hhDataBaseEengine;
}
#pragma mark -creat 新闻类别 table
-(void)creatNewsClassTable{
    if ([[HHDatabaseEngine sharedDBEngine] open]) {//
        BOOL isCreat=[[HHDatabaseEngine sharedDBEngine] executeUpdate:@"CREATE TABLE IF NOT EXISTS NewsClassTable (NewsClassID varchar UNIQUE,NewsClassName nvarchar)"];
        if (isCreat) {
            NSLog(@"creat newsclass Table success");
        }
        BOOL isSuccess=[[HHDatabaseEngine sharedDBEngine] executeUpdate:@"CREATE TABLE IF NOT EXISTS NewsTable (NewsClassID varchar ,NewsID varchar UNIQUE,NewsTitle NVARCHAR,NewsBrief nvarchar,NewsAddTime varchar ,NewsVisitNum varchar,NewsImage varchar,NewsVideoUrl varchar,NewsContent TEXT,IsRead varchar)"];
        if (isSuccess) {
            NSLog(@"creat newslist table success");
        }

        BOOL isBanner=[[HHDatabaseEngine sharedDBEngine] executeUpdate:@"CREATE TABLE IF NOT EXISTS Banner (ClassID varchar, BannerImageUrl varchar ,BannerSourceUrl varchar)"];
        if (isBanner) {
            NSLog(@"creat Banner table success");
        }

        BOOL isCollectSuccess=[[HHDatabaseEngine sharedDBEngine] executeUpdate:@"CREATE TABLE IF NOT EXISTS MyCollect (NewsClassID varchar UNIQUE,NewsID varchar,NewsTitle NVARCHAR,NewsBrief nvarchar,NewsAddTime varchar ,NewsVisitNum varchar,NewsImage varchar,NewsVideoUrl varchar,NewsContent TEXT,UserID VARCHAR)"];
        if (isCollectSuccess) {
            NSLog(@"creat MyCollect table success");
        }
        
    }
    [[HHDatabaseEngine sharedDBEngine] close];
}


@end
