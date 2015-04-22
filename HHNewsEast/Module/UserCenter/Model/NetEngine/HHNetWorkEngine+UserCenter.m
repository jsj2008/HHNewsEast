//
//  HHNetWorkEngine+UserCenter.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-10.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+UserCenter.h"
#import "UserCenterAPI.h"
@implementation HHNetWorkEngine (UserCenter)
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
                                onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[UserCenterAPI userRegisterURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [userName URLEncodedString],@"username",
                                    [userPwd URLEncodedString],@"password",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult*listResult=[self parseUserRegisterWithResposeResult:responseResult];
        completionResult(listResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    return op;
}
-(HHResponseResult *)parseUserRegisterWithResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        [UserModel userRegisterAndLoginWithResponseDic:responseResult.responseData];
    }
    return responseResult;
}

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
                              onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[UserCenterAPI userLoginURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [userName URLEncodedString],@"username",
                                    [userPwd URLEncodedString],@"password",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult*listResult=[self parseUserRegisterWithResposeResult:responseResult];
        completionResult(listResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    return op;

}
-(HHResponseResult *)parseUserLoginWithResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        [UserModel userRegisterAndLoginWithResponseDic:responseResult.responseData];
    }
    return responseResult;
}
-(MKNetworkOperation *)editUserInfoWithUserID:(NSString *)userID
                                  UserMessage:(NSString *)message
                                         item:(NSInteger)item
                          OnCompletionHandler:(HHResponseResultModelSucceedBlock)completionResult
                               onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[UserCenterAPI userLoginURL];
    NSMutableDictionary *resultDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    userID,@"userid",
                                    message,@"userItem",nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:urlPath parmarDic:resultDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult*listResult=[self parseEditUserInfoWithResposeResult:responseResult];
        completionResult(listResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    return op;
}
-(HHResponseResult *)parseEditUserInfoWithResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        //[UserModel userRegisterAndLoginWithResponseDic:responseResult.responseData];
    }
    return responseResult;
}

@end
