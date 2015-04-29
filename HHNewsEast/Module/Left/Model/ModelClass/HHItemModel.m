//
//  HHItemModel.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHItemModel.h"

@implementation HHItemModel
-(id)initWithItemTitle:(NSString *)title type:(HHItemType)type{
    self=[super  init];
    if (self) {
        _itemTitel=title;
        _itemType=type;
    }
    return self;
}
+(NSMutableArray *)systemSettingArray{
    NSMutableArray *itemsArray=[[NSMutableArray alloc]  init];
    /*
     NSMutableArray *itemsArray0=[[NSMutableArray alloc]  init];
    HHItemModel  *shareModel=[[HHItemModel alloc]  initWithItemTitle:@"分享设置" type:HHItemTypeShareSetting];
    [itemsArray0 addObject:shareModel];
    HHItemModel  *markModel=[[HHItemModel alloc]  initWithItemTitle:@"为我打分" type:HHItemTypeMarkGrade];
    [itemsArray0 addObject:markModel];
    [itemsArray addObject:itemsArray0];
    */
    
    NSMutableArray *itemsArray1=[[NSMutableArray alloc]  init];
        //   NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
        //NSString *versionString= [[infoDictionary objectForKey:@"CFBundleVersion"] stringByAppendingString:@")"];
//    HHItemModel  *updateModel=[[HHItemModel alloc]  initWithItemTitle:[@"检测更新(" stringByAppendingString:versionString] type:HHItemTypeCheckUpdate];
//     HHItemModel  *updateModel=[[HHItemModel alloc]  initWithItemTitle:@"检测更新" type:HHItemTypeCheckUpdate];
//    [itemsArray1 addObject:updateModel];
    /*
    HHItemModel  *feedBackModel=[[HHItemModel alloc]  initWithItemTitle:@"意见反馈 " type:HHItemTypeFeedBack];
    [itemsArray1 addObject:feedBackModel];
     */
    HHItemModel  *sortModel=[[HHItemModel alloc]  initWithItemTitle:@"排序方式" type:HHItemTypeSortSetting];
    [itemsArray1 addObject:sortModel];
    [itemsArray addObject:itemsArray1];
    return itemsArray;
}
+(NSMutableArray *)systemSharePatforms{
    return nil;
}
@end
