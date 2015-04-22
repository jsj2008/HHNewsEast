//
//  HHArticleListCell.h
//  SeaArticle
//
//  Created by d gl on 14-5-21.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface HHArticleListCell : UITableViewCell
@property(nonatomic,strong)ArticleModel *artictleModel;
+(CGFloat)artictleListCellHeightAtIndexPath:(NSIndexPath *)indexPath articeleModel:(id)model;
@end
