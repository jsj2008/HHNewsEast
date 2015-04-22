//
//  HHLoginCell.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-8.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginItemModel;
@interface HHLoginCell : UITableViewCell
@property(nonatomic,strong)LoginItemModel *itemModel;
+(CGFloat)loginCellHeight;
@end
