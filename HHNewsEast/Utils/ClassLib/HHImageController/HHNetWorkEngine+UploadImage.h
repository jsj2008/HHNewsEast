//
//  HHNetWorkEngine+UploadImage.h
//  HomeTown
//
//  Created by d gl on 14-6-20.
//  Copyright (c) 2014年 luigi. All rights reserved.
//


#import "HHImageModel.h"
#import "HHUploadImageType.h"
@interface HHNetWorkEngine (UploadImage)
/**
 * 上传图片
 *
 *  @param imgPath          图片路径
 *  @param mark             makr 表示
 *  @param completionResult
 *  @param errorBlock
 *
 *  @return
 */
-(MKNetworkOperation *)uploadImageWithImagePath:(NSString *)imgPath
                                      imageMark:(HHUploadImageMark)mark
                            OnCompletionHandler:(HHResponseResultStringSucceedBlock)completionResult
                                 onErrorHandler:(MKNKErrorBlock)errorBlock;

-(MKNetworkOperation *)uploadImageWithImageData:(NSData *)imgData
                                      imageMark:(HHUploadImageMark)mark
                            OnCompletionHandler:(HHResponseResultStringSucceedBlock)completionResult
                                 onErrorHandler:(MKNKErrorBlock)errorBlock;
@end
