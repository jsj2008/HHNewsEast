//
//  SettingAPI.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-22.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "SettingAPI.h"
#define NewsEsat_SettingSuffName            @"/App/AppServlet/"
#define  NewsEsat_CheckUpdate                 @"versionUpdate"
@implementation SettingAPI
+(NSString *)checkUpdateUrl{
    NSString *apiStr=[NewsEsat_SettingSuffName stringByAppendingString:NewsEsat_CheckUpdate];
    return apiStr;
}
@end
