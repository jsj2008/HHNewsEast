    //
    //  NewsDetailViewController.m
    //  HHNewsEast
    //
    //  Created by Luigi on 14-7-31.
    //  Copyright (c) 2014年 Luigi. All rights reserved.
    //

#import "NewsDetailViewController.h"
#import "HHNetWorkEngine+News.h"
#import "ArticleModel.h"
#import "ArtictleCommentViewController.h"
#import "HHDatabaseEngine+News.h"
#import "HHShaeTool.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "LoginViewController.h"

#import "GUIPlayerView.h"

#import "HHAppDelegate.h"
@interface NewsDetailViewController ()<UIWebViewDelegate,HHLoadingViewDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,CommentCellDelegate,GUIPlayerViewDelegate>
@property(nonatomic,strong)HHWebView *detailWebView;
@property(nonatomic,strong)ArticleModel *artictleModel;
@property(nonatomic,strong)UITableView *detailTableView;
@property(nonatomic,strong)NSMutableArray *commentListArray;

@property(nonatomic,strong)GUIPlayerView *playerView;
@end

@implementation NewsDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
        self.newsDetailType=NewsDetailControlelrTypeForNews;
    }
    return self;
}


-(GUIPlayerView *)playerView{
    if (nil==_playerView) {
        _playerView=[[GUIPlayerView alloc]  initWithFrame:CGRectMake(0, __gTopViewHeight, __gScreenWidth, __gScreenWidth* 9.0f / 16.0f)];
        _playerView.delegate=self;
        [self.view addSubview:_playerView];
        
    }
    return _playerView;
}

-(void)startPlayWithUrl:(NSString *)urlString{
    [self.playerView setVideoURL:[NSURL URLWithString:urlString]];
    [_playerView prepareAndPlayAutomatically:YES];
}
-(void)stopPlay{
    [self.playerView clean];
}

#pragma mark - GUI Player View Delegate Methods

