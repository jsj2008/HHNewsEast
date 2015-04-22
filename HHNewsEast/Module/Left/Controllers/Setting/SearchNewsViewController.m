//
//  SearchNewsViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-22.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "SearchNewsViewController.h"
#import "HHArticleListCell.h"
#import "HHNetWorkEngine+News.h"
@interface SearchNewsViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)    UISearchBar *searchBar;
@end

@implementation SearchNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
}
-(void)setNavigationBar{
    [[UINavigationBar appearance]  setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    self.navigationController.navigationBarHidden=NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBar];
	// Do any additional setup after loading the view.
    self.dataTableView.frame=CGRectMake(0, 0, __gScreenWidth, __gScreenHeight-__gTopViewHeight);
    HHImageView *searchImageView=[[HHImageView alloc]initWithFrame:CGRectMake(0, 0, __gScreenWidth, 40)];
    searchImageView.tag=100;
    searchImageView.layer.cornerRadius=3.0;
    searchImageView.layer.masksToBounds=YES;
    searchImageView.userInteractionEnabled=YES;
    searchImageView.image=[UIImage imageNamed:@"bg_search_img"];

    _searchBar=[[UISearchBar alloc]initWithFrame:searchImageView.bounds];
    _searchBar.text=@"";
    _searchBar.delegate=self;
    _searchBar.tag=30;
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"bg_search_img"]];
    [searchImageView addSubview:_searchBar];
    //self.enableSearch=YES;
    self.enableRefreshData=YES;
    self.dataTableView.tableHeaderView=searchImageView;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getDataListWithSearchKeywords:(NSString *)keywords{
    _searchBar.text=keywords;
[self searchNewsByKeys:keywords pageIndex:self.pageIndex pageSize:HHPageSize];
}
-(void)refreshData{
    self.pageIndex=1;
     [self searchNewsByKeys:_searchBar.text pageIndex:self.pageIndex pageSize:HHPageSize];
    //[self getArticleListWithArticleClassID:_classModel.articleClassID pageIndex:self.pageIndex  searchtype:@"" searchText:@"" pageorder:@"1"];
}
-(void)loadMoreData{
    self.pageIndex++;
    [self searchNewsByKeys:_searchBar.text pageIndex:self.pageIndex pageSize:HHPageSize];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
             [self searchNewsByKeys:_searchBar.text pageIndex:self.pageIndex pageSize:HHPageSize];
   // [self getServiceItemListWithPageIndex:self.pageIndex keyWord:searchBar.text classID:_itemModel.itemID];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
   // self.enableSearch=YES;
    return YES;
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
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HHArticleListCell artictleListCellHeightAtIndexPath:indexPath articeleModel:Nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    ArticleModel *model=[self.dataMutableArray objectAtIndex:indexPath.row];
    [notificationCenter postNotificationName:HHkoreaArtictle_Notification_SelectArtictle object:model.articleID];
}
#pragma mark  -获取文章列表
-(void)searchNewsByKeys:(NSString *)key pageIndex:(NSInteger)pid pageSize:(NSInteger)pageSize{
    if (self.dataMutableArray.count==0) {
        [self.view showLoadingViewWithText:HHLoadWaitMessage animationImages:HHLoadWaitAnimationImages animationDuration:HHLoadWaitAnimationDuration];
    }
    
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine] searchNewsWithKeys:key pageIndex:pid pageSize:pageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        [self.view hideLoadingView];
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            NSMutableArray *newsListArray=responseResult.responseData;
           // NSMutableArray *bannerArray=[responseResult.responseData objectForKey:@"banner"];
            if (pid==1) {
                [self.dataMutableArray removeAllObjects];
            }
            if (newsListArray.count==HHPageSize) {
                self.dataTableView.infiniteScrollingView.enabled=YES;
            }else{
                self.dataTableView.infiniteScrollingView.enabled=NO;
            }
            [self.dataMutableArray addObjectsFromArray:newsListArray];
            [self.dataTableView reloadData];
        }else{
            if (self.dataMutableArray.count) {
                [SVProgressHUD showErrorWithStatus:@"暂时没有更多数据"];
            }else{
                [self.view showLoadingViewWithText:responseResult.responseMessage showImage:HHLoadFailedImage delegate:self touchType:HHLoadingViewTouchTypeBackgroundView];
            }
        }
        [self.dataTableView stopRefrshAndInfiniteAnimating];
    } onErrorHandler:^(NSError *error) {
        if (self.dataMutableArray.count) {
            [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        }else{
           
            [self.view showLoadingViewWithText:HHLoadFailedMessage showImage:HHLoadFailedImage delegate:self touchType:HHLoadingViewTouchTypeBackgroundView];}
    }];
     [self.dataTableView stopRefrshAndInfiniteAnimating];
}

#pragma mark- Loadingview delegate
-(void)hhLoadingViewDidTouchedWithTouchType:(HHLoadingViewTouchType)touchType{
        [self searchNewsByKeys:_searchBar.text pageIndex:self.pageIndex pageSize:HHPageSize];
    //[self getArticleListWithArticleClassID:_classModel.articleClassID pageIndex:_pageIndex  searchtype:@"" searchText:@"" pageorder:@"1"];
}

@end
