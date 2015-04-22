//
//  HHContentCell.h
//  SeaArticle
//
//  Created by d gl on 14-5-23.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleModel;
@class ArticleClassModel;
@protocol HHContentCellDelegate <NSObject>
-(void)contentCellSelecedAtIndexPath:(NSIndexPath *)indexPath artictleModel:(ArticleModel *)artictleModel;
@end

@interface HHContentCell : UITableViewCell
/**
 *  只用传类别的ID 就行，不再需要classModel
 */
@property(nonatomic,strong)ArticleClassModel *classModel;

+(NSString *)contentCellIdentiferWithClassModel:(ArticleClassModel *)classModel;
@end
