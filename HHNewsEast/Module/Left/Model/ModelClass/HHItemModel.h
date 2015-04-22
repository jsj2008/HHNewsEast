//
//  HHItemModel.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HHItemType) {
    HHItemTypeShareSetting      ,
    HHItemTypeCheckUpdate       ,
    HHItemTypeFeedBack          ,
    HHItemTypeMarkGrade         ,//打分
    HHItemTypeSortSetting         ,//排序
};

@interface HHItemModel : NSObject
@property(nonatomic,copy)NSString *itemTitel;
@property(nonatomic,strong)UIImage *itemImage;
@property(nonatomic,assign)HHItemType itemType;
-(id)initWithItemTitle:(NSString *)title type:(HHItemType)type;
+(NSMutableArray *)systemSettingArray;

+(NSMutableArray *)systemSharePatforms;
@end
