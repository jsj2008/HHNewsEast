//
//  HHShareModel.m
//  MoblieCity
//
//  Created by Luigi on 14-9-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHShareModel.h"
#import "UMSocialSnsPlatformManager.h"
@implementation HHShareModel
-(id)initWithShareType:(HHSharePlatformType)type image:(UIImage *)img name:(NSString *)name{
    self=[super init];
    if (self) {
        _sharePlatformType=type;
        _shareImage=img;
        _shareName=name;
    }
    return self;
}
-(id)initWithShareType:(HHSharePlatformType)type image:(UIImage *)img name:(NSString *)name umPlatfrom:(NSString *)umName{
    self=[self initWithShareType:type image:img name:name ];
    _shareUMPlatfrorm=umName;
    return self;
}
+(NSMutableArray *)sharePaltforms{
    HHShareModel *smsShareModel=[[HHShareModel alloc]  initWithShareType:0 image: [UIImage imageNamed:@"btn_share_renren"] name:@"人人网" umPlatfrom:UMShareToRenren];
    HHShareModel *emailShareModel=[[HHShareModel alloc]  initWithShareType:0 image: [UIImage imageNamed:@"btn_share_douban"] name:@"豆瓣网" umPlatfrom:UMShareToDouban];
    HHShareModel *sinaShareModel=[[HHShareModel alloc]  initWithShareType:HHSharePlatformTypeSinaWeiBo image: [UIImage imageNamed:@"btn_share_sinaweibo"] name:@"新浪微博" umPlatfrom:UMShareToSina];
    
    HHShareModel *qqShareModel=[[HHShareModel alloc]  initWithShareType:HHSharePlatformTypeQQFriend image: [UIImage imageNamed:@"btn_share_qq"] name:@"QQ好友" umPlatfrom:UMShareToQQ];
    HHShareModel *weichatSessionShareModel=[[HHShareModel alloc]  initWithShareType:HHSharePlatformTypeWeChatTimeLine image: [UIImage imageNamed:@"btn_share_weixin"] name:@"微信朋友圈" umPlatfrom:UMShareToWechatTimeline];
    
    HHShareModel *weichatTimeLineShareModel=[[HHShareModel alloc]  initWithShareType:HHSharePlatformTypeTencentWeiBo image: [UIImage imageNamed:@"btn_share_tenxunweibo"] name:@"腾讯微博" umPlatfrom:UMShareToTencent];
    NSMutableArray *platforms=[[NSMutableArray alloc]  initWithObjects:weichatSessionShareModel,weichatTimeLineShareModel,qqShareModel,sinaShareModel,emailShareModel,smsShareModel,nil];
    return platforms;}
@end
