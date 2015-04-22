//
//  UIViewController+HHSoft.m
//  MoblieCity
//
//  Created by Luigi on 14-7-11.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "UIViewController+HHSoft.h"

@implementation UIViewController (HHSoft)
#pragma mark- 提示信息部分
-(void)showWaitView:(NSString *)msg
{
    [SVProgressHUD showWithStatus:msg];
}
-(void)hideWaitView
{
    [SVProgressHUD dismiss];
}
-(void)showSuccessView:(NSString *)msg{
    [SVProgressHUD showSuccessWithStatus:msg];
}
-(void)showErrorView:(NSString *)msg{
    [SVProgressHUD showErrorWithStatus:msg];
}
-(void)showAlertView:(NSString *)text
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:text delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}
-(void)showAlertView:(NSString *)text delegate:(id)a_delegate{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:text delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate=a_delegate;
    [alertView show];
}


#pragma mark --scrollview Stop Anination
-(void)stopRefrashingAndReloadingWithScrollView:(UIScrollView *)svTableView{
    if (svTableView&&[svTableView isKindOfClass:[UIScrollView class]]) {
        if (svTableView.pullToRefreshView.state==SVPullToRefreshStateLoading) {
            [svTableView.pullToRefreshView stopAnimating];
        }
        if (svTableView.infiniteScrollingView.state==SVInfiniteScrollingStateLoading) {
            [svTableView.infiniteScrollingView stopAnimating];
        }
    }else{
        return;
    }
}

#pragma mark -keyboard endEdit
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
