//
//  UserCenterItemModel.h
//  MoblieCity
//
//  Created by Luigi on 14-7-16.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCenterHeader.h"


@interface UserCenterItemModel : NSObject

@property(nonatomic,assign,readonly)UserCenterItemType itemType;
/**
 *  名称
 */
@property(nonatomic,copy,readonly)NSString *itemName;


/**
 *  item图片
 */
@property(nonatomic,strong,readonly)UIImage *itemImage;

//列表类型
//@property(nonatomic, strong) UserListModel * userListModel;


/**
 *  初始化item的方法
 *
 *  @param itemTtpe  类型
 *  @param itemName  名称
 *  @param itemImage 图片
 *
 *  @return itemModel
 */
-(instancetype)initWithItemType:(UserCenterItemType)itemTtpe
                       itemName:(NSString *)itemName
                      itemImage:(UIImage *)itemImage;

/**
 *  获取个人中心的item的数组
 *
 *  @param levelType levelType
 *
 *  @return NsMutableArrary
 */
+(NSMutableArray *)userCenterItemsArrayWithUserLevelType:(UserLevelType)levelType;
@end
