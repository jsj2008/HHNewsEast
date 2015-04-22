//
//  CommentCell.h
//  SeaArticle
//
//  Created by x f on 14-3-26.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@class CommentModel;


@protocol CommentCellDelegate <NSObject>

-(void)commentCellDidFavorButtonPressedWithComemntModel:(CommentModel *)comentModel;

@end

@interface CommentCell : UITableViewCell

@property(nonatomic,strong)CommentModel*commentModel;
@property(nonatomic,weak)id<CommentCellDelegate>delegate;

+(CGFloat)commentCellHightWithObject:(id)object  atIndex:(NSIndexPath *)indexPath;
@end