- (void)playerWillEnterFullscreen {
    [[self navigationController] setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)playerWillLeaveFullscreen {
    [[self navigationController] setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)playerDidEndPlaying {
  //  [copyrightLabel setHidden:YES];
    
    [self.playerView clean];
    [self.playerView removeFromSuperview];
    self.playerView=nil;
}

- (void)playerFailedToPlayToEnd {
    NSLog(@"Error: could not play video");
    [self.playerView clean];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    [self onInitData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
  return UIInterfaceOrientationMaskAllButUpsideDown;  
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


-(void)onInitData{
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
        //self.navigationController.navigationBarHidden=YES;
    [self.view addSubview:self.detailTableView];
    self.navigationController.navigationBarHidden=YES;
    self.isBackButtonShow=YES;
    [self enablSwipGestureOnView:self.detailWebView];
    
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vedioStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];// 播放器即将播放通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vedioFinished:) name:@"UIMoviePlayerControllerWillExitFullscreenNotification" object:nil];// 播放器即将退出通知
    */
    [self loadData];
}
/*
- (void)vedioStarted:(NSNotification *)notification {// 播放器即将播放处理
    [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft]];// iOS6只能选择一个横屏方向，暂时实现不了检测屏幕旋转而旋转

}
- (void)vedioFinished:(NSNotification *)notification {// 视频
    [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:[NSNumber numberWithInteger:UIDeviceOrientationPortrait]];// 屏幕方向回复默认的竖屏
}
 */
-(void)loadData{
    if (_newsDetailType==NewsDetailControlelrTypeForNews) {
        self.enableRightView=YES;
        self.enableCollect=YES;
        self.enableComment=YES;
        self.enableShare=YES;
        [self getNewsCommentsListWithArtictleID:_artictleID];
        [self getArtictleDetailWithArtictleID:_artictleID];
    }else if (_newsDetailType==NewsDetailControlelrTypeForBanner){
        [self.view showLoadingViewWithText:HHLoadWaitMessage loadingAnimated:YES delegate:nil];
        [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_bannerUrl]]];
    }
    
}
-(UITableView *)detailTableView{
    if (nil==_detailTableView) {
        _detailTableView=[[UITableView alloc]  initWithFrame:CGRectMake(0, __gOffY, __gScreenWidth, __gScreenHeight-__gOffY) style:UITableViewStylePlain];
        _detailTableView.delegate=self;
        _detailTableView.dataSource=self;
        _detailTableView.backgroundColor=[UIColor clearColor];
            //        _detailTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            // _detailTableView.tableHeaderView=self.detailWebView;
        _detailTableView.tableFooterView=[[UIView alloc]  init];
    }
    return _detailTableView;
}
-(HHWebView *)detailWebView{
    if (nil==_detailWebView) {
        _detailWebView=[[HHWebView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-__gOffY) delegate:self];
        _detailWebView.scrollView.showsVerticalScrollIndicator=YES;
        _detailWebView.scrollView.showsHorizontalScrollIndicator=NO;
        _detailWebView.delegate=self;
        _detailWebView.allowsInlineMediaPlayback=YES;
        _detailWebView.mediaPlaybackRequiresUserAction=NO;
        _detailWebView.scrollView.delegate=self;
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlerPanRecognizer:)];
        [panRecognizer setMinimumNumberOfTouches:2];
        [panRecognizer setMaximumNumberOfTouches:2];
        [panRecognizer setDelegate:self];
        [_detailWebView addGestureRecognizer:panRecognizer];
    }
    return _detailWebView;
}
-(void)handlerPanRecognizer:(UIPanGestureRecognizer *)gesture{
    
}
-(void)getArtictleDetailWithArtictleID:(NSString *)arctID{
    [self.view showLoadingViewWithText:HHLoadWaitMessage loadingAnimated:YES delegate:nil];
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getArticleDetail:arctID onCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            self.artictleModel=responseResult.responseData;
            NSString *htmlString=[ self.artictleModel htmlString];
            NSString *path=[[NSBundle mainBundle] bundlePath];
            [self.detailWebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:path]];
        }else{
            
            [self.view showLoadingViewWithText:responseResult.responseMessage showImage:HHLoadFailedImage delegate:nil touchType:HHLoadingViewTouchTypeNone];
            self.isBackButtonShow=YES;
        }
    } onErrorHandler:^(NSError *error) {
        [self.view showLoadingViewWithText:HHLoadFailedMessage showImage:HHLoadFailedImage delegate:self touchType:HHLoadingViewTouchTypeNone];
        self.isBackButtonShow=YES;
    }];
}
-(void)getNewsCommentsListWithArtictleID:(NSString *)artictleID{
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getCommentListwithpageIndex:1 articleid:artictleID onCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            if (nil==_commentListArray) {
                _commentListArray=[[NSMutableArray alloc]  init];
            }
            [_commentListArray addObjectsFromArray:responseResult.responseData];
            [self.detailTableView reloadData];
        }else{
            
        }
    } onErrorHandler:^(NSError *error) {
        
    }];
}
-(void)hhLoadingViewDidTouchedWithTouchType:(HHLoadingViewTouchType)touchType{
    if (touchType==HHLoadingViewTouchTypeBackgroundView) {
        [self loadData];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row=0;
    if (_commentListArray.count>0) {
        if (_commentListArray.count>5) {
            row=5+1;
        }else{
            row=_commentListArray.count+1;
        }
    }else{
        row=0;
    }
    return row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0&&_commentListArray.count) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellIdentifer0"];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifer0"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.textLabel.textAlignment=NSTextAlignmentLeft;
            cell.textLabel.textColor=[UIColor darkGrayColor];
            cell.textLabel.text=@"热门评论";
        }
        return cell;
    }else{
        CommentModel *commentModel = [_commentListArray objectAtIndex:(indexPath.row-1)];
        static NSString *articleyCellIdentifier = @"articleyCellIdentifier09";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:articleyCellIdentifier];
        if (cell==nil) {
            cell=[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:articleyCellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor red:240 green:240 blue:240 alpha:1.0];
            cell.tag=indexPath.row;
            cell.delegate=self;
        }
    
    tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            //    tableView.separatorColor=[UIColor red:180.0 green:180.0 blue:180.0 alpha:1.0];
            //    tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [cell setCommentModel:commentModel];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    if (indexPath.row==0) {
        height=25;
    }else{
        if (_commentListArray.count) {
            CommentModel *commentModel = [_commentListArray objectAtIndex:(indexPath.row-1)];
            height=[CommentCell commentCellHightWithObject:commentModel atIndex:indexPath];
        }
    }
    return height;
}
#pragma mark -点赞
-(void)commentCellDidFavorButtonPressedWithComemntModel:(CommentModel *)comentModel{
    [self showWaitView:@"请稍后..."];
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  favorComemntWithCommentID:comentModel.commentId onCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            [self showSuccessView:@"点赞成功"];
            comentModel.isFavored=YES;
            comentModel.commentFavorNum=responseResult.responseData;
            NSInteger index=[_commentListArray indexOfObject:comentModel];
            [self.detailTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:(index+1) inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [self showErrorView:responseResult.responseMessage];
        }
    } onErrorHandler:^(NSError *error) {
        [self showErrorView:@"网络连接错误"];
    }];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    /*
    NSString *urlString=[[request URL] absoluteString];
    if ([urlString hasPrefix:@"HuaRenNewVideo"]) {
        urlString=[urlString stringByReplacingOccurrencesOfString:@"HuaRenNewVideo" withString:@""];
        [self startPlayWithUrl:urlString];
    }
     */
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view showLoadingViewWithText:HHLoadFailedMessage showImage:HHLoadFailedImage delegate:nil touchType:HHLoadingViewTouchTypeNone];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
        //获取webview的实际高度
    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"] floatValue];
    CGRect frame=webView.frame;
    frame.size.height=documentHeight;
    webView.frame=frame;
    self.detailTableView.tableHeaderView=webView;
    [self.view hideLoadingView];
}
-(void)didCommentButtonPressed{
    ArtictleCommentViewController *artictleCommetnViewController=[[ArtictleCommentViewController alloc]  init];
    
    artictleCommetnViewController.navigationItem.title=@"新闻评论";
    artictleCommetnViewController.artictleID=self.artictleID;
    [self.navigationController pushViewController:artictleCommetnViewController animated:YES];
}
-(void)didCollectButtonPressed{
    if (self.artictleModel) {
        if ([UserModel isLogin]) {
            BOOL isSuccess=[[HHDatabaseEngine sharedDBEngine]  addCollectWithNewsModel:self.artictleModel withUserID:[UserModel userID]];
            if (isSuccess) {
                [self showSuccessView:@"收藏成功"];
            }else{
                [self showErrorView:@"收藏失败"];
            }
        }else{
            LoginViewController *loginController=[[LoginViewController alloc]  init];
            [self.navigationController pushViewController:loginController animated:YES];
        }
    }
}
-(void)didShareButtonPressed{
    [self hideWaitView];
    if (![SVProgressHUD isVisible]) {
        UIImage *img=[[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:[HHGlobalVarTool fullNewsImagePath:[NSString stringByReplaceNullString:self.artictleModel.articleImage]]];
        if (!img) {
            img=[UIImage imageNamed:@"icon"];
        }
        [[HHShaeTool sharedHHShareTool] shareOnController:self withTitle:self.artictleModel.articleTitle text:self.artictleModel.articleContent image:img url:nil shareType:0 itemID:nil onCompletionHander:^(HHShareResultState state) {
            
        }];
    }
}
@end
