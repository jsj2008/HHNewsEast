//
//  NSMutableDictionary+HHFrameWorkKit.h
//  HHFrameWorkKit
//
//  Created by Luigi on 14-9-25.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface NSMutableDictionary (HHFrameWorkKit)
typedef NS_ENUM(NSInteger, HHFrameWorkKitCodingType) {
    HHFrameWorkKitCodingTypeNone          =5000 ,
    HHFrameWorkKitCodingTypeURL           =5001  ,
    HHFrameWorkKitCodingTypeBase64        =5002 ,
};
typedef NS_ENUM(NSInteger, HHFrameWorkKitEncryptType) {
    HHFrameWorkKitEncryptTypeNone      = 6000,
    HHFrameWorkKitEncryptTypeAES        =6001,
    HHFrameWorkKitEncryptTypeBase64     =6002,
    HHFrameWorkKitEncryptTypeUrl        =6003,
};
typedef  NS_ENUM(NSInteger, HHFrameWorkKitPostDataType) {
    HHFrameWorkKitPostDataTypeDic          =7000 ,
    HHFrameWorkKitPostDataTypeJson          =7001,
};

+(NSString *)hh_codeKey;
+(NSString *)hh_resultKey;
+(NSString *)hh_msgKey;

-(NSMutableDictionary *)encryPostDic;
-(NSMutableDictionary *)encryPostDicWithCodeKey:(NSString *)codeKey;
-(NSMutableDictionary *)encryPostDicWithCodeKey:(NSString *)codeKey resultKey:(NSString *)resultKey;
-(NSMutableDictionary *)encryPostDicWithCodeKey:(NSString *)codeKey resultKey:(NSString *)resultKey messageKey:(NSString *)msgKey;
@end
