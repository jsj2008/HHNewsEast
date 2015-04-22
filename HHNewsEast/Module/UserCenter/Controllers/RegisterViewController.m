//
//  RegisterViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-8.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "RegisterViewController.h"
#import "HHLoginCell.h"
#import "LoginItemModel.h"
#import "HHNetWorkEngine+UserCenter.h"
@interface RegisterViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HHView *footView,*headerView;
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [[UINavigationBar appearance]  setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.frame=CGRectMake(0, 0, __gScreenWidth, __gScreenHeight-__gTopViewHeight);
    self.enableRefreshData=NO;
        self.dataTableView.frame=CGRectMake(0, 0, __gScreenWidth, __gScreenHeight-__gTopViewHeight);
    self.dataTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.dataTableView.tableFooterView=self.footView;
    self.dataTableView.tableHeaderView=self.headerView;
    self.dataTableView.backgroundColor=[UIColor whiteColor];
    self.dataMutableArray=[LoginItemModel registerItemsArray];
    [self.dataTableView reloadData];
}
-(HHView *)headerView{
    if (nil==_headerView) {
        _headerView=[[HHView alloc]  initWithFrame:CGRectMake(0, 0, __gScreenWidth,50 )];
        _headerView.backgroundColor=[UIColor clearColor];
    }
    return _headerView;
}
-(HHView *)footView{
    if (nil==_footView) {
        _footView=[[HHView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.dataTableView.bounds)-CGRectGetHeight(self.headerView.bounds)-[HHLoginCell loginCellHeight]*2)];
        
        HHButton *loginButton=[HHButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(40, 40, CGRectGetWidth(self.view.bounds)-40*2, 40) titleColor:[UIColor whiteColor] titleSize:20];
        [loginButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setTitle:@"注册" forState:UIControlStateNormal];
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        loginButton.layer.cornerRadius=5.0;
        loginButton.layer.masksToBounds=YES;
        loginButton.backgroundColor=[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1];
        [_footView addSubview:loginButton];
       
    }
    return _footView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
-(void)registerButtonPressed{
     [[UIApplication sharedApplication].keyWindow endEditing:YES];
    NSString *userName,*userPwd;
    for (NSInteger i=0; i<self.dataMutableArray.count; i++) {
        LoginItemModel *model= [self.dataMutableArray objectAtIndex:i];
        if (model.itemType==LoginItemTypeUserName) {
            userName=model.itemValue;
        }else if (model.itemType==LoginItemTypeUserPwd){
            userPwd=model.itemValue;
        }
    }
    if ([NSString IsNullOrEmptyString:userName]||[NSString IsNullOrEmptyString:userPwd]) {
        [self showAlertView:@"请填写完整信息"];
    }else{
        if (userName.length>20) {
            [self showErrorView:@"请输入小于20个字符的用户名"];
            return;
        }
        if (userPwd.length>16) {
            [self showErrorView:@"请输入小于16位密码"];
            return;
        }
        self.op=[[HHNetWorkEngine sharedHHNetWorkEngine] userRegiserWithUserName:userName userPwd:userPwd OnCompletionHandler:^(HHResponseResult *responseResult) {
            if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self showAlertView:responseResult.responseMessage];
            }
        } onErrorHandler:^(NSError *error) {
            [self showAlertView:@"网络连接错误"];
        }];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataMutableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *logninCellIdentifer=@"logninCellIdentifer";
    HHLoginCell *cell=[tableView dequeueReusableCellWithIdentifier:logninCellIdentifer];
    if (nil==cell) {
        cell=[[HHLoginCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logninCellIdentifer];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    LoginItemModel *model=[self.dataMutableArray objectAtIndex:indexPath.row];
    cell.itemModel=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HHLoginCell loginCellHeight];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
