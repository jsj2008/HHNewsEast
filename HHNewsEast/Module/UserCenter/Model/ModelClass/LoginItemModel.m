//
//  LoginItemModel.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-8.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "LoginItemModel.h"

@implementation LoginItemModel
-(id)initWithItemTitle:(NSString *)title placeHolder:(NSString *)placholder{
    self=[super init];
    if (self) {
        _itemTitle=title;
        _itemPlacholder=placholder;
    }
    return self;
}
-(id)initWithItemTitle:(NSString *)title placeHolder:(NSString *)placholder itemType:(LoginItemType)itemType{
    self=[self initWithItemTitle:title placeHolder:placholder];
    if (self) {
        _itemType=itemType;
    }
    return self;
}
+(NSMutableArray *)loginItemsArray{
    NSMutableArray *itemArray=[[NSMutableArray alloc]  init];
    LoginItemModel *nameModel=[[LoginItemModel alloc]  initWithItemTitle:@"账号" placeHolder:@"" itemType:LoginItemTypeUserName];
    [itemArray addObject:nameModel];
    
    LoginItemModel *pwdModel=[[LoginItemModel alloc]  initWithItemTitle:@"密码" placeHolder:@"" itemType:LoginItemTypeUserPwd];
    [itemArray addObject:pwdModel];
    return itemArray;
}
+(NSMutableArray *)registerItemsArray{
    NSMutableArray *itemArray=[[NSMutableArray alloc]  init];
    LoginItemModel *nameModel=[[LoginItemModel alloc]  initWithItemTitle:@"注册账号(不超过20个汉字字符)" placeHolder:@"" itemType:LoginItemTypeUserName];
    [itemArray addObject:nameModel];
    
    LoginItemModel *pwdModel=[[LoginItemModel alloc]  initWithItemTitle:@"注册密码(不超过16个汉字字符)" placeHolder:@"" itemType:LoginItemTypeUserPwd];
    [itemArray addObject:pwdModel];

    return itemArray;
    
}
@end
