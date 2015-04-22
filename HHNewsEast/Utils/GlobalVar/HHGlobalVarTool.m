//
//  HHGlobalVarTool.m
//  MoblieCity
//
//  Created by Luigi on 14-8-21.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHGlobalVarTool.h"

@implementation HHGlobalVarTool
/**
 *  数据库的路径
 *
 *  @return Nsstring
 */
+(NSString *)dataBasePath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"MoblieCity.db"];
}
+(NSString *)domianName{
    return @"103.31.72.11:8080";
}
+(CGFloat)pageSize{
    return 30.0;
}
+(UIColor *)themeBgColor{
    return [UIColor whiteColor];
}

#pragma mark- cache
+(NSString *)severCompletionPath:(NSString *)path{
    NSString *imgPath=[@"http://103.31.72.11:8080/" stringByAppendingString:path];
    return imgPath;
}
+(NSString  *)chatMessageImageDir{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
}
+(NSString  *)chatMessageVoiceDir{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VoiceCache"];
}
+(NSString *)fullUserHeaderImagePath:(NSString *)imgPath{
    imgPath=imgPath.length?imgPath:@"";
    return [@"http://103.31.72.11:8080/App" stringByAppendingString:imgPath];
}
+(NSString *)fullNewsImagePath:(NSString *)imgPath{
     imgPath=imgPath.length?imgPath:@"";
 return [@"http://www.hrgjtv.com" stringByAppendingString:imgPath];
}
#pragma mark- token
+(NSString *)deviceToken{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults]  objectForKey:@"__DeviceToken__"];
    return tokenStr;
}
+(void)setDeviceToken:(NSString *)deviceToken{
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"__DeviceToken__"];
}

    //设置排序的方式
+(NSString *)sortOrder{
    NSString *sortOrderStr=[[NSUserDefaults standardUserDefaults]  objectForKey:@"__SortOrder__"];
    if (nil==sortOrderStr) {
        sortOrderStr=@"";
    }
    return sortOrderStr;
}
+(void)setSortOrder:(NSString *)order{
    [[NSUserDefaults standardUserDefaults] setObject:order forKey:@"__SortOrder__"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}
+(NSString *)newsClassID{
    NSString *classIDStr=[[NSUserDefaults standardUserDefaults]  objectForKey:@"__NewsClassID__"];
    return classIDStr;
}
+(void)setNewsClassID:(NSString *)classID{
 [[NSUserDefaults standardUserDefaults] setObject:classID forKey:@"__NewsClassID__"];
}


#pragma mark- app
+(NSString *)appStoreDownloadUrl{
    return   @"" ;
}
+(NSString *)appName{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:@"CFBundleDisplayName"];
}
+(NSString *)appVersion{
    NSDictionary *dic=[[NSBundle mainBundle]   infoDictionary];
    return [dic objectForKey:(NSString*)kCFBundleVersionKey];
}
#pragma mark- share
+(NSString *)shareUrlWithType:(NSInteger)type objectID:(NSString *)objectID{
    NSString *shareUrl=@"";
    NSString *sufferName=@"";
   
    shareUrl=[[shareUrl stringByAppendingString:sufferName] stringByAppendingFormat:@"?id=%@",objectID];
    return shareUrl;
}
+(NSString *)shareDownloadUrl{
return @"";
}
+(NSString *)shareUMKey{
    return @"54923798fd98c55832001595";
}
+(NSString *)shareQQKey{
    return @"HRvNRgA0C5crpXnE";
}
+(NSString *)shareQQID{
    return @"1103558344";
}
+(NSString *)shareWeiXinID{
    return @"wx55f28869bde62863";
}
+(NSString *)shareWeiXinSecret{
    return @"4cce4380808095ff111b8f50d62d9d9f";
}
+(NSString *)shareSinaWeiBoRedirectURI{
    return@"http://shtv.hrtv.cn";
}
+(NSString *)shareSinaKey{
    return @"704676314";
}
+(NSString *)shareSinaSecret{
    return @"ee6e717b33f5ab8e3b7a88922a4d089a";
}
#pragma mark- weixin login
+(NSString *)weixinLoignStateStr{
    return @"";
}
@end
