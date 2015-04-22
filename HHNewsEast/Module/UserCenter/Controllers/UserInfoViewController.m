//
//  UserInfoViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-9-18.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoEditViewController.h"
#import "HHImagePickerController.h"
#import "HHNetWorkEngine+UploadImage.h"
@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,HHImagePickerControlelrDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)HHView *footView;
@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic,strong)HHImagePickerController *imagePickerController;
@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.enableRefreshData=NO;
    self.dataTableView.frame=CGRectMake(0, 0, __gScreenWidth, __gScreenHeight-__gTopViewHeight);
	// Do any additional setup after loading the view.
    self.dataTableView.tableHeaderView=self.headerView;
    self.dataTableView.tableFooterView=self.footView;
    self.dataTableView.backgroundColor=[UIColor whiteColor];
    [self setNavigationBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [self setNavigationBar];
    [self updateUI];
}
-(void)setNavigationBar{
    [[UINavigationBar appearance]  setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    self.navigationController.navigationBarHidden=NO;
    
}
-(HHImagePickerController *)imagePickerController{
    if (nil==_imagePickerController) {
        _imagePickerController=[[HHImagePickerController alloc]  initWithParentControler:self delegate:self];
    }
    return _imagePickerController;
}
-(UIView *)headerView{
    if (nil==_headerView) {
        _headerView=[[UIView alloc]  initWithFrame:CGRectMake(0, 0, __gScreenWidth, 200)];
        UIImageView * _headImageView=[[HHImageView alloc] initWithFrame:CGRectMake(45, 60, 80, 80)];
        _headImageView.center=CGPointMake(__gScreenWidth/2, 100);
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.layer.masksToBounds=YES;
        _headImageView.tag=2000;
        _headImageView.image=[UIImage imageNamed:@"btn_left_userinfo"];
        _headImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(hanlerHeaderImageViewTap)];
        [_headImageView addGestureRecognizer:tapGesture];
        [_headerView addSubview:_headImageView];
    }
    return _headerView;
}
-(void)updateUI{
    UIImageView * _headImageView=(UIImageView *)[self.headerView viewWithTag:2000];
    UserModel *userModel=[UserModel userModel];
    if (userModel.userImage) {
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[HHGlobalVarTool fullUserHeaderImagePath:userModel.userImage]] placeholderImage:[UIImage imageNamed:@"btn_left_userinfo"]];
    }else{
        _headImageView.image=[UIImage imageNamed:@"btn_left_userinfo"];
    }
}
-(HHView *)footView{
    if (nil==_footView) {
        _footView=[[HHView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        
        HHButton *loginButton=[HHButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(40, 40, CGRectGetWidth(self.view.bounds)-40*2, 40) titleColor:[UIColor whiteColor] titleSize:20];
        [loginButton addTarget:self action:@selector(userLogoOutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setTitle:@"注销登录" forState:UIControlStateNormal];
        loginButton.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        loginButton.layer.cornerRadius=5.0;
        loginButton.layer.masksToBounds=YES;
        loginButton.backgroundColor=[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1];
        [_footView addSubview:loginButton];
    }
    return _footView;
}
-(void)userLogoOutButtonPressed{
    [UserModel logoOut];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hanlerHeaderImageViewTap{
    [self.imagePickerController hhImagePickerControllerPickImageWithImageMark:HHUploadImageUserHeaderImage];
}
#pragma mark - UploadImageDeleagate
- (void)hhImagePickerControllerDidFinisUpaloadImageWithLocalPath:(NSString *)imgPath imageMark:(HHUploadImageMark)imgMark responseData:(id )responseData{
    if (imgMark==HHUploadImageUserHeaderImage) {
        HHImageModel *imageModel=responseData;
        UserModel *userModel=[UserModel userModel];
        userModel.userImage=imageModel.imageBigUrl;
        [self updateUI];
        
    }
}
- (void)hhImagePickerControllerFailedToUploadImageWithWithLocalPath:(NSString *)imgPath imgMark:(HHUploadImageMark)imgMark{
    if (imgMark==HHUploadImageUserHeaderImage) {
        [self showErrorView:@"上传头像失败"];
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
NSString *cellIdentifer=@"cellInentifer";
    UITableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        HHLable *contentLable=[[HHLable alloc]  initWithFrame:CGRectMake(100, 10, 200, 20) fontSize:14 text:@"" textColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
        contentLable.tag=1000;
        [cell.contentView addSubview:contentLable];
        
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.textColor=[UIColor blackColor];
    }
    HHLable *contentLable=(HHLable *)[cell.contentView viewWithTag:1000];
    if (indexPath.row==0) {
        cell.textLabel.text=@"昵称:";
        contentLable.text=[NSString stringByReplaceNullString:_userModel.userName];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell  *cell=[tableView cellForRowAtIndexPath:indexPath];
    HHLable *contentLable=(HHLable *)[cell.contentView viewWithTag:1000];
    NSString *oringalStr=contentLable.text;
    UserInfoEditViewController *editViewController=[[UserInfoEditViewController alloc]  initWithOringValue:oringalStr atIndexPath:indexPath];
    editViewController.navigationItem.title=@"修改昵称";
    editViewController.userinfoEditFinsihBlock=^(NSString *valueStr,NSIndexPath *indexPath){
        if (indexPath.row==0) {
            _userModel.userName=valueStr;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    };
    [self.navigationController pushViewController:editViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
