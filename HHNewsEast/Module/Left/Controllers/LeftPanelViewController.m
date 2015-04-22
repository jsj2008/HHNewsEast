//
//  LeftPanelViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-7-31.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "LeftPanelViewController.h"
#import "LeftPanelView.h"
#import "HHPanelModel.h"

#import "SystemSettingViewController.h"
#import "MyCollectViewController.h"
#import "HHDatabaseEngine+News.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "HHNetWorkEngine+News.h"
#import "SearchNewsViewController.h"
@interface LeftPanelViewController ()<LeftPanelViewDelegate>
@property(nonatomic,strong)HHImageView *headImageView;
@property(nonatomic,strong)HHLable *nameLable;

@property(nonatomic,strong)LeftPanelView *panelView;
@end

@implementation LeftPanelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self updateTopUI];
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
-(void)updateTopUI{
    if ([UserModel isLogin]) {
        UserModel  *userModel=[UserModel userModel];
        _headImageView.layer.borderWidth=1.0;
         _headImageView.layer.borderColor=[UIColor whiteColor].CGColor;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[HHGlobalVarTool fullUserHeaderImagePath:userModel.userImage]] placeholderImage:[UIImage imageNamed:@"btn_left_userinfo"]];
        self.nameLable.text=userModel.userName;
    }else{
        _headImageView.layer.borderWidth=0;
         _headImageView.layer.borderColor=[UIColor clearColor].CGColor;
        _headImageView.image=[UIImage imageNamed:@"btn_left_userinfo"];
        self.nameLable.text=@"登录管理";
        self.headImageView.image=[UIImage imageNamed:@"btn_left_userinfo"];
    }
}
-(HHImageView *)headImageView{
    if (nil==_headImageView) {
        _headImageView=[[HHImageView alloc] initWithFrame:CGRectMake(45, 70, 40, 40)];
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.layer.masksToBounds=YES;
       
        _headImageView.image=[UIImage imageNamed:@"btn_left_userinfo"];
        _headImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(hanlerHeaderImageViewTap)];
        [_headImageView addGestureRecognizer:tapGesture];
    }
    return _headImageView;
}
-(HHLable *)nameLable{
    if (nil==_nameLable) {
        _nameLable=[[HHLable alloc]  initWithFrame:CGRectMake(self.headImageView.frame.origin.x+self.headImageView.frame.size.width+5, self.headImageView.frame.origin.y+10, 100, 20) fontSize:14 text:@"登录管理" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        
    }
    return _nameLable;
}
-(void)hanlerHeaderImageViewTap{
    if ([UserModel isLogin]) {
        UserInfoViewController *userInfoController=[[UserInfoViewController alloc]  init];
        userInfoController.navigationItem.title=@"个人资料";
        [self.navigationController pushViewController:userInfoController animated:YES];
    }else{
        LoginViewController *loginController=[[LoginViewController alloc]  init];
        loginController.navigationItem.title=@"登陆华人频道";
        //loginController.navigationController.navigationBarHidden=NO;
        [self.navigationController pushViewController:loginController animated:YES];
    }
}
-(LeftPanelView *)panelView{
    if (nil==_panelView) {
            _panelView=[[LeftPanelView alloc] initWithFrame:CGRectMake(20, 120, 200, 400) panelItems:[HHPanelModel panelViewItemsArray]];
        _panelView.delegate=self;
    }
    return _panelView;
}
-(void)onInitData{
    self.navigationController.navigationBarHidden=YES;
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image=[UIImage imageNamed:@"bg_leftpanel"];
    [self.view addSubview:bgImageView];

    [self.view addSubview:self.panelView];
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.nameLable];
    [self updateTopUI];
}

#pragma mark-panview delegate
-(void)leftPanelViewDidSelectedPanelItem:(HHPanelModel *)model{
    if (model.panelItem==PanelViewItemSetting) {
        SystemSettingViewController *settinController=[[SystemSettingViewController alloc]  init];
        settinController.tableViewStyle=UITableViewStyleGrouped;
        settinController.navigationItem.title=@"设置";
        [self.navigationController pushViewController:settinController animated:YES];
    }else if (model.panelItem==PanelViewItemCollect){
        MyCollectViewController *collectController=[[MyCollectViewController alloc]  init];
        collectController.navigationItem.title=@"我的收藏";
        collectController.ctrType=ControrollerTypeCollect;
        [self.navigationController pushViewController:collectController animated:YES];
    }else if (model.panelItem==PanelViewItemClearCache){
        [self showWaitView:@"请稍后..."];
        [[SDImageCache sharedImageCache]  cleanDisk];
        [[HHDatabaseEngine sharedDBEngine]  clearAllData];
        [self showSuccessView:@"缓存清理完毕！"];
    }else if (model.panelItem==PanelViewItemLogin){
        
    }else if (model.panelItem==PanelViewItemSearch){
        SearchNewsViewController *searchNewsController=[[SearchNewsViewController alloc]  init];
        searchNewsController.navigationItem.title=@"搜索新闻";
        [self.navigationController pushViewController:searchNewsController animated:YES];
    }else if (model.panelItem==PanelViewItemOffLine){
        [self downLoadNews];
    }else if (model.panelItem==PanelViewItemSort){
        
    }else if (model.panelItem==PanelViewItemShangHai){
        
    }
}
-(void)downLoadNews{
    [self showWaitView:@"正在同步..."];
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  offLineDownloadNewsWithNewsClassID:[HHGlobalVarTool newsClassID] pageIndex:1 pageSize:HHPageSize onCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            [[HHDatabaseEngine sharedDBEngine]  insertNewsIntoDBWithNewsArray:responseResult.responseData newsClassID:[HHGlobalVarTool newsClassID] ];
            [self showSuccessView:@"同步成功"];
        }else{
            [self showErrorView:responseResult.responseMessage];
        }
    } onErrorHandler:^(NSError *error) {
        [self showErrorView:@"网络连接错误,请检查网络连接"];
    }];
}
@end
