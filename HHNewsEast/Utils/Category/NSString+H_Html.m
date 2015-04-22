//
//  NSString+H_Html.m
//  MoblieCity
//
//  Created by Luigi on 14-7-15.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "NSString+H_Html.h"
@implementation NSString (H_Html)

#pragma mark- 生成html
+(NSString *)htmlStringWithTitle:(NSString *)title
                            time:(NSString *)time author:(NSString *)author visitCount:(NSString *)visitCount content:(NSString *)content{
    title=[NSString stringByReplaceNullString:title];
    NSString *subTitle=@"";
    if (author&&author.length) {
        author=[@"" stringByAppendingString:author];
        subTitle=[subTitle stringByAppendingString:author];
    }
    if (time&&time.length) {
        subTitle=[subTitle stringByAppendingString:@""];
        subTitle=[subTitle stringByAppendingString:time];
        
    }
    if (visitCount&&visitCount.length) {
        subTitle=[subTitle stringByAppendingString:@" "];
        visitCount=[visitCount stringByAppendingString:@""];
        subTitle=[subTitle stringByAppendingString:visitCount];
    }
    
    content=[NSString stringByReplaceNullString:content];
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"MobileArtictl.bundle/mobilearticletem" ofType:@"htm"];
    NSString *templeteHtml=[NSString stringWithContentsOfFile:filePath encoding:4 error:nil];
//    NSString *JqyertPath = [[NSBundle mainBundle] pathForResource:@"MobileArtictl.bundle/mobilearticletem" ofType:@"js"];
//    NSString *jsString = [NSString stringWithContentsOfFile:JqyertPath encoding:4 error:nil];
//    templeteHtml = [templeteHtml stringByReplacingOccurrencesOfString:@"<!--JqueryEditor-->" withString:jsString];
    
    
    templeteHtml=[templeteHtml stringByReplacingOccurrencesOfString:@"$title" withString:title];
    templeteHtml=[templeteHtml stringByReplacingOccurrencesOfString:@"$subtitle" withString:subTitle];
    
    templeteHtml=[templeteHtml stringByReplacingOccurrencesOfString:@"$content" withString:content];
    return templeteHtml;
}
+(NSString *)htmlStringWithTitle:(NSString *)title
                            time:(NSString *)time
                          author:(NSString *)author
                      visitCount:(NSString *)visitCount
                        videoUrl:(NSString *)videoUrl
                       posterUrl:(NSString *)posterUrl
                         content:(NSString *)content{

    NSString *videoStr=videoUrl;
    if ((![NSString IsNullOrEmptyString:videoStr])&&(![videoStr isEqualToString:@"null"]||![videoStr isEqualToString:@"nil"])) {
        posterUrl=(posterUrl.length?posterUrl:@"");
        //onclick=\"clickVideoLink(this);\"
        videoStr=[NSString stringWithFormat:@"<div>\
                  <video id=\"video\" width=\"98%%\" height=\"150\"  src=\"%@\" controls=\"controls\" poster=\"%@\"  >\
                  </video>\
                  </div>",videoStr,posterUrl];
        
    }
    content=content.length?content:@"";
    content=[videoStr stringByAppendingString:content];
    return [self htmlStringWithTitle:title time:time author:author visitCount:visitCount content:content];
}
+(NSString *)htmlStringWithTitle:(NSString *)title
                            time:(NSString *)time
                          author:(NSString *)author
                      visitCount:(NSString *)visitCount
                          images:(NSArray *)imgArray
                         content:(NSString *)content{
    title=[NSString stringByReplaceNullString:title];
    NSString *subTitle=@"";
    if (author&&author.length) {
        author=[@"来源:" stringByAppendingString:author];
        subTitle=[subTitle stringByAppendingString:author];
    }
    if (time&&time.length) {
        subTitle=[subTitle stringByAppendingString:@""];
        subTitle=[subTitle stringByAppendingString:time];
        
    }
    if (visitCount&&visitCount.length) {
        subTitle=[subTitle stringByAppendingString:@" "];
        visitCount=[visitCount stringByAppendingString:@"浏览"];
        subTitle=[subTitle stringByAppendingString:visitCount];
    }
    
    content=[NSString stringByReplaceNullString:content];
    NSString *imgTagStr=@"<div>";
    for (NSString *imgStr in imgArray) {
        imgTagStr=[imgTagStr stringByAppendingString:[NSString stringWithFormat:@"<img align=\"center\" src=\"%@\" onclick=\"clickLink(this);\"/>",imgStr]];
    }
    imgTagStr=[imgTagStr stringByAppendingString:@"</div>"];
    content=[imgTagStr stringByAppendingString:content];
    
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"MobileArtictl.bundle/mobilearticletem" ofType:@"htm"];
    NSString *templeteHtml=[NSString stringWithContentsOfFile:filePath encoding:4 error:nil];
    templeteHtml=[templeteHtml stringByReplacingOccurrencesOfString:@"$title" withString:title];
    templeteHtml=[templeteHtml stringByReplacingOccurrencesOfString:@"$subtitle" withString:subTitle];
    
    templeteHtml=[templeteHtml stringByReplacingOccurrencesOfString:@"$content" withString:content];
    return templeteHtml;
    
}
@end

@implementation NSString(StringBounds)

- (CGSize)boundingRectWithfont:(UIFont *)font maxTextSize:(CGSize)maxTextSize
{
    CGSize contentSize;
    if (CURRENT_SYS_VERSION>=7) {
        contentSize=[self boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    }else{
        contentSize=[self sizeWithFont:font constrainedToSize:maxTextSize];
    }
    return contentSize;
}

@end
