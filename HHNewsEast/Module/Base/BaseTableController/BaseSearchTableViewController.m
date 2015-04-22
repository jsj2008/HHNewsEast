    //
    //  BaseSearchTableViewController.m
    //  MoblieCity
    //
    //  Created by Luigi on 14-8-6.
    //  Copyright (c) 2014年 luigi. All rights reserved.
    //

#import "BaseSearchTableViewController.h"
#import "HHSearchViewController.h"
@interface BaseSearchTableViewController ()<HHSearchControllerDelegate>
@property(nonatomic,strong)HHSearchViewController *searchController;
@end

@implementation BaseSearchTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

-(HHSearchViewController *)searchController{
    if (nil==_searchController) {
        _searchController=[[HHSearchViewController alloc]  init];
        _searchController.delegate=self;
        [self.view addSubview:_searchController.view];
    }
    return _searchController;
}
-(void)setEnableSearch:(BOOL)enableSearch{
    self.searchController.searchEnable=enableSearch;
}
-(void)getDataListWithSearchKeywords:(NSString *)keywords{
    
}
#pragma mark- searchController delegate
-(void)searchControllerShouldSearchWithKeyWords:(NSString *)keywords{
    [self getDataListWithSearchKeywords:keywords];
}

@end
