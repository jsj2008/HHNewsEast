//
//  MyCollectViewController.h
//  HHNewsEast
//
//  Created by Luigi on 14-9-18.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger,ControrollerType) {
    ControrollerTypeCollect,
    ControrollerTypeSearch,
};

@interface MyCollectViewController : BaseTableViewController
@property(nonatomic,assign)ControrollerType ctrType;
@end
