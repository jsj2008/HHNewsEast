//
//  UserCenterAPI.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-10.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenterAPI : NSObject
/**
 *  注册
 *
 *  @return
 */
+(NSString *)userRegisterURL;

/**
 *  登陆
 *
 *  @return
 */
+(NSString *)userLoginURL;
@end
