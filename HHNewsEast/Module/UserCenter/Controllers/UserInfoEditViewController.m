//
//  UserInfoEditViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-21.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "UserInfoEditViewController.h"
#import "HHNetWorkEngine+UserCenter.h"
@interface UserInfoEditViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *oringlValue;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)HHView *footView;
@end

@implementation UserInfoEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithOringValue:(NSString *)oringlValue atIndexPath:(NSIndexPath *)indexPath{
    self=[super init];
    if (self) {
        _oringlValue=oringlValue;
        _indexPath=indexPath;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
}
-(void)setNavigationBar{
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
	// Do any additional setup after loading the view.
    self.enableRefreshData=NO;
    self.dataTableView.tableHeaderView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, __gScreenWidth, 40)];
    self.dataTableView.tableFooterView=self.footView;
}
-(HHView *)footView{
    if (nil==_footView) {
        _footView=[[HHView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        
        HHButton *loginButton=[HHButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(40, 40, CGRectGetWidth(self.view.bounds)-40*2, 40) titleColor:[UIColor whiteColor] titleSize:20];
        [loginButton addTarget:self action:@selector(userInfoEditButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setTitle:@"确定修改" forState:UIControlStateNormal];
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        loginButton.layer.cornerRadius=5.0;
        loginButton.layer.masksToBounds=YES;
        loginButton.backgroundColor=[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1];
        [_footView addSubview:loginButton];
    }
    return _footView;
}
-(void)userInfoEditButtonPressed{
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  editUserInfoWithUserID:[UserModel userID] UserMessage:_oringlValue item:0 OnCompletionHandler:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            [self showSuccessView:@"修改成功"];
             [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self showErrorView:responseResult.responseMessage];
        }
    } onErrorHandler:^(NSError *error) {
        [self showErrorView:@"网络连接错误,请稍后再试"];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifer=@"cellInentifer";
    UITableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        HHTextField *textField=[[HHTextField alloc]  initWithFrame:CGRectMake(10, 10, __gScreenWidth-20, 30) fontSize:14 delegate:self borderStyle:UITextBorderStyleNone returnKeyType:UIReturnKeyDone keyboardType:UIKeyboardTypeDefault placeholder:@""];
        textField.tag=1000;
        [cell.contentView addSubview:textField];
    }
    HHTextField *textField=(HHTextField *)[cell.contentView viewWithTag:1000];
    textField.indexPath=indexPath;
    if (indexPath.row==0) {
        textField.text=_oringlValue;
        [textField becomeFirstResponder];
    }
    return cell;
}

@end
