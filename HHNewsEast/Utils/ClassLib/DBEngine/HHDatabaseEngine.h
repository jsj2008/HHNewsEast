//
//  HHDatabaseEngine.h
//  HomeTown
//
//  Created by d gl on 14-6-20.
//  Copyright (c) 2014年 luigi. All rights reserved.
//
#import "FMDatabase.h"

@interface HHDatabaseEngine : FMDatabase
+(instancetype)sharedDBEngine;
@end
