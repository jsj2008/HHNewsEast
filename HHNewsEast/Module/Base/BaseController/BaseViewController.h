//
//  BaseViewController.h
//  DdmBuy
//
//  Created by Luigi on 13-10-7.
//  Copyright (c) 2013年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HHControllerHideType){
    HHControllerHideTypePop     =0,
    HHControllerHideTypeDismiss =1,
};

@interface BaseViewController : UIViewController

@property (nonatomic,strong)    MKNetworkOperation *op;
/**
 *  ControllerHideType; defaule is HHControllerHideTypePop
 */
@property (nonatomic,assign)    HHControllerHideType hideType;

@property(nonatomic,assign)BOOL isBackButtonShow,enableShare,enableCollect,enableComment,enableRightView;

-(void)enablSwipGestureOnView:(UIView *)view;
/**
 *  点击返回按钮触发改方法
 *
 *  @param hideType 
 */
-(void)backButtonPressedHiddenController:(HHControllerHideType)hideType;

-(void)didCollectButtonPressed;
-(void)didShareButtonPressed;
-(void)didCommentButtonPressed;
@end

