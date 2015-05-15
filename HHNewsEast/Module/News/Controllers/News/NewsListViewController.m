//
//  NewsListViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-7-31.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "NewsListViewController.h"
#import "XHDrawerController.h"
#import "HHNetWorkEngine+News.h"
#import "HHContentView.h"
#import "HHDatabaseEngine+News.h"
#import "NewsDetailViewController.h"
@interface NewsListViewController ()
@property(nonatomic,strong)HHContentView *contentView;
@property(nonatomic,strong)UIImageView *bgImageView;
@end

@implementation NewsListViewController
@synthesize contentView =_contentView;
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self onInitData];
        // Do any additional setup after loading the view.
}
-(void)onInitData{
//    _bgImageView=[[UIImageView alloc]  initWithFrame:self.view.bounds];
//    _bgImageView.image=[UIImage imageNamed:@"Default-568h"];
//    [self.view addSubview:_bgImageView];
    self.navigationController.navigationBar.tintColor=HHBackgorundColor;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.contentView];
    [self getArtictleClassList];
   
        //点击文章，跳转到文章的详情通知
    [[NSNotificationCenter defaultCenter] addObserverForName:HHkoreaArtictle_Notification_SelectArtictle object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NewsDetailViewController *articleDetail = [[NewsDetailViewController alloc]init];
            articleDetail.artictleID = note.object;
        articleDetail.newsDetailType=NewsDetailControlelrTypeForNews;
            [self.navigationController pushViewController:articleDetail animated:YES];
        
    }];
    //点击广告跳转到详情
    [[NSNotificationCenter defaultCenter]  addObserverForName:HHkoreaArtictle_Notification_SelectBanner object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        NSString *sourceUrl=note.object;
        NewsDetailViewController *articleDetail = [[NewsDetailViewController alloc]init];
        articleDetail.bannerUrl =sourceUrl;
        articleDetail.newsDetailType=NewsDetailControlelrTypeForBanner;
        [self.navigationController pushViewController:articleDetail animated:YES];
    }];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:HHNotification_ClassView_LefButtonPressed object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
       [self.drawerController toggleDrawerSide:XHDrawerSideLeft animated:YES completion:NULL];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:HHNotification_ClassView_RightButtonPressed object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            // [self.drawerController toggleDrawerSide:XHDrawerSideLeft animated:YES completion:NULL];
    }];
}

-(HHContentView *)contentView{
    if (nil==_contentView) {
        _contentView=[[HHContentView alloc]  initWithFrame:self.view.bounds];
    }
    return _contentView;
}

-(void)getArtictleClassList{
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  getNewClassListOnCompletionHandler:^(HHResponseResult *responseResult) {
//        [_bgImageView removeFromSuperview];
//        _bgImageView=nil;
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            self.contentView.dataArry=responseResult.responseData;
        }else{
        self.contentView.dataArry=[[HHDatabaseEngine sharedDBEngine] getNewsClassListFromDB];
        }
        
    } onErrorHandler:^(NSError *error) {
        self.contentView.dataArry=[[HHDatabaseEngine sharedDBEngine] getNewsClassListFromDB];
    }];
}
@end
