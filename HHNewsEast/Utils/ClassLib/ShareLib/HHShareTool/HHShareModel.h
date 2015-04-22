//
//  HHShareModel.h
//  MoblieCity
//
//  Created by Luigi on 14-9-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HHSharePlatformType) {
    HHSharePlatformTypeQQFriend                   ,//QQ
    HHSharePlatformTypeWeChatSession        ,//微信好友
    HHSharePlatformTypeWeChatTimeLine       ,//微信朋友圈
    HHSharePlatformTypeSinaWeiBo            ,//新浪微博
    HHSharePlatformTypeTencentWeiBo                ,//腾讯微博
    HHSharePlatformTypeQQSpace                  ,//空间
    
};

@interface HHShareModel : NSObject
@property(nonatomic,assign)NSString *shareUMPlatfrorm;//友盟平台名称
@property(nonatomic,assign) HHSharePlatformType sharePlatformType;
@property(nonatomic,strong)UIImage *shareImage;
@property(nonatomic,copy)NSString *shareName;
-(id)initWithShareType:(HHSharePlatformType)type image:(UIImage *)img name:(NSString *)name;
-(id)initWithShareType:(HHSharePlatformType)type image:(UIImage *)img name:(NSString *)name umPlatfrom:(NSString *)umName;
+(NSMutableArray *)sharePaltforms;
@end
