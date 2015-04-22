//
//  HHPanelModel.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,  PanelViewItem) {
    PanelViewItemLogin     ,//登陆
    PanelViewItemCollect    ,//收藏
    PanelViewItemSetting    ,//设置
    PanelViewItemOffLine    ,//离线新闻
    PanelViewItemSearch     ,//搜索
    PanelViewItemSort       ,//排序
    PanelViewItemShangHai   ,//连接上海
    PanelViewItemClearCache ,//清楚缓存
};
@interface HHPanelModel : NSObject
@property(nonatomic,strong)UIImage          *panelImage;
@property(nonatomic,assign)PanelViewItem      panelItem;
@property(nonatomic,copy)NSString *panndlTitle;
-(id)initWithPanelItem:(PanelViewItem)item panelImage:(UIImage *)image;
-(id)initWithPanelItem:(PanelViewItem)item panelImage:(UIImage *)image title:(NSString *)title;
+(NSMutableArray *)panelViewItemsArray;
@end
