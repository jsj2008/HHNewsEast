//
//  HHContentCell.m
//  SeaArticle
//
//  Created by d gl on 14-5-23.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHContentCell.h"
#import "HHArticleListCell.h"
#import "ArticleModel.h"
#import "HHNetWorkEngine+News.h"
#import "HHFlowView.h"
#import "HHDatabaseEngine+News.h"
#define  HHContentCellNoBaner       @"HHContentCellNoBaner"
#define  HHContentCellArtictleBaner   @"HHContentCellArtictleBaner"


@interface HHContentCell ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *dataTableView;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)HHFlowView *headerFlowView;
@end

@implementation HHContentCell
@synthesize dataTableView       =_dataTableView;
@synthesize   classModel    =_classModel;
@synthesize pageIndex       =_pageIndex;
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+(NSString *)contentCellIdentiferWithClassModel:(ArticleClassModel *)classModel{
    NSString *classArtictleIdentifer=@"classAritictleIdentifer";
    
    NSString*subString=@"";
    if (classModel.artictleBannerArray.count) {
        subString=HHContentCellArtictleBaner;
    }else{
        subString=HHContentCellNoBaner;
    }
    classArtictleIdentifer=[classArtictleIdentifer stringByAppendingString:subString];
    return classArtictleIdentifer;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _pageIndex=1;
        _dataTableView=    self.dataTableView;
        [[NSNotificationCenter defaultCenter] addObserverForName:HHKoreaArtictle_Notification_CommentCountChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"_articleArticleid=%@",note.object];
            NSArray *tempArry=[_classModel.artictleListArry filteredArrayUsingPredicate:predicate];
            if (tempArry&&tempArry.count) {
                ArticleModel *artictleModel=[tempArry objectAtIndex:0];
                artictleModel.articleCommentCount=[NSString stringWithFormat:@"%d",(artictleModel.articleCommentCount.integerValue+1)];
                NSInteger index=[_classModel.artictleListArry indexOfObject:artictleModel];
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:HHKoreaArtictle_Notification_VisitCountChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"_articleArticleid=%@",note.object];
            NSArray *tempArry=[_classModel.artictleListArry filteredArrayUsingPredicate:predicate];
            if (tempArry&&tempArry.count) {
                ArticleModel *artictleModel=[tempArry objectAtIndex:0];
                artictleModel.articleVisitNum=[NSString stringWithFormat:@"%d",(artictleModel.articleVisitNum.integerValue+1)];
                NSInteger index=[_classModel.artictleListArry indexOfObject:artictleModel];
                [_dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:HHKoreaArtictle_Notification_SearchedText object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            _pageIndex=1;
            [self getArticleListWithArticleClassID:_classModel.articleClassID pageIndex:self.pageIndex  searchtype:@"1" searchText:note.object pageorder:@"1"];
            
        }];
        if ([reuseIdentifier rangeOfString:HHContentCellArtictleBaner].length) {
            if (_classModel.artictleBannerArray.count) {
                self.dataTableView.tableHeaderView=self.headerFlowView;

            }else{
                _dataTableView.tableHeaderView=nil;
            }
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(HHFlowView *)headerFlowView{
    if (nil==_headerFlowView) {
        _headerFlowView=[[HHFlowView alloc]  initWithFrame:CGRectMake(0, 0, __gScreenWidth, 150)];
       // __weak HHContentCell *weakSelf=self;
        _headerFlowView.flowViewDidSelectedBlock=^(HHFlowModel *flowMode, NSInteger index){
            [[NSNotificationCenter defaultCenter]  postNotificationName:HHkoreaArtictle_Notification_SelectArtictle object:flowMode.flowSourceUrl];
        };
    }
    return _headerFlowView;
}
-(UITableView *)dataTableView{
    if (nil==_dataTableView) {
        _dataTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , __gScreenWidth, __gScreenHeight-__gTopViewHeight)];
        _dataTableView.backgroundColor=HHBackgorundColor;
        _dataTableView.delegate=self;
        _dataTableView.dataSource=self;
        _dataTableView.tableFooterView=[[UIView alloc] init];
        [self.contentView addSubview:_dataTableView];
        __weak HHContentCell *weakSelf=self;
        [_dataTableView addPullToRefreshWithActionHandler:^{
            //[weakSelf getArticleListWithArticleClassID:weakSelf.classModel.articleClassID pageIndex:weakSelf.pageIndex  searchtype:@"" searchText:@"" pageorder:@""];
            [weakSelf refrashData];
        }];
        [_dataTableView addInfiniteScrollingWithActionHandler:^{
            [weakSelf loadModeData];
        }];
        _dataTableView.infiniteScrollingView.enabled=NO;
    }
    return _dataTableView;
}
-(void)setClassModel:(ArticleClassModel *)classModel{
    _classModel=classModel;
    if (_pageIndex==1) {
        if (_classModel.artictleBannerArray.count) {
            self.dataTableView.tableHeaderView=self.headerFlowView;
            self.headerFlowView.dataArry=_classModel.artictleBannerArray;
        }else{
            self.dataTableView.tableHeaderView=nil;
            
        }
    }
    
    if ((_classModel.artictleListArry==nil)||(_classModel.artictleListArry.count==0)) {
        [self getArticleListWithArticleClassID:_classModel.articleClassID pageIndex:_pageIndex  searchtype:@"" searchText:@"" pageorder:@"1"];
    }else{
    }
    [self.dataTableView reloadData];

}

