//
//  HHSearchViewController.m
//  MoblieCity
//
//  Created by Luigi on 14-8-7.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "HHSearchViewController.h"
#define kSearchHistoryListKey       @"kSearchHistoryListKey"
@interface HHSearchViewController ()<UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
/**
 *  tableview 用到的数据源
 */
@property(nonatomic,strong)NSMutableArray *dataMutableArray;
/**
 *  搜索框;需要重新设定fram,添加到controller 中
 */
@property (nonatomic, strong) UISearchBar *aSearchBar;
/**
 *  搜索框绑定的控制器
 */
@property (nonatomic,strong) UISearchDisplayController *searchController;
@end

@implementation HHSearchViewController


-(void)dealloc{
    DLog(@"---------HHSearchViewController  is dealooc");
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
  [self.searchController.searchBar becomeFirstResponder];
    self.searchController.searchBar.text=@"";
}
-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController.navigationBar addSubview:self.aSearchBar];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}
- (UISearchBar *)aSearchBar {
    if (!_aSearchBar) {
        _aSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, __gOffY, CGRectGetWidth(self.view.bounds), 44.0)];
        _aSearchBar.barTintColor=[UIColor red:253.0 green:150.0 blue:44.0 alpha:1];
            // _aSearchBar.backgroundColor=[UIColor red:253.0 green:150.0 blue:44.0 alpha:1];
        _aSearchBar.delegate = self;
        _aSearchBar.placeholder=[NSString stringByReplaceNullString:self.searchPlaceholder];
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_aSearchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsDelegate = self;
        _searchController.searchResultsDataSource = self;
        
    }
    return _aSearchBar;
}
-(NSMutableArray *)dataMutableArray{
    if (nil==_dataMutableArray) {
        _dataMutableArray=[[NSMutableArray alloc]  init];
    }
    return _dataMutableArray;
}
-(void)setSearchEnable:(BOOL)searchEnable{
    _searchEnable=searchEnable;
    self.view.hidden=!searchEnable;
    if (_searchEnable) {
        [self.searchController.searchBar becomeFirstResponder];
        self.searchController.searchBar.text=@"";
    }else{
        [self.searchController.searchBar resignFirstResponder];
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }
    
     [_searchController setActive:searchEnable animated:YES];
    
}
#pragma mark-tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataMutableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
        static NSString *cacheCellIdentifer=@"cacheCellIdentifer";
        cell=[tableView dequeueReusableCellWithIdentifier:cacheCellIdentifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cacheCellIdentifer];
            cell.textLabel.font=[UIFont systemFontOfSize:14.0];
            cell.textLabel.textColor=[UIColor darkGrayColor];
            cell.textLabel.textAlignment=NSTextAlignmentLeft;
        }
        NSString *text=[self.dataMutableArray objectAtIndex:indexPath.row];
        cell.textLabel.text=text;
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       NSString *text=[self.dataMutableArray objectAtIndex:indexPath.row];
    if (_delegate&&[_delegate respondsToSelector:@selector(searchControllerShouldSearchWithKeyWords:)]) {
        [_delegate searchControllerShouldSearchWithKeyWords:text];
    }
    self.searchEnable=NO;
}
#pragma mark- delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (_delegate&&[_delegate respondsToSelector:@selector(searchControllerShouldSearchWithKeyWords:)]) {
        [_delegate searchControllerShouldSearchWithKeyWords:_aSearchBar.text];
    }
    [self addSearchKeyWords:searchBar.text];
    self.searchEnable=NO;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.dataMutableArray=[self filterSearchResultWithSearchString:searchText];
}
#pragma mark- search displaycontroler
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{

}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    self.searchEnable=NO;
        // [self.topView sendSubviewToBack:self.aSearchBar];
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView{
  self.dataMutableArray=[self filterSearchResultWithSearchString:@""];
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView{
     self.searchEnable=NO;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    return YES;
}

#pragma mark- searchKeysCache
-(void)addSearchKeyWords:(NSString *)keyWords{
    [self.dataMutableArray addObject:keyWords];
    [[NSUserDefaults standardUserDefaults]  setObject:self.dataMutableArray forKey:kSearchHistoryListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)clearSearchListCache{
    NSMutableArray *array= [[NSUserDefaults standardUserDefaults] objectForKey:kSearchHistoryListKey];
    [array removeAllObjects];
}
-(NSMutableArray *)filterSearchResultWithSearchString:(NSString *)searchString{
    if (nil==_dataMutableArray) {
        NSMutableArray *array= [[NSUserDefaults standardUserDefaults] objectForKey:kSearchHistoryListKey];
        [self.dataMutableArray addObjectsFromArray:array];
    }
    return self.dataMutableArray;
}
@end
