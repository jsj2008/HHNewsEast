//
//  CommentModel.h
//  SeaArticle
//
//  Created by x f on 14-3-29.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
//评论的model
@property(nonatomic,strong)NSString *commentId;             //评论id
@property(nonatomic,strong)NSString *commentUserID;         //评论用户id
@property(nonatomic,copy)NSString *commentUserName;         //评论的用户的名称
@property(nonatomic,copy)NSString *commentUserImageUrl;         //评论的用户的名称
@property(nonatomic,copy)NSString *commentArtictleID;       //评论的文章的ID
@property(nonatomic,strong)NSString *commentContent;        //评论内容
@property(nonatomic,strong)NSString *commentTime;           //评论的发布时间
@property(nonatomic,copy)NSString *commentIsShow;            //是否显示
@property(nonatomic,copy)NSString *commentFavorNum;         //赞的数量
@property(nonatomic,assign)BOOL isFavored;//是否赞过
@end