-(void)refrashData{
    _pageIndex=1;
    [self getArticleListWithArticleClassID:_classModel.articleClassID pageIndex:self.pageIndex  searchtype:@"" searchText:@"" pageorder:@"1"];
}
-(void)loadModeData{
    _pageIndex++;
    [self getArticleListWithArticleClassID:_classModel.articleClassID pageIndex:self.pageIndex  searchtype:@"" searchText:@"" pageorder:@"1"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _classModel.artictleListArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *artictleListCellStr=@"artictleListCellStr";
    HHArticleListCell *cell;
    if (cell==nil) {
        cell=[[HHArticleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:artictleListCellStr];
        //cell.backgroundColor=HHBackgorundColor;
    }
    ArticleModel *model=[_classModel.artictleListArry objectAtIndex:indexPath.row];
    cell.artictleModel=model;
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HHArticleListCell artictleListCellHeightAtIndexPath:indexPath articeleModel:Nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    ArticleModel *model=[_classModel.artictleListArry objectAtIndex:indexPath.row];
    model.isRead=YES;
    HHArticleListCell *cell=(HHArticleListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.artictleModel=model;
    [notificationCenter postNotificationName:HHkoreaArtictle_Notification_SelectArtictle object:model.articleID];
}
#pragma mark  -获取文章列表
-(void)getArticleListWithArticleClassID:(NSString *)articleid pageIndex:(NSInteger)pageIndex searchtype:(NSString *)searchType searchText:(NSString *)searchText pageorder:(NSString *)pageOrder{
    if (pageIndex==1&&((_classModel.artictleListArry==nil)||(_classModel.artictleListArry.count==0))) {
     //  NSMutableArray *newsArry= [[HHDatabaseEngine sharedDBEngine]  getNewsListFromDBWithClassID:_classModel.articleClassID];
        NSMutableArray *newsArry;
        [self showLoadingViewWithText:HHLoadWaitMessage animationImages:HHLoadWaitAnimationImages animationDuration:HHLoadWaitAnimationDuration];
        if ((newsArry&&newsArry.count)||_classModel.artictleBannerArray.count) {
              [self hideLoadingView];
            _classModel.artictleListArry=newsArry;
              [_dataTableView reloadData];
        }
    }
    
    [[HHNetWorkEngine sharedHHNetWorkEngine] getNewsListWithClassID:articleid pageIndex:_pageIndex pageSize:HHPageSize OnCompletionHandler:^(HHResponseResult *responseResult) {
        [self hideLoadingView];
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            NSMutableArray *newsListArray=[responseResult.responseData objectForKey:@"newslist"];
            NSMutableArray *bannerArray=[responseResult.responseData objectForKey:@"banner"];
            if (pageIndex==1) {
                if (bannerArray.count) {
                    [_classModel.artictleBannerArray removeAllObjects];
                    [_classModel.artictleBannerArray addObjectsFromArray:bannerArray];
                    if (_classModel.artictleBannerArray.count) {
                        self.dataTableView.tableHeaderView=self.headerFlowView;
                        self.headerFlowView.dataArry=_classModel.artictleBannerArray;
                    }else{
                        self.dataTableView.tableHeaderView=nil;
                        
                    }
                }
                [_classModel.artictleListArry removeAllObjects];
            }
            if (newsListArray.count==HHPageSize) {
                _dataTableView.infiniteScrollingView.enabled=YES;
            }else{
                _dataTableView.infiniteScrollingView.enabled=NO;
            }
            [_classModel.artictleListArry addObjectsFromArray:newsListArray];
            [self.dataTableView reloadData];
        }else{
            if (_classModel.artictleListArry.count) {
                
                [SVProgressHUD showErrorWithStatus:@"暂时没有更多数据"];
            }else{
                _classModel.artictleListArry=[[HHDatabaseEngine sharedDBEngine]  getNewsListFromDBWithClassID:articleid];
                if (_classModel.artictleBannerArray.count==0&&_classModel.artictleListArry.count==0) {
                     [self showLoadingViewWithText:responseResult.responseMessage showImage:HHLoadFailedImage delegate:nil touchType:HHLoadingViewTouchTypeBackgroundView];
                }else{
                    [self.dataTableView reloadData];
                }
            }
        }
        [self.dataTableView stopRefrshAndInfiniteAnimating];
    } onErrorHandler:^(NSError *error) {
        if (_classModel.artictleListArry.count) {
            [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        }else{
            _classModel.artictleListArry=[[HHDatabaseEngine sharedDBEngine]  getNewsListFromDBWithClassID:articleid];
            if (_classModel.artictleBannerArray.count==0&&_classModel.artictleListArry.count==0) {
                [self showLoadingViewWithText:HHLoadFailedMessage showImage:HHLoadFailedImage delegate:self touchType:HHLoadingViewTouchTypeBackgroundView];
            }else{
                [self.dataTableView reloadData];
            }
        }
         [self.dataTableView stopRefrshAndInfiniteAnimating];
    }];
}
#pragma mark- Loadingview delegate
-(void)hhLoadingViewDidTouchedWithTouchType:(HHLoadingViewTouchType)touchType{
    if (touchType==HHLoadingViewTouchTypeBackgroundView) {
        [self getArticleListWithArticleClassID:_classModel.articleClassID pageIndex:_pageIndex  searchtype:@"" searchText:@"" pageorder:@"1"];
    }
   
}
-(void)reloadCellWithNotificiation:(NSNotification *)note{
    
}
@end
