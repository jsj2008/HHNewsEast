//
//  LoginItemModel.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-8.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LoginItemType) {
    LoginItemTypeUserName,
    LoginItemTypeUserPwd          ,
 
};

@interface LoginItemModel : NSObject
@property(nonatomic,copy)NSString *itemTitle;
@property(nonatomic,copy)NSString *itemPlacholder;
@property(nonatomic,assign)LoginItemType itemType;
@property(nonatomic,copy)NSString *itemValue;

-(id)initWithItemTitle:(NSString *)title placeHolder:(NSString *)placholder;
-(id)initWithItemTitle:(NSString *)title placeHolder:(NSString *)placholder itemType:(LoginItemType)itemType;
+(NSMutableArray *)loginItemsArray;
+(NSMutableArray *)registerItemsArray;
@end


