//
//  BaseTableViewController.h
//  MoblieCity
//
//  Created by d gl on 14-6-30.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
/**
 *  用到的tableview，已经添加到了contentView上了
 */
@property(nonatomic,strong)HHTableView *dataTableView;
/**
 *  初始化init的时候设置tableView的样式才有效
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
/**
 *  tableview 用到的数据源
 */
@property(nonatomic,strong)NSMutableArray *dataMutableArray;
/**
 *  用到分页中的当前第几页,默认pageIndex=1
 */
@property(nonatomic,assign)NSUInteger pageIndex;
/**
 *  如果是多个分组的话，则设置这个分组的个数；默认是1个分区
 */
@property(nonatomic,assign)NSInteger sectionCount;
/**
 *  是否支持下拉刷新
 */
@property(nonatomic,assign)BOOL enableRefreshData;
/**
 *  下拉刷新
 */
-(void)refreshData;

/**
 *  加载更多
 */
-(void)loadMoreData;
/**
 *  scrollview Stop Anination
 */
-(void)stopRefrashingAndReloadingWithScrollView:(UIScrollView *)svTableView;
@end
