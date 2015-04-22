//
//  MyCollectViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-18.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "MyCollectViewController.h"
#import "HHDatabaseEngine+News.h"
#import "HHArticleListCell.h"
#import "NewsDetailViewController.h"
@interface MyCollectViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation MyCollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isBackButtonShow=NO;
	// Do any additional setup after loading the view.
    
    self.dataTableView.frame=CGRectMake(0, 0, __gScreenWidth, __gScreenHeight-__gTopViewHeight);
    [self getCollectDataWitPageIndex:self.pageIndex];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refreshData{
    [super refreshData];
    [self getCollectDataWitPageIndex:self.pageIndex];
    
}
-(void)loadMoreData{
    [super loadMoreData];
    [self getCollectDataWitPageIndex:self.pageIndex];
}
-(void)getCollectDataWitPageIndex:(NSInteger)index{
   NSMutableArray *array= [[HHDatabaseEngine sharedDBEngine] getCollectArtictleListWithUserID:[UserModel userID] pageIndex:index pageSize:HHPageSize];
    if (index==1) {
        [self.dataMutableArray removeAllObjects];
        [self.dataMutableArray addObjectsFromArray:array];
    }else{
        [self.dataMutableArray addObject:array];
    }
    if (self.dataMutableArray.count==0) {
         [self.view showLoadingViewWithText:@"您还没有添加收藏，赶紧去看看吧" showImage:nil  delegate:nil touchType:HHLoadingViewTouchTypeNone];
    }
    [self.dataTableView reloadData];
    [self.dataTableView stopRefrshAndInfiniteAnimating];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataMutableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *artictleListCellStr=@"artictleListCellStr";
    HHArticleListCell *cell;
    if (cell==nil) {
        cell=[[HHArticleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:artictleListCellStr];
            //cell.backgroundColor=HHBackgorundColor;
    }
    ArticleModel *model=[self.dataMutableArray objectAtIndex:indexPath.row];
    cell.artictleModel=model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleModel *model=[self.dataMutableArray objectAtIndex:indexPath.row];
    NewsDetailViewController *articleDetail = [[NewsDetailViewController alloc]init];
    articleDetail.artictleID = model.articleID;
    articleDetail.newsDetailType=NewsDetailControlelrTypeForNews;
    [self.navigationController pushViewController:articleDetail animated:YES];
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HHArticleListCell artictleListCellHeightAtIndexPath:indexPath articeleModel:Nil];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{

    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
         ArticleModel *model=[self.dataMutableArray objectAtIndex:indexPath.row];
        BOOL isSuccess=[[HHDatabaseEngine sharedDBEngine]  deleteOneCollectArtictle:model.articleID withUserID:[UserModel userID]];
        if (isSuccess) {
            [self.dataMutableArray removeObject:model];
            [self.dataTableView beginUpdates];
            [self.dataTableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.dataTableView  endUpdates];
            [self getCollectDataWitPageIndex:self.pageIndex];
        }else{
            [self showErrorView:@"删除失败"];
        }
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}
@end
