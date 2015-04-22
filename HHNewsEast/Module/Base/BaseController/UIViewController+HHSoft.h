//
//  UIViewController+HHSoft.h
//  MoblieCity
//
//  Created by Luigi on 14-7-11.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HHSoft)
#pragma mark- 提示信息部分
/**
 *  WatiView
 *
 *  @param msg 请等待提示信息
 */
-(void)showWaitView:(NSString *)msg;
-(void)hideWaitView;
-(void)showSuccessView:(NSString *)msg;
-(void)showErrorView:(NSString *)msg;
/**
 *  AlertView 提示框
 *
 *  @param text 提示信息
 */
-(void)showAlertView:(NSString *)text;
-(void)showAlertView:(NSString *)text delegate:(id)a_delegate;






#pragma mark --tableview stop anination
-(void)stopRefrashingAndReloadingWithScrollView:(UIScrollView *)svTableView;
#pragma mark -keyboard endEdit
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
