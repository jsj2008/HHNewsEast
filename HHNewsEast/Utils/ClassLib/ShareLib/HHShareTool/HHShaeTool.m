    //
    //  HHShaeTool.m
    //  MoblieCity
    //
    //  Created by Luigi on 14-8-26.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import "HHShaeTool.h"
#import "HHShareView.h"
#import "HHShareModel.h"
#import "SVProgressHUD.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "NSString+HTML.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
static HHShaeTool *hhShareTool;
@interface HHShaeTool ()
@property(nonatomic,assign)HHShareResultState shareState;
@property(nonatomic,copy)HHShareCompletionBlock shareCompletionBlock;




@end

@implementation HHShaeTool


+(id)sharedHHShareTool{
    @synchronized(self){
        if (nil==hhShareTool) {
            hhShareTool=[[HHShaeTool alloc]  init];
        }
    }
    return hhShareTool;
}
-(void)shareOnController:(UIViewController *)controller
               withTitle:(NSString *)title
                    text:(NSString *)text
                   image:(UIImage *)img
                     url:(NSString *)url
               shareType:(HHShareMudleType)type
                  itemID:(NSString *)itemID onCompletionHander:(HHShareCompletionBlock)completionHander{
    url=@"http://www.hrtv.cn";
    typeof(controller) __weak weakController = controller;
    if (nil==img) {
        img=[UIImage imageNamed:@"icon"];
    }
    
    HHShareView *shareView= [HHShareView shareView];
    [shareView  showSharedView];
    typeof(shareView) __weak weakShareView = shareView;
    shareView.shareViewItemViewClickedBolock=^(HHShareModel *itemModel){
        NSString *platName=[itemModel.shareUMPlatfrorm copy];
        NSArray *platArray=[NSArray arrayWithObjects:platName,nil];
        NSString *titleStr=[NSString stringByReplaceNullString:title];
        NSString *urlStr=[NSString stringByReplaceNullString:url];
        
        __block NSString *plainText=text;
        if (plainText.length>2000) {
            plainText=[plainText substringWithRange:NSMakeRange(0, 2000)];
        }
        plainText=[plainText stringByConvertingHTMLToPlainText];//
        if (plainText.length>100) {
            plainText=[plainText substringWithRange:NSMakeRange(0, 100)];
        }
        
        [UMSocialWechatHandler setWXAppId:[HHGlobalVarTool shareWeiXinID] appSecret:[HHGlobalVarTool shareWeiXinSecret] url:urlStr];
        
            //设置分享到QQ空间的应用Id，和分享url 链接
        [UMSocialQQHandler setQQWithAppId:[HHGlobalVarTool shareQQID] appKey:[HHGlobalVarTool shareQQKey] url:urlStr];
        [UMSocialData defaultData].extConfig.emailData.title =titleStr;
        [UMSocialData defaultData].extConfig.tencentData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.title =titleStr;
        [UMSocialData defaultData].extConfig.qqData.title =titleStr;
        [UMSocialData defaultData].extConfig.wechatSessionData.url=urlStr; //微信好友
        [UMSocialData defaultData].extConfig.wechatTimelineData.url=urlStr; //微信朋友圈
        
        UMSocialUrlResource *urlResource=   [[UMSocialUrlResource alloc]  initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
        [weakShareView hideShareView];//隐藏分享的view
        
        [[UMSocialDataService defaultDataService] postSNSWithTypes:platArray
                                                           content:[NSString stringByReplaceNullString:plainText]
                                                             image:img
                                                          location:nil
                                                       urlResource:urlResource
                                               presentedController:weakController
         
                                                        completion:^(UMSocialResponseEntity *response) {
                                                            
                                                            switch (response.responseCode) {
                                                                case UMSResponseCodeSuccess:{
                                                                        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                                                                    
                                                                } break;
                                                                case UMSResponseCodeCancel:{
                                                                    completionHander(HHShareResultStateFailed);
                                                                    [SVProgressHUD showErrorWithStatus:@"您已取消授权"];
                                                                } break;
                                                                default:{
                                                                    completionHander(HHShareResultStateFailed);
                                                                    [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                                                }
                                                                    break;
                                                            }
                                                        }];
        
    };
}




+(void)setSharePlatform{
    [WXApi registerApp:[HHGlobalVarTool shareWeiXinID]];
    [UMSocialData setAppKey:[HHGlobalVarTool shareUMKey]];
    [UMSocialWechatHandler setWXAppId:[HHGlobalVarTool shareWeiXinID] appSecret:[HHGlobalVarTool shareWeiXinSecret] url:[HHGlobalVarTool shareDownloadUrl]];
    
        //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:[HHGlobalVarTool shareQQID] appKey:[HHGlobalVarTool shareQQKey] url:[HHGlobalVarTool shareDownloadUrl]];
    [UMSocialConfig setSnsPlatformNames:[NSArray arrayWithObjects:UMShareToSms,UMShareToEmail,UMShareToSina,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline, nil]];
        //  [WeiboSDK registerApp:[HHGlobalVarTool shareSinaWeiBoKey]];
    
}
-(BOOL)hhShareHandlerOpenUrl:(NSURL *)url delegate:(id)delegate;{

    BOOL can=NO;
    NSString *str=[NSString stringWithFormat:@"%@",url];
    if ([str hasPrefix:[HHGlobalVarTool shareWeiXinID]]) {
        if ([WXApi handleOpenURL:url delegate:self]) {
            can=YES;
            _shareState=HHShareResultStateSucceed;
        }
        else 
        {
            can=NO;
            _shareState=HHShareResultStateFailed;
        }
        _shareCompletionBlock(_shareState);
    }
//    else if ([str hasPrefix:[NSString stringWithFormat:@"wb%@",[HHGlobalVarTool shareSinaWeiBoKey]]]){
//        if ([WeiboSDK handleOpenURL:url delegate:self]) {
//            can=YES;
//            _shareState=HHShareResultStateSucceed;
//        }
//        else{
//            can=NO;
//            _shareState=HHShareResultStateFailed;
//        }
//        _shareCompletionBlock(_shareState);
//    }
    else if ([str hasPrefix:[NSString stringWithFormat:@"tencent%@",[HHGlobalVarTool shareQQID]]]){
        if ([TencentOAuth HandleOpenURL:url]) {
            can=YES;
            _shareState=HHShareResultStateSucceed;
        }
        else{
            can=NO;
            _shareState=HHShareResultStateFailed;
        }
        _shareCompletionBlock(_shareState);
    }
    else if ([str hasPrefix:@"seagroupbuy"]){
        can=YES;
    }
    return can;
}
#pragma mark ---WinXin Delegate
-(void) onReq:(BaseReq*)req
{
    
}

-(void) onResp:(BaseResp*)resp
{
    NSString *alertMsg=@"";
    switch (resp.errCode) {
        case 0:
            alertMsg=@"微信分享成功";
            break;
        case -1:
            alertMsg=@"发生错误";
            break;
        case -2:
            alertMsg=@"您已取消";
            break;
        case -3:
            alertMsg=@"发送失败";
            break;
        case -4:
            alertMsg=@"授权失败";
            break;
        case -5:
            alertMsg=@"微信不支持";
            break;
        default:
            break;
    }
    if (resp.errCode==0) {
        [SVProgressHUD showSuccessWithStatus:alertMsg duration:2.0];
    }else{
        [SVProgressHUD showErrorWithStatus:alertMsg duration:2.0];
    }
}




@end
