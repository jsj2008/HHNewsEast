//
//  HHContentView.m
//  SeaArticle
//
//  Created by d gl on 14-5-21.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHContentView.h"
#import "HHContentCell.h"
#import "HHNetWorkEngine+News.h"
#import "ArticleModel.h"
#import "HHClassMenuView.h"
#import "HHDatabaseEngine+News.h"
    //static const CGFloat kHeightOfTopScrollView =44.0f;


@interface HHContentView  ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,HHClassMenuViewDelegate>
@property(nonatomic,strong)UITableView      *dataTableView;
@property(nonatomic,strong)HHClassMenuView  *classMenuView;
@end
@implementation HHContentView
@synthesize dataTableView   =_dataTableView;
@synthesize delegate        =_delegate;
@synthesize artictleClassID =_artictleClassID;
@synthesize dataArry        =_dataArry;

@synthesize classMenuView   =_classMenuView;
-(HHClassMenuView *)classMenuView{
    if (_classMenuView==nil) {
        _classMenuView = [[HHClassMenuView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), __gTopViewHeight) andItems:_dataArry];
        [self addSubview:_classMenuView];
        _classMenuView.backgroundColor=HHBackgorundColor;
        _classMenuView.menuDelegate = self;
    }
    return _classMenuView;
}
-(UITableView *)dataTableView{
    if (nil==_dataTableView) {
        _dataTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetHeight(self.bounds)-__gTopViewHeight, CGRectGetWidth(self.bounds))];
        _dataTableView.backgroundColor=HHBackgorundColor;
        _dataTableView.delegate=self;
        _dataTableView.dataSource=self;
        _dataTableView.tableFooterView=[[UIView alloc] init];
        _dataTableView.transform=CGAffineTransformMakeRotation(-M_PI / 2);
         _dataTableView.center = CGPointMake(__gScreenWidth/ 2, ((CGRectGetHeight(self.bounds)-__gTopViewHeight)/2+__gTopViewHeight));
        _dataTableView.pagingEnabled=YES;
        _dataTableView.showsVerticalScrollIndicator=NO;
        _dataTableView.showsHorizontalScrollIndicator=NO;
        [self addSubview:_dataTableView];
    }
    return _dataTableView;
}
-(void)setDataArry:(NSMutableArray *)dataArry{
    _dataArry=dataArry;
    if (_dataArry&&_dataArry.count) {
        self.classMenuView.classDataArry=_dataArry;
        [self.dataTableView reloadData];
    }
}
-(NSString *)artictleClassID{
    NSInteger page = (NSInteger)_dataTableView.contentOffset.y / CGRectGetWidth(self.bounds) ;
    if (_dataArry.count>=page) {
        ArticleClassModel *classMode=[_dataArry objectAtIndex:page];
        return classMode.articleClassID;
    }else{
        return @"";
    }
}

#pragma mark- tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     ArticleClassModel *classModel=[_dataArry objectAtIndex:indexPath.row];
    
    NSString *artictleListCellIdentifer=[HHContentCell contentCellIdentiferWithClassModel:classModel];
    HHContentCell *cell=[tableView dequeueReusableCellWithIdentifier:artictleListCellIdentifer];
    if (nil==cell) {
        cell=[[HHContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:artictleListCellIdentifer];
        cell.transform=CGAffineTransformMakeRotation(M_PI / 2);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
   
    cell.classModel=classModel;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetWidth(self.bounds);
}

#pragma mark- scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pt =   _dataTableView.contentOffset;
    NSInteger page = (NSInteger)pt.y / CGRectGetWidth(self.bounds) ;
    float radio = (float)((NSInteger)pt.y % 320)/320;
    [self.classMenuView setLineOffsetWithPage:page andRatio:radio];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = _dataTableView.contentOffset.y / self.frame.size.width;
    [self.classMenuView selectClassMenuAtIndex:index];
}
#pragma mark-classMenuDelegate
-(void)classMenuSelectIndexChanded:(NSInteger)index classID:(NSString *)classID{
    [_dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
}
@end
