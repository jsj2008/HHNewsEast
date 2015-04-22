//
//  HHImageModel.m
//  HomeTown
//
//  Created by d gl on 14-6-20.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHImageModel.h"

@implementation HHImageModel

+(HHImageModel *)imageModelWithResponseDictory:(NSDictionary*)dic{
    HHImageModel *imgModel=[[HHImageModel alloc] init];
    imgModel.imageSourceUrl=[[dic objectForKey:@"source_img"] URLDecodedString];
    imgModel.imageBigUrl=[[dic objectForKey:@"big_img"] URLDecodedString];
    imgModel.imageThumbUrl=[[dic objectForKey:@"thumb_img"] URLDecodedString];
    return imgModel;
}
@end
