//
//  UserCenterAPI.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-10.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "UserCenterAPI.h"

#define UserCenter_SufferName       @"/App/AppServlet/"

#define UserRegisterURL                @"register"
#define UserLoginURL                @"login"

@implementation UserCenterAPI
/**
 *  注册
 *
 *  @return
 */
+(NSString *)userRegisterURL{
    NSString *apiUrl=[UserCenter_SufferName stringByAppendingString:UserRegisterURL];
    return apiUrl;
}

/**
 *  登陆
 *
 *  @return
 */
+(NSString *)userLoginURL{
    NSString *apiUrl=[UserCenter_SufferName stringByAppendingString:UserLoginURL];
    return apiUrl;
}

@end
