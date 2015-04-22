//
//  PublishCommentViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-22.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "PublishCommentViewController.h"
#import "HHNetWorkEngine+News.h"
@interface PublishCommentViewController ()
@property(nonatomic,strong)HHTextView *contentTextView;
@property(nonatomic,strong)HHView *footView,*headerView;
@end

@implementation PublishCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.enableRefreshData=NO;
    self.dataTableView.tableFooterView=self.footView;
    self.dataTableView.tableHeaderView=self.headerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(HHView *)headerView{
    if (nil==_headerView) {
        _headerView=[[HHView alloc]  initWithFrame:CGRectMake(0, 0, __gScreenWidth, 120)];
        [_headerView addSubview:self.contentTextView];
    }
    return _headerView;
}
-(HHView *)footView{
    if (nil==_footView) {
        _footView=[[HHView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        
        HHButton *loginButton=[HHButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(40, 40, CGRectGetWidth(self.view.bounds)-40*2, 40) titleColor:[UIColor whiteColor] titleSize:20];
        [loginButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setTitle:@"评论" forState:UIControlStateNormal];
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        loginButton.layer.cornerRadius=5.0;
        loginButton.layer.masksToBounds=YES;
        loginButton.backgroundColor=[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1];
        [_footView addSubview:loginButton];
    }
    return _footView;
}
-(void)doneButtonPressed{
    if (_contentTextView.text) {
        [self showWaitView:@"请稍后..."];
        self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  publishCommentWithUserID:[UserModel userID] newsID:_newsID commentContent:_contentTextView.text onCompletionHandler:^(HHResponseResult *responseResult) {
            if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
                [self hideWaitView];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showErrorView:responseResult.responseMessage];
            }
        } onErrorHandler:^(NSError *error) {
            [self showErrorView:@"网络连接错误"];
        }];
    }
}
-(HHTextView *)contentTextView{
    if (nil==_contentTextView) {
        _contentTextView=[[HHTextView alloc] initWithFrame:CGRectMake(10, 20, __gScreenWidth-20, 80) textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:14] delegate:self placeHolderString:@"写评论..."];
        _contentTextView.layer.borderColor=[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1].CGColor;
        _contentTextView.layer.borderWidth=1.0;
        _contentTextView.layer.cornerRadius=3;
        _contentTextView.layer.masksToBounds=YES;
        [_contentTextView becomeFirstResponder];
    }
    return _contentTextView;
}

@end
