 //
//  BaseSearchTableViewController.h
//  MoblieCity
//
//  Created by Luigi on 14-8-6.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "BaseTableViewController.h"
@interface BaseSearchTableViewController : BaseTableViewController
/**
 *  是否使用搜索
 */
@property(nonatomic,assign)BOOL enableSearch;



/**
 *  子类要重写这个方法，点击搜索的时候
 *
 *  @param keywords 关键字
 */
-(void)getDataListWithSearchKeywords:(NSString *)keywords;
@end
