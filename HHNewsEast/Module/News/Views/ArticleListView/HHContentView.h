//
//  HHContentView.h
//  SeaArticle
//
//  Created by d gl on 14-5-21.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>





@class HHContentView;
@protocol HHContentViewDelegate <NSObject>
-(void)contentView:(HHContentView *)contentView willDisplayCellAtPage:(NSInteger)page;

@end


@interface HHContentView : UIView

/**
 *  文章列表的数组
 */
@property(nonatomic,strong)NSMutableArray *dataArry;

/**
 *  当前的文章的类别ID
 */
@property(nonatomic,strong,readonly)NSString *artictleClassID;


@property(nonatomic,weak)id<HHContentViewDelegate>delegate;



@end
