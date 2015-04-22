//
//  FeedBackViewController.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HHTextView *contextView;
@property(nonatomic,strong)HHTextField *textField;
@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
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
-(void)onInitData{
     self.enableRefreshData=NO;
    self.dataTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.dataTableView.scrollEnabled=NO;
    self.isBackButtonShow=YES;
}
#pragma mark- tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.row==0) {
        static NSString *baseCellIdentifer=@"baseCellIdentifer";
        cell=[tableView dequeueReusableCellWithIdentifier:baseCellIdentifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseCellIdentifer];
            cell.textLabel.font=[UIFont systemFontOfSize:19];
            cell.textLabel.textColor=[UIColor red:51 green:80 blue:88 alpha:1];
            _contextView=[[HHTextView alloc]  initWithFrame:CGRectMake(10, 10, 300.0, 200.0) textColor:[UIColor darkGrayColor] textFont:[UIFont systemFontOfSize:14] delegate:nil placeHolderString:@"发表反馈意见"];
            [cell.contentView addSubview:_contextView];
            _contextView.backgroundColor=[UIColor whiteColor];
        }
    }else if(indexPath.row==1){
        static NSString *telphoneCellIdentifer=@"telphoneCellIdentifer";
        cell=[tableView dequeueReusableCellWithIdentifier:telphoneCellIdentifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:telphoneCellIdentifer];
            UIView *bgView=[[UIView alloc]  initWithFrame:CGRectMake(10, 5, 300, 40)];
            bgView.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:bgView];
            _textField=[[HHTextField alloc] initWithFrame:CGRectMake(90, 5, 200.0, 30.0) fontSize:14 delegate:nil borderStyle:UITextBorderStyleNone returnKeyType:UIReturnKeySend keyboardType:UIKeyboardTypePhonePad placeholder:@"(选填)"] ;
            [bgView addSubview:_textField];
            
             HHLable *textLable=[[HHLable alloc]  initWithFrame:CGRectMake(5, 5, 80, 30) fontSize:16 text:@"电话号码" textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
            [bgView addSubview:textLable];
        }

    }else if (indexPath.row==2){
        static NSString *platFormCellIdentifer=@"platFormCellIdentifer";
        cell=[tableView dequeueReusableCellWithIdentifier:platFormCellIdentifer];
        if (nil==cell) {
            cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:platFormCellIdentifer];
            
            HHLable *textLable=[[HHLable alloc]  initWithFrame:CGRectMake(10, 5, 200, 100) fontSize:18 text:[self getRemarkMessage]textColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
            [cell.contentView addSubview:textLable];
            
        }

    }
    cell.backgroundColor=HHBackgorundColor;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0.0;
    if (indexPath.row==0) {
        height=200.0;
    }else if (indexPath.row==1){
        height=50.0;
    }else if (indexPath.row==2){
        height=100.0;
    }
    return height;
}
-(NSString *)getRemarkMessage{
    NSString *platformString=[[@"设备:" stringByAppendingString:[[UIDevice currentDevice] model]] stringByAppendingString:@"\n"];
   
    NSString *systemVersionString= [[@"系统:" stringByAppendingString:[[UIDevice currentDevice] systemVersion]] stringByAppendingString:@"\n"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *versionString= [[@"华人新闻版本:" stringByAppendingString:[infoDictionary objectForKey:@"CFBundleShortVersionString"]] stringByAppendingString:@"\n"];
    
    return [[platformString stringByAppendingString:systemVersionString] stringByAppendingString:versionString];
}
@end
