//
//  UserInfoEditViewController.h
//  HHNewsEast
//
//  Created by Luigi on 14-9-21.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void(^UserInfoEditFinsihedBlock)(NSString *value, NSIndexPath *indexPath);

@interface UserInfoEditViewController : BaseTableViewController



@property(nonatomic,copy)UserInfoEditFinsihedBlock userinfoEditFinsihBlock;

-(id)initWithOringValue:(NSString *)oringlValue atIndexPath:(NSIndexPath *)indexPath;
@end
