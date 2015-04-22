//
//  HHImageModel.h
//  HomeTown
//
//  Created by d gl on 14-6-20.
//  Copyright (c) 2014年 luigi. All rights reserved.
//




#import <Foundation/Foundation.h>

@interface HHImageModel : NSObject
@property(nonatomic,copy)NSString *imageThumbUrl;
@property(nonatomic,copy)NSString *imageBigUrl;
@property(nonatomic,copy)NSString *imageSourceUrl;

@property(nonatomic,assign)CGSize  imageThumbSize;
@property(nonatomic,assign)CGSize  imageBigSize;
@property(nonatomic,assign)CGSize  imageSourceSize;

+(HHImageModel *)imageModelWithResponseDictory:(NSDictionary*)dic;
@end
