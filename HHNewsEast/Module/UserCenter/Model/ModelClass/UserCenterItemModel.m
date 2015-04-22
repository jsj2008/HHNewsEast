//
//  UserCenterItemModel.m
//  MoblieCity
//
//  Created by Luigi on 14-7-16.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "UserCenterItemModel.h"

@interface UserCenterItemModel ()
@property(nonatomic,assign,readwrite)UserCenterItemType itemType;
@property(nonatomic,copy,readwrite)NSString *itemName;
@property(nonatomic,strong,readwrite)UIImage *itemImage;
@end

@implementation UserCenterItemModel
-(instancetype)initWithItemType:(UserCenterItemType)itemTtpe
                       itemName:(NSString *)itemName
                      itemImage:(UIImage *)itemImage{
    self=[super init];
    if (self) {
        _itemImage=itemImage;
        _itemName=itemName;
        _itemType=itemTtpe;
     
    }
    return self;
}
/**
 *  因为涉到会友多个分区，所有返回的是数组里边嵌套数组。 每个数字是一个分区，最后都给放到一个大的数组里边
 *
 *  @param levelType
 *
 *  @return
 */
+(NSMutableArray *)userCenterItemsArrayWithUserLevelType:(UserLevelType)levelType{
    
    NSMutableArray *itemsArrary=[[NSMutableArray alloc] init];
    
    
    UserCenterItemModel *userInfoModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemUserInfomation itemName:@"我的资料" itemImage:[UIImage imageNamed:@"bg_userCenter_Info"]];
    UserCenterItemModel *userSalesModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemSales itemName:@"我的特卖" itemImage:[UIImage imageNamed:@"bg_userCenter_Sales"]];
    UserCenterItemModel *userShareModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemShare itemName:@"分享给好友" itemImage:[UIImage imageNamed:@"bg_userCenter_Share"]];
    UserCenterItemModel *userFeedBackModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemFeedBack itemName:@"意见反馈" itemImage:[UIImage imageNamed:@"bg_userCenter_FeedBack"]];
    UserCenterItemModel *userAboutUsModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemAboutUs itemName:@"关于我们" itemImage:[UIImage imageNamed:@"bg_userCenter_AboutUs"]];
    UserCenterItemModel *userSettinModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemSettin itemName:@"设置" itemImage:[UIImage imageNamed:@"bg_userCenter_Settin"]];
    UserCenterItemModel *userEditPwdModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemEditPwd itemName:@"密码修改" itemImage:[UIImage imageNamed:@"bg_userCenter_EditPwd"]];
    UserCenterItemModel *userShopsModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemShops itemName:@"我的店铺" itemImage:[UIImage imageNamed:@"bg_userCenter_Shops"]];
    UserCenterItemModel *userRecruitmentModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemRecruitment itemName:@"我的招聘" itemImage:[UIImage imageNamed:@"bg_userCenter_Recruitment"]];
    UserCenterItemModel *userVillageStylsModel=[[UserCenterItemModel alloc] initWithItemType:UserCenterItemVillageStyls itemName:@"乡村风采" itemImage:[UIImage imageNamed:@"bg_userCenter_VillageStyls"]];
    
    [itemsArrary addObject:userSalesModel];
    [itemsArrary addObject:userShareModel];
    [itemsArrary addObject:userFeedBackModel];
    [itemsArrary addObject:userAboutUsModel];
    [itemsArrary addObject:userSettinModel];
    if (levelType==UserLevelTypeUnLogin) {
        
    }else if (levelType==UserLevelTypeCommon){
        [itemsArrary addObject:userInfoModel];
        [itemsArrary addObject:userEditPwdModel];
    }else if(levelType==UserLevelTypeCompany){
        [itemsArrary addObject:userInfoModel];
        [itemsArrary addObject:userEditPwdModel];
        [itemsArrary addObject:userShopsModel];
        [itemsArrary addObject:userRecruitmentModel];
    }else if(levelType==UserLevelTypeVillage){
        [itemsArrary addObject:userInfoModel];
        [itemsArrary addObject:userVillageStylsModel];
        [itemsArrary addObject:userEditPwdModel];
    }
    //[itemsArrary addObject:userListModelArray];
    //[itemsArrary addObjectsFromArray:userListModelArray];
    return itemsArrary;
}
@end
