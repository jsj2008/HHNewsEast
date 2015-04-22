//
//  HHNetWorkEngine+UploadImage.m
//  HomeTown
//
//  Created by d gl on 14-6-20.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHNetWorkEngine+UploadImage.h"
#define HHUploadImageSufferName        @"/App/AppServlet/setImg"
@implementation HHNetWorkEngine (UploadImage)
-(MKNetworkOperation *)uploadImageWithImagePath:(NSString *)imgPath
                                      imageMark:(HHUploadImageMark)mark
                            OnCompletionHandler:(HHResponseResultStringSucceedBlock)completionResult
                                 onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=HHUploadImageSufferName;
    NSMutableDictionary *postDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[UserModel userID],@"EmpID", nil];
    //[[HHNetWorkEngine sharedHHNetWorkEngine] setIsEncrypted:NO];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] uploadFileWithPath:urlPath filePath:imgPath parmarDic:postDic key:@"imgData" onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=   [self parseJsonUplaodImageWithResponseResult:responseResult imageMark:mark];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
-(HHResponseResult *)parseJsonUplaodImageWithResponseResult:(HHResponseResult *)responseResult imageMark:(HHUploadImageMark)mark
{
    if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
        NSDictionary *dic=responseResult.responseData;
        HHImageModel *model=[[HHImageModel alloc] init];
        model.imageSourceUrl  =[dic objectForKey:@""];
        model.imageBigUrl  =[dic objectForKey:@"photoURI"];//头像
        model.imageThumbUrl  =[dic objectForKey:@""];
        responseResult.responseData=model;
        responseResult.responseMessage=@"上传成功";
    } else if ([responseResult.responseCode isEqualToString:CODE_STATE_101]){//上传失败
        responseResult.responseMessage=@"上传失败";
    } else if ([responseResult.responseCode isEqualToString:CODE_STATE_102]){//参数错误
        responseResult.responseMessage=@"参数为空";
    }else if ([responseResult.responseCode isEqualToString:CODE_STATE_103]){//文件类型错误
        responseResult.responseMessage=@"图片格式错误";
    }else if ([responseResult.responseCode isEqualToString:CODE_STATE_104]){// 超过最大限制
        responseResult.responseMessage=@"图片过大";
    }else if ([responseResult.responseCode isEqualToString:CODE_STATE_105]){//上传失败
    }
    
    return responseResult;
}

-(MKNetworkOperation *)uploadImageWithImageData:(NSData *)imgData
                                      imageMark:(HHUploadImageMark)mark
                            OnCompletionHandler:(HHResponseResultStringSucceedBlock)completionResult
                                 onErrorHandler:(MKNKErrorBlock)errorBlock{
    NSString *urlPath=HHUploadImageSufferName;
    NSMutableDictionary *postDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",mark],@"mark", nil];
    MKNetworkOperation *op=[[HHNetWorkEngine sharedHHNetWorkEngine] uploadFileWithUrlPath:urlPath fileData:imgData parmarDic:postDic key:@"photo" onCompletionHandler:^(HHResponseResult *responseResult) {
        HHResponseResult *tempRespostResult=   [self parseJsonUplaodImageWithResponseResult:responseResult imageMark:mark];
        completionResult(tempRespostResult);
    } onErrorHander:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    return op;
}
@end
