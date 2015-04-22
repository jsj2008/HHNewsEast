//
//  HHNetWorkEngine+Setting.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-22.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHNetWorkEngine+Setting.h"
#import "SettingAPI.h"
@implementation HHNetWorkEngine (Setting)
-(MKNetworkOperation *)checkUpdateWithVersionNum:(NSString *)versionName onCompletionHander:(HHResponseResultModelSucceedBlock)completionResult
                                  onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=[SettingAPI checkUpdateUrl];
    NSMutableDictionary*postDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:versionName,@"version",@"2",@"platform", nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] requestWithUrlPath:urlPath parmarDic:postDic method:HHPOST onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=[self parseCheckUpdateResposeResult:responseResult];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
        
    }];
    return op;
}
-(HHResponseResult *)parseCheckUpdateResposeResult:(HHResponseResult *)responseResult{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        responseResult.responseData=[responseResult.responseData objectForKey:@"updateURL"];
    }else{
      
    }
    return responseResult;
}

@end
