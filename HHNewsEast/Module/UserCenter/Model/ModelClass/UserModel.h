//
//  UserModel.h
//  HomeTown
//
//  Created by d gl on 14-6-17.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCenterHeader.h"



/**
 *  UserModel
 *  userID              用户ID
 *  userName            用户名称
 *  userNickName        用户昵称
 *  userSignature       用户签名
 *  userGender          用户性别
 */
@interface UserModel : NSObject
@property(nonatomic,copy)NSString *userID;
@property(nonatomic,copy)NSString *userOpeateID;//运营商ID
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userPwd,*userRepeatPwd;
@property(nonatomic,copy)NSString *userPhone;
@property(nonatomic,copy)NSString *userNickName;
@property(nonatomic,copy)NSString *userSignature;//签名
@property(nonatomic,copy)NSString *userGender;//性别
@property(nonatomic,copy)NSString *userEmail;
@property(nonatomic,copy)NSString *userImage;//用户头像

@property(nonatomic,assign)UserLevelType userLevel;//用户类型

@property(nonatomic,copy)NSString *userFees;
@property(nonatomic,copy)NSString *userPoints;//积分
@property(nonatomic,copy)NSString *userLo;//经度
@property(nonatomic,copy)NSString *userLa;//纬度
@property(nonatomic,copy)NSString *userBirthday;//生日
@property(nonatomic,copy)NSString *userAddress;//地址
@property(nonatomic,copy)NSString *userJoineTime;//加入时间
@property(nonatomic,copy)NSString *userWeiXin;//微信
@property(nonatomic,copy)NSString *userSinaCode;//新浪微博
@property(nonatomic,copy)NSString *userQQ;//QQ
@property(nonatomic,copy)NSString *userQRCode;//二维码

-(void)setToUserModelToUserDefault;
/**
 *  获取已经登录的用户的ID
 *
 *  @return NSString
 */
+(NSString *)userID;


/**
 *  获取已经登陆的用户的Model
 *
 *  @return UserModel
 */
+(UserModel *)userModel;

+(BOOL)isLogin;
+(void)logoOut;

/**
 *  判断用户是否需要登陆
 *
 *  @param controller 登陆的controller
 *
 *  @return Bool
 */
+(BOOL)verfiyIsUserLoginAndShouldLoginOnController:(id)controller;


+(void)userRegisterAndLoginWithResponseDic:(NSDictionary *)dic;
@end
