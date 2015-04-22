//
//  HHScrollMenuView.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-3.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHScrollMenuModel.h"
@protocol HHScrollMenuViewDelegate <NSObject>

-(void)hhScrollMenuViewDidSelectItemView:(HHScrollMenuModel *)model;


-(void)hhScrollMenuViewDidSelectItemType:(HHScrollMenuType )type;

@end


@interface HHScrollMenuView : UIView
@property(nonatomic,strong,readonly)NSArray *menuArry;
@property(nonatomic,weak)id<HHScrollMenuViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame menuArray:(NSArray *)arry;
@end
