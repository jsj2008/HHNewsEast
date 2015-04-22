//
//  HHShaeTool.h
//  MoblieCity
//
//  Created by Luigi on 14-8-26.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HHShareResultState) {
    HHShareResultStateNone          =99,
    HHShareResultStateSucceed       =100,//分享成功
    HHShareResultStateFailed        =101,//分享失败
};

typedef NS_ENUM(NSInteger, HHShareMudleType) {
    HHShareMudleTypeOrder        =100,
};
typedef void(^HHShareCompletionBlock)(HHShareResultState state);

@interface HHShaeTool : NSObject
+(id)sharedHHShareTool;
+(void)setSharePlatform;
/**
 *  分享
 *
 *  @param controller 当前的controller
 *  @param title      标题
 *  @param text       内容
 *  @param img        图片（UIImage类型）
 *  @param url        分享的url
 *  @param type       分享的类型（PushMessageType)
 *  @param itemID      分享当前对象的id
 *  @param completionHander      分享的回调，（目前只有成功和失败两种状态）
 */
-(void)shareOnController:(UIViewController *)controller
               withTitle:(NSString *)title
                    text:(NSString *)text
                   image:(UIImage *)img
                     url:(NSString *)url
               shareType:(HHShareMudleType)type
                  itemID:(NSString *)itemID onCompletionHander:(HHShareCompletionBlock)completionHander;
-(BOOL)hhShareHandlerOpenUrl:(NSURL *)url delegate:(id)delegate;
@end
