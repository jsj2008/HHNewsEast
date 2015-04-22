//
//  BaseTableViewController.m
//  MoblieCity
//
//  Created by d gl on 14-6-30.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "BaseTableViewController.h"
@interface BaseTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataSourceArray;

@end

@implementation BaseTableViewController
-(void)dealloc{
    @try {
        [self removeObserver:self forKeyPath:@"dataSourceArray"];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    if (_enableRefreshData) {
        [self addObserver:self forKeyPath:@"dataSourceArray" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    @try {
        [self removeObserver:self forKeyPath:@"dataSourceArray"];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataTableView=self.dataTableView;
    _pageIndex=1;
    self.sectionCount=1;
    self.enableRefreshData=YES;
   
        // UISearchDisplayController
}
-(HHTableView *)dataTableView{
    if (nil==_dataTableView) {
        if (self.navigationController.navigationBarHidden) {
                  _dataTableView=[[HHTableView alloc] initWithFrame:CGRectMake(0, __gOffY, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-__gOffY) dataSource:self delegate:self style:self.tableViewStyle];
        }else{
                _dataTableView=[[HHTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-__gTopViewHeight) dataSource:self delegate:self style:self.tableViewStyle];
        }

        WEAKSELF;
        [_dataTableView addPullToRefreshWithActionHandler:^{
            [weakSelf refreshData];
        }];
        [_dataTableView addInfiniteScrollingWithActionHandler:^{
            [weakSelf loadMoreData];
        }];
       _dataTableView.infiniteScrollingView.enabled=NO;
        [self.view addSubview:_dataTableView];
    }
    return _dataTableView;
}

-(void)refreshData{
    _pageIndex=1;
}
-(void)loadMoreData{
    _pageIndex++;
}
-(NSMutableArray *)dataMutableArray{
    if (nil==_dataSourceArray) {
        _dataSourceArray=[[NSMutableArray alloc] init];
    }
    return [self mutableArrayValueForKey:@"dataSourceArray"];
}
-(void)setDataMutableArray:(NSMutableArray *)dataMutableArray{
    if (nil==_dataSourceArray) {
        _dataSourceArray=[[NSMutableArray alloc] init];
    }
    _dataSourceArray=dataMutableArray;
}
-(void)insertObject:(id )object inDataSourceArrayAtIndex:(NSUInteger)index{
    [self.dataSourceArray insertObject:object atIndex:index];
}
-(void)removeObjectFromDataSourceArrayAtIndex:(NSUInteger)index{
    [self.dataSourceArray removeObjectAtIndex:index];
}
-(void)replaceObjectInDataSourceArrayAtIndex:(NSUInteger)index withObject:(id)object{
    [self.dataSourceArray replaceObjectAtIndex:index withObject:object];
}
-(void)setEnableRefreshData:(BOOL)enableRefreshData{
    self.dataTableView.showsPullToRefresh=enableRefreshData;
    self.dataTableView.infiniteScrollingView.enabled=NO;
    if (enableRefreshData) {
       [self addObserver:self forKeyPath:@"dataSourceArray" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }else{
        @try {
            [self removeObserver:self forKeyPath:@"dataSourceArray"];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
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

#pragma mark- tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *baseCellIdentifer=@"baseCellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:baseCellIdentifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseCellIdentifer];
    }
    return cell;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"dataSourceArray"]) {
        if (_dataSourceArray&&_dataSourceArray.count) {
            if (self.dataMutableArray.count%HHPageSize) {//stop load more
                self.dataTableView.infiniteScrollingView.enabled=NO;
            }else{//
                if (self.dataMutableArray.count<HHPageSize*self.pageIndex) {//上一页刚好够，下一页没有数据
                    self.pageIndex--;
                     self.dataTableView.infiniteScrollingView.enabled=NO;
                }else if(self.dataMutableArray.count==HHPageSize*self.pageIndex){//刚好够，则支持下拉刷新
                    self.dataTableView.infiniteScrollingView.enabled=YES;
                }else{//禁止下拉刷新
                     self.dataTableView.infiniteScrollingView.enabled=NO;
                }
            }
                // [self.dataTableView stopRefrshAndInfiniteAnimating];//stop refrashing and reloading
        }else{
            self.pageIndex=1;
        }
    }
}
@end
