//
//  SystemSettingViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "FeedBackViewController.h"
#import "HHItemModel.h"
#import "HHNetWorkEngine+Setting.h"
@interface SystemSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@end

@implementation SystemSettingViewController

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
	// Do any additional setup after loading the view.
    [self onInitUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onInitUI{
    self.navigationController.navigationBarHidden=NO;
    self.enableRefreshData=NO;
    self.isBackButtonShow=NO;
    [self.dataMutableArray addObjectsFromArray:[HHItemModel systemSettingArray]];
    [self.dataTableView reloadData];
}
-(void)checkUpdate{
    self.op=[[HHNetWorkEngine sharedHHNetWorkEngine]  checkUpdateWithVersionNum:[HHGlobalVarTool appVersion] onCompletionHander:^(HHResponseResult *responseResult) {
        if ([responseResult.responseCode isEqualToString:CODE_STATE_100]) {
            NSString *appUrl=responseResult.responseData;
            if (appUrl.length&&appUrl) {
                   [self showAlertView:responseResult.responseMessage delegate:self];
            }else{
                [self showSuccessView:@"当前已是最新的版本,无需更新！"];
            }
        }else{
            [self showErrorView:responseResult.responseMessage];
        }
    } onErrorHandler:^(NSError *error) {
         [self showErrorView:@"网络连接错误,请稍后再试"];
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[HHGlobalVarTool appStoreDownloadUrl]]];
    }
}
#pragma mark- tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataMutableArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *arry=[self.dataMutableArray objectAtIndex:section];
    return arry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *baseCellIdentifer=@"baseCellIdentifer";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:baseCellIdentifer];
    if (nil==cell) {
        cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseCellIdentifer];
        HHLable *contentLable=[[HHLable alloc]  initWithFrame:CGRectMake(160, 12, 150, 20) fontSize:16 text:@"" textColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
        contentLable.tag=1000;
        [cell.contentView addSubview:contentLable];
        
        cell.textLabel.font=[UIFont systemFontOfSize:18];
        cell.textLabel.textColor=[UIColor blackColor];
            //cell.textLabel.textColor=[UIColor red:51 green:80 blue:88 alpha:1];
    }
    HHLable *contentLable=(HHLable *)[cell.contentView viewWithTag:1000];
    
    NSMutableArray *arry=[self.dataMutableArray objectAtIndex:indexPath.section];
    HHItemModel *itemModel=[arry objectAtIndex:indexPath.row];
    if (itemModel.itemType==HHItemTypeSortSetting) {
        NSString *sortOrder=[HHGlobalVarTool sortOrder];
        if ([sortOrder isEqualToString:@""]) {
            contentLable.text=@"时间排序";
        }else if ([sortOrder isEqualToString:@"2"]){
            contentLable.text=@"评论量排序";
        }
    }else if (itemModel.itemType==HHItemTypeCheckUpdate){
     contentLable.text=[HHGlobalVarTool appVersion];
    }
    cell.textLabel.text=itemModel.itemTitel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }else{
        return 15.0;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *arry=[self.dataMutableArray objectAtIndex:indexPath.section];
    HHItemModel *itemModel=[arry objectAtIndex:indexPath.row];
    if (itemModel.itemType==HHItemTypeShareSetting) {
        
    }else if (itemModel.itemType==HHItemTypeMarkGrade){
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",APPStoreAPPLEID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPStoreDownloadUrl]];
    }else if (itemModel.itemType==HHItemTypeCheckUpdate) {
        [self checkUpdate];
    }else if (itemModel.itemType==HHItemTypeFeedBack) {
        FeedBackViewController *feedBackController=[[FeedBackViewController alloc]  init];
        [self.navigationController pushViewController:feedBackController animated:YES];
    }else if (itemModel.itemType==HHItemTypeSortSetting){
        UIActionSheet *actionSheet=[[UIActionSheet alloc]  initWithTitle:@"设置排序方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"时间排序" otherButtonTitles:@"评论量排序", nil];
        [actionSheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//时间
        [HHGlobalVarTool setSortOrder:@""];
    }else if (buttonIndex==1){//评论量
        [HHGlobalVarTool setSortOrder:@"2"];
    }
    [self.dataTableView reloadData];
}
@end
