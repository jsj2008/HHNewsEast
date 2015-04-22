//
//  HHArticleListCell.m
//  SeaArticle
//
//  Created by d gl on 14-5-21.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "HHArticleListCell.h"
#import "UIImageView+WebCache.h"
#import "ArticleModel.h"
#import "HHDatabaseEngine+News.h"
@interface HHArticleListCell ()
@property(nonatomic,strong)HHImageView *imageView;
@property(nonatomic,strong)HHLable      *titleLable,*comentCountLable,*timeLable,*visitCountLable;
@end

@implementation HHArticleListCell
@synthesize artictleModel           =_artictleModel;
@synthesize titleLable              =_titleLable;
@synthesize comentCountLable               =_comentCountLable;
@synthesize timeLable               =_timeLable;
@synthesize imageView               =_imageView;
@synthesize visitCountLable         =_visitCountLable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self onInitData];
    }
    return self;
}
-(void)onInitData{
    _imageView=[[HHImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 70)];
    _imageView.backgroundColor  =[UIColor clearColor];
    _imageView.layer.cornerRadius=3.0;
    _imageView.layer.masksToBounds=YES;
    [self.contentView addSubview:_imageView];
    
    _titleLable =[[HHLable alloc] initWithFrame:CGRectMake(100, 8, 210, 45) fontSize:16 text:@"" textColor:[UIColor colorWithRed:25/255.0 green:54/255.0 blue:75/255.0 alpha:1] textAlignment:NSTextAlignmentLeft numberOfLines:2];
    _titleLable.font=[UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLable];
    
    /*
    _timeLable=[[HHLable alloc] initWithFrame:CGRectMake(100, 35, 200, 20) fontSize:14 text:@"" textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_timeLable];
    */
    HHImageView *commentImgView=[[HHImageView alloc] initWithFrame:CGRectMake(292, 58, 12, 12)];
    commentImgView.image=[UIImage imageNamed:@"bt_home_comment"];
    [self.contentView addSubview:commentImgView];
    _comentCountLable =[[HHLable alloc] initWithFrame:CGRectMake(250, 56, 35, 15) fontSize:12 text:@"" textColor:[UIColor grayColor] textAlignment:NSTextAlignmentRight numberOfLines:1];
    [self.contentView addSubview:_comentCountLable];
    /*
    
    HHImageView *visitImgView=[[HHImageView alloc] initWithFrame:CGRectMake(100, 64, 12, 12)];
    visitImgView.image=[UIImage imageNamed:@"bt_home_comment"];
    [self.contentView addSubview:visitImgView];
    _visitCountLable =[[HHLable alloc] initWithFrame:CGRectMake(120, 62, 80, 20) fontSize:12 text:@"" textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1];
    [self.contentView addSubview:_visitCountLable];
*/
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setArtictleModel:(ArticleModel *)artictleModel{
    _artictleModel  =artictleModel;
    if (artictleModel.isRead) {
        _titleLable.textColor=[UIColor darkGrayColor];
        [[HHDatabaseEngine sharedDBEngine] updateNewsReadState:artictleModel.isRead withNewsID:_artictleModel.articleID];
    }
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[HHGlobalVarTool fullNewsImagePath:_artictleModel.articleImage]] placeholderImage:HHLoadingWaitImage];
    _titleLable.text=_artictleModel.articleTitle;
     _comentCountLable.text  =_artictleModel.articleVisitNum;
    /*
    _timeLable.text         =[NSString stringWithFormat:@"发布时间:%@",_artictleModel.articlePublishTime];
    _visitCountLable.text   =_artictleModel.articleVisitNum;
     */
}
+(CGFloat)artictleListCellHeightAtIndexPath:(NSIndexPath *)indexPath articeleModel:(id)model{
    return 80;
}
@end
