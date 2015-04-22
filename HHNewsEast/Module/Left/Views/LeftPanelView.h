//
//  LeftPanelView.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHPanelModel;
@protocol LeftPanelViewDelegate <NSObject>
-(void)leftPanelViewDidSelectedPanelItem:(HHPanelModel *)model;
@end

@interface LeftPanelView : UIView
@property(nonatomic,strong)NSMutableArray *panelArray;

-(id)initWithFrame:(CGRect)frame panelItems:(NSMutableArray *)items;
@property(nonatomic,weak)id<LeftPanelViewDelegate>delegate;
@end
