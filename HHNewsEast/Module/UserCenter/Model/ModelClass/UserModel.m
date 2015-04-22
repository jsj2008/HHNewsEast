//
//  UserModel.m
//  HomeTown
//
//  Created by d gl on 14-6-17.
//  Copyright (c) 2014年 luigi. All rights reserved.
//
#define  UserModel_UserID             @"__MobileCity_UserID_"
#define  UserModel_UserShopID         @"__MobileCity_UserShopID_"
#define  UserModel_UserCompanyName       @"__MobileCity_UserCompanyName_"
#define  UserModel_UserCompanyAddress    @"__MobileCity_UserCompanyAddress_"
#define  UserModel_UserCompanyContact    @"__MobileCity_UserCompanyContact_"
#define  UserModel_UserCompanyPhone      @"__MobileCity_UserCompanyPhone_"
#define  UserModel_UserName           @"__MobileCity_UserName_"
#define  UserModel_UserNickenName     @"__MobileCity_UserNickenName_"
#define  UserModel_UserImage          @"__MobileCity_UserImage_"
#define  UserModel_UserLevel          @"__MobileCity_UserLevel_"
#define  UserModel_UserLevelStr       @"__MobileCity_UserLevelStr_"
#define  UserModel_UserPoints         @"__MobileCity_UserPoints_"
#define  UserModel_UserGoal           @"__MobileCity_UserGoal_"
#define  UserModel_UserGender         @"__MobileCity_UserGender_"
#define  UserModel_UserBgImage        @"__MobileCity_UserBackgroundImage_"
#define  UserModel_UserSettingType    @"__MobileCity_UserSettingType_"

#import "UserModel.h"
@implementation UserModel
-(void)setUserImage:(NSString *)userImage{
 NSString *imgPath  =[[[NSUserDefaults standardUserDefaults] objectForKey:UserModel_UserImage]  URLDecodedString];
    [[SDImageCache sharedImageCache]removeImageForKey:[HHGlobalVarTool fullUserHeaderImagePath:imgPath]];
    
        NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
        [stanDefault setObject:[userImage URLEncodedString] forKey:UserModel_UserImage];
        [stanDefault synchronize];
    _userImage=userImage;
   
}

-(void)setUserGender:(NSString *)userGender{
    _userGender=userGender;
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    [stanDefault setObject:[_userGender URLDecodedString] forKey:UserModel_UserGender];
    [stanDefault synchronize];
}
-(void)setUserNickName:(NSString *)userNickName{
    _userNickName=userNickName;
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    [stanDefault setObject:[_userNickName URLDecodedString] forKey:UserModel_UserNickenName];
    [stanDefault synchronize];
}
-(void)setUserLevel:(UserLevelType)userLevel{
    _userLevel=userLevel;
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    [stanDefault setObject:[[NSString stringWithFormat:@"%ld",_userLevel] URLDecodedString] forKey:UserModel_UserLevel];
    [stanDefault synchronize];
}
-(void)setUserPwd:(NSString *)userPwd{
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    [stanDefault setObject:userPwd forKey:UserModel_UserLevel];
    [stanDefault synchronize];
}

-(void)setToUserModelToUserDefault{
    UserModel *u_Model=self;
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    [stanDefault setObject:[u_Model.userID URLEncodedString] forKey:UserModel_UserID];
    [stanDefault setObject:[u_Model.userName URLEncodedString] forKey:UserModel_UserName];
    [stanDefault setObject:[u_Model.userNickName URLDecodedString] forKey:UserModel_UserNickenName];
    [stanDefault setObject:[[NSString stringWithFormat:@"%d",u_Model.userLevel] URLEncodedString] forKey:UserModel_UserLevel];
   
    [stanDefault setObject:[u_Model.userImage URLEncodedString] forKey:UserModel_UserImage];
    [stanDefault setObject:[u_Model.userPoints URLEncodedString] forKey:UserModel_UserPoints];
    [stanDefault synchronize];}

+(NSString *)userID{
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    NSString *localUserID     =   [[stanDefault objectForKey:UserModel_UserID]  URLDecodedString] ;
    return localUserID;
}
+(BOOL)isLogin{
    NSString *userID=[UserModel userID];
    if (userID&&userID.length) {
        return YES;
    }else{
        return NO;
    }
}
+(void)logoOut{
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    [stanDefault setObject:nil forKey:UserModel_UserID];
    [stanDefault setObject:nil forKey:UserModel_UserShopID];
    [stanDefault setObject:nil forKey:UserModel_UserCompanyName];
    [stanDefault setObject:nil forKey:UserModel_UserCompanyAddress];
    [stanDefault setObject:nil forKey:UserModel_UserCompanyContact];
    [stanDefault setObject:nil forKey:UserModel_UserCompanyPhone];
    [stanDefault setObject:nil forKey:UserModel_UserName];
    [stanDefault setObject:nil forKey:UserModel_UserNickenName];
    [stanDefault setObject:[[NSString stringWithFormat:@"%d",UserLevelTypeUnLogin] URLEncodedString] forKey:UserModel_UserLevel];
    [stanDefault setObject:nil forKey:UserModel_UserLevelStr];
    [stanDefault setObject:nil forKey:UserModel_UserImage];
    [stanDefault setObject:nil forKey:UserModel_UserPoints];
    [stanDefault setObject:nil forKey:UserModel_UserGoal];}
+(UserModel *)userModel{
    UserModel *userModel=[[UserModel alloc] init];
    NSUserDefaults *stanDefault=[NSUserDefaults standardUserDefaults];
    
    userModel.userID        =[[stanDefault objectForKey:UserModel_UserID]  URLDecodedString];
       userModel.userName      =[[stanDefault objectForKey:UserModel_UserName]  URLDecodedString];
    userModel.userNickName  =[[stanDefault objectForKey:UserModel_UserNickenName] URLDecodedString];
    userModel.userImage     =[[stanDefault objectForKey:UserModel_UserImage]  URLDecodedString];
    userModel.userPoints    =[[stanDefault objectForKey:UserModel_UserPoints]  URLDecodedString];


    userModel.userLevel=[[[stanDefault objectForKey:UserModel_UserLevel]  URLDecodedString]integerValue];
    userModel.userLevel=userModel.userLevel==0?UserLevelTypeUnLogin:userModel.userLevel;//如否为0则设为未登录状态

    return userModel;
}


+(BOOL)verfiyIsUserLoginAndShouldLoginOnController:(id)controller{
    NSString *userID=[UserModel userID];
     //BOOL isLogin=[NSString IsNullOrEmptyString:userID];
    BOOL isLogin=userID.length;
    if (!isLogin) {
        
    }
    return isLogin;
}
+(void)userRegisterAndLoginWithResponseDic:(NSDictionary *)dic{
    UserModel *userModel=[[UserModel alloc]  init];
    userModel.userID=[dic objectForKey:@"empID"];
    userModel.userName=[[dic objectForKey:@"empName"] URLDecodedString];
    userModel.userImage=[[dic objectForKey:@"photoURI"] URLDecodedString];
    [userModel setToUserModelToUserDefault];
}
@end
