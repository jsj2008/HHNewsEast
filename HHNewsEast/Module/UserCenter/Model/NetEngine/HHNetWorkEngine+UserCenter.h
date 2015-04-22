//
//  HHNetWorkEngine+UserCenter.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-10.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

@interface HHNetWorkEngine (UserCenter)
/**
 *  注册
 *
 *  @param userName         用户名
 *  @param userPwd          用户名
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)userRegiserWithUserName:(NSString *)userName
                                       userPwd:(NSString *)userPwd
                          OnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                               onErrorHandler:(MKNKErrorBlock)errorBlock;


/**
 *  登陆
 *
 *  @param userName         用户名
 *  @param userPwd          用户密码
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)userLoginWithUserName:(NSString *)userName
                                       userPwd:(NSString *)userPwd
                           OnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                                onErrorHandler:(MKNKErrorBlock)errorBlock;

/**
 *  修改用户的基本信息
 *
 *  @param userID
 *  @param message
 *  @param item
 *  @param userPwd
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)editUserInfoWithUserID:(NSString *)userID
                                  UserMessage:(NSString *)message
                                              item:(NSInteger)item
                          OnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                              onErrorHandler:(MKNKErrorBlock)errorBlock;


@end
