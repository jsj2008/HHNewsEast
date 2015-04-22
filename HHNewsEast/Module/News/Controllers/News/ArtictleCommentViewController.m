//
//  ArtictleCommentViewController.m
//  SeaArticle
//
//  Created by d gl on 14-6-9.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "ArtictleCommentViewController.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "HHNetWorkEngine+News.h"
#import "PublishCommentViewController.h"

@interface ArtictleCommentViewController ()<CommentCellDelegate>
@end

@implementation ArtictleCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self getCommentList];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self onInitData];
}

-(void)onInitData{
    self.isBackButtonShow=NO;
    self.navigationController.navigationBarHidden=NO;
    self.dataTableView.frame=CGRectMake(0, 0, __gScreenWidth, __gScreenHeight-__gTopViewHeight);
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(publishCommentButtonPressed)];
    
    NSArray *actionButtonItems = @[addItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    [self getCommentList];
}
-(void)refreshData{
    [super refreshData];
    [self getCommentList];
}
-(void)loadMoreData{
    [super loadMoreData];
    [self getCommentList];
}
-(void)publishCommentButtonPressed{
    PublishCommentViewController *publishCommentController=[[PublishCommentViewController alloc]  init];
    publishCommentController.newsID=self.artictleID;
    publishCommentController.navigationItem.title=@"发表评论";
    [self.navigationController pushViewController:publishCommentController animated:YES];
}
#pragma mark- 获取评论列表
-(void)getCommentList{
         if (self.dataMutableArray.count==0) {
        [self.view showLoadingViewWithText:HHLoadWaitMessage animationImages:HHLoadWaitAnimationImages animationDuration:HHLoadWaitAnimationDuration];
             }
    self.op =[[HHNetWorkEngine sharedHHNetWorkEngine] getCommentListwithpageIndex:self.pageIndex articleid:_artictleID onCompletionHandler:^(HHResponseResult *responseResult) {
       
        [self.view hideLoadingView];
        if ([responseResult.responseCode isEqual: CODE_STATE_100]) {
            if (self.pageIndex==1) {
                [self.dataMutableArray removeAllObjects];
            }
            [self.dataMutableArray addObjectsFromArray: responseResult.responseData];
            [self.dataTableView reloadData];
        }else if ([responseResult.responseCode isEqualToString:CODE_STATE_101]){
            if (self.dataMutableArray==0) {
                   [self.view showLoadingViewWithText:responseResult.responseMessage showImage:HHLoadFailedImage delegate:nil touchType:HHLoadingViewTouchTypeNone];
            }else{
                [self showErrorView:responseResult.responseMessage];
            }
        }
        
         [self.dataTableView stopRefrshAndInfiniteAnimating];
    }onErrorHandler:^(NSError *error) {
        if (self.dataMutableArray==0) {
            [self.dataTableView showLoadingViewWithText:HHLoadFailedMessage showImage:HHLoadFailedImage delegate:nil touchType:HHLoadingViewTouchTypeNone];
        }else{
            [self showErrorView:@"网络连接错误"];
        }
        [self.dataTableView stopRefrshAndInfiniteAnimating];
    }];
}

#pragma mark -点赞
-(void)commentCellDidFavorButtonPressedWithComemntModel:(CommentModel *)comentModel{
    [self showWaitView:@"请稍后..."];
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  favorComemntWithCommentID:comentModel.commentId onCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
              [self showSuccessView:@"点赞成功"];
            comentModel.isFavored=YES;
            comentModel.commentFavorNum=responseResult.responseData;
            NSInteger index=[self.dataMutableArray indexOfObject:comentModel];
            [self.dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [self showErrorView:responseResult.responseMessage];
        }
    } onErrorHandler:^(NSError *error) {
        [self showErrorView:@"网络连接错误"];
    }];
}
#pragma mark --tableView DataSource and Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row=0;
    if (self.dataMutableArray.count==0&&(!self.dataMutableArray)) {
        row=1;
    }else{
        row=self.dataMutableArray.count;
    }
    return row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataMutableArray.count) {
        CommentModel *commentModel = [self.dataMutableArray objectAtIndex:indexPath.row];
        static NSString *articleyCellIdentifier = @"articleyCellIdentifier";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:articleyCellIdentifier];
        if (cell==nil) {
            cell=[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:articleyCellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.tag=indexPath.row;
            cell.delegate=self;
        }
        tableView.separatorColor=[UIColor red:180.0 green:180.0 blue:180.0 alpha:1.0];
        tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [cell setCommentModel:commentModel];
        return cell;
    }else{
        UITableViewCell *cell;
        static NSString *articleyCellIdentifier0 = @"articleyCellIdentifier0";
        cell=[tableView dequeueReusableCellWithIdentifier:articleyCellIdentifier0];
        if (nil==cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:articleyCellIdentifier0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.textLabel.textColor=[UIColor darkGrayColor];
            cell.textLabel.font=[UIFont systemFontOfSize:16.0];
        }
        tableView.separatorColor=[UIColor clearColor];
        cell.textLabel.text=@"暂时没有评论！";
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataMutableArray.count) {
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=44.0f;
    if (self.dataMutableArray.count) {
        CommentModel *commentModel = [self.dataMutableArray objectAtIndex:indexPath.row];
        height=[CommentCell commentCellHightWithObject:commentModel atIndex:indexPath];
    }
    return height;
}
-(void)hhLoadingViewDidTouchedWithTouchType:(HHLoadingViewTouchType)touchType{
    [self getCommentList];
}

@end
