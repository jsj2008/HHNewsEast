//
//  CommentCell.m
//  SeaArticle
//
//  Created by x f on 14-3-26.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import <CoreText/CoreText.h>
#import "NSString+H_Html.h"
@interface CommentCell ()
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UIImageView *headerImageView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel*contentLabel;
@property(nonatomic,strong) UILabel *praiseLabel;
@property(nonatomic,strong) UIButton *praiseButton;

@end

@implementation CommentCell

-(void)dealloc{
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _nameLabel=[[UILabel alloc]  initWithFrame:CGRectMake(60, 10, 100, 20)];
        _nameLabel.backgroundColor=[UIColor clearColor];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        _nameLabel.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.textColor=[UIColor colorWithRed:25/255.0 green:54/255.0 blue:75/255.0 alpha:1];
        
        
        _headerImageView=[[UIImageView alloc]  initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.contentView addSubview:_headerImageView];
        _headerImageView.layer.cornerRadius=_headerImageView.frame.size.width/2;
        _headerImageView.layer.masksToBounds=YES;
        _headerImageView.userInteractionEnabled=YES;
        
        
        
        _contentLabel  = [[HHLable alloc]initWithFrame:CGRectMake(58, 35, 235, 30) fontSize:14 text:nil textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping; // "abdc..."
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor=[UIColor darkGrayColor];
        _contentLabel.userInteractionEnabled=YES;

        
        
        _timeLabel.textColor=[UIColor darkGrayColor];
        
        _praiseLabel=[[UILabel alloc]  initWithFrame:CGRectMake(__gScreenWidth-95, 10, 60, 14)];
        _praiseLabel.backgroundColor=[UIColor clearColor];
        _praiseLabel.textAlignment=NSTextAlignmentRight;
        _praiseLabel.textColor=[UIColor colorWithRed:25/255.0 green:54/255.0 blue:75/255.0 alpha:1];
        _praiseLabel.textColor=[UIColor lightGrayColor];
        _praiseLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_praiseLabel];
        
        
        _praiseButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.frame=CGRectMake(__gScreenWidth-30, 10, 16, 14);
        [self.contentView addSubview:_praiseButton];
        
        
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_support"] forState:UIControlStateNormal];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_supported"] forState:UIControlStateSelected];
        [_praiseButton addTarget:self action:@selector(favorButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        _praiseButton.userInteractionEnabled=YES;

    }
    self.backgroundColor=[UIColor red:240 green:240 blue:240 alpha:1.0];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark -重用
-(void)prepareForReuse{
    [super prepareForReuse];
    _timeLabel.text=nil;
    _contentLabel.text=nil;
    _nameLabel.text=nil;
    _headerImageView.image = nil;
    _praiseLabel.text = nil;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat heiht=[CommentCell calcuteCommentContentHeight:_commentModel];
    CGRect contframe = _contentLabel.frame;
    contframe.size.height = heiht;
    _contentLabel.frame =contframe;
}

-(void)favorButtonPressed{
    if (self.commentModel.isFavored) {
        [SVProgressHUD showErrorWithStatus:@"您已赞过！"];
    }else{
    if (_delegate&&[_delegate respondsToSelector:@selector(commentCellDidFavorButtonPressedWithComemntModel:)]) {
        [_delegate commentCellDidFavorButtonPressedWithComemntModel:self.commentModel];
    }
    }
    self.praiseButton.selected=YES;
      self.commentModel.isFavored=YES;
}
+(CGFloat)calcuteCommentContentHeight:(CommentModel *)c_Model{
    CGFloat height=0.0f;
    NSString *commentStr=c_Model.commentContent;
        //NSMutableAttributedString *attrCommentStr=[[NSMutableAttributedString alloc] initWithString:commentStr attributes:c_Model.commentContent];
   
     height=[commentStr boundingRectWithfont:[UIFont systemFontOfSize:14] maxTextSize:CGSizeMake(235.0, 2000)].height;
    return height;
}
-(void)setCommentModel:(CommentModel *)commentModel{
      _commentModel = commentModel;
    self.praiseButton.selected=self.commentModel.isFavored;
  
    _timeLabel.text = _commentModel.commentTime;
    _nameLabel.text = _commentModel.commentUserName;
    _praiseLabel.text = _commentModel.commentFavorNum;
   [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[HHGlobalVarTool fullUserHeaderImagePath:_commentModel.commentUserImageUrl]] placeholderImage:HHLoadingWaitImage];
    _contentLabel.text =_commentModel.commentContent;
}

+(CGFloat)commentCellHightWithObject:(id)object  atIndex:(NSIndexPath *)indexPath{
    CGFloat height=45.0f;
    CommentModel *mode=object;
    height=height+[CommentCell calcuteCommentContentHeight:mode];
    return height;
}

@end
