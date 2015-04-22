    //
    //  HHNetWorkEngine+Setting.h
    //  HHNewsEast
    //
    //  Created by Luigi on 14-9-22.
    //  Copyright (c) 2014年 Luigi. All rights reserved.
    //



@interface HHNetWorkEngine (Setting)
-(MKNetworkOperation *)checkUpdateWithVersionNum:(NSString *)versionName onCompletionHander:(HHResponseResultModelSucceedBlock)completionResult
                                  onErrorHandler:(MKNKErrorBlock)errorBlock;
@end
