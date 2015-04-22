//
//  HHPanelModel.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHPanelModel.h"

@implementation HHPanelModel
-(id)initWithPanelItem:(PanelViewItem)item panelImage:(UIImage *)image{
    self=[super init];
    if (self) {
        _panelImage=image;
        _panelItem=item;
    }
    return self;
}
-(id)initWithPanelItem:(PanelViewItem)item panelImage:(UIImage *)image title:(NSString *)title{
    self=[self initWithPanelItem:item panelImage:image];
    _panndlTitle=title;
    return self;
}
+(NSMutableArray *)panelViewItemsArray{
    NSMutableArray *reslultArray=[[NSMutableArray alloc]  init];
//    HHPanelModel *loginModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemLogin panelImage:[UIImage imageNamed:@"btn_left_userinfo"] title:@"登陆"];
//    [reslultArray addObject:loginModel];
    
    HHPanelModel *collectModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemCollect panelImage:[UIImage imageNamed:@"btn_left_collect"] title:@"收藏"];
    [reslultArray addObject:collectModel];
    
    HHPanelModel *settingModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemSetting panelImage:[UIImage imageNamed:@"btn_left_setting"] title:@"设置"];
    [reslultArray addObject:settingModel];
    
    HHPanelModel *offLineModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemOffLine panelImage:[UIImage imageNamed:@"btn_left_download"] title:@"离线"];
    [reslultArray addObject:offLineModel];

    HHPanelModel *searchModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemSearch panelImage:[UIImage imageNamed:@"btn_left_search"]title:@"搜索"];
    [reslultArray addObject:searchModel];

    /*
    HHPanelModel *sortModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemSort panelImage:[UIImage imageNamed:@"btn_left_ranking"] title:@"排序"];
    [reslultArray addObject:sortModel];
     */
    
//    HHPanelModel *shanghaiModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemShangHai panelImage:[UIImage imageNamed:@"btn_left_connetShangHai"]title:@"连接上海"];
//    [reslultArray addObject:shanghaiModel];
    
    HHPanelModel *clearCacheModel=[[HHPanelModel alloc]  initWithPanelItem:PanelViewItemClearCache panelImage:[UIImage imageNamed:@"btn_left_clearCache"] title:@"清除缓存"];
    [reslultArray addObject:clearCacheModel];
    
    return reslultArray;
}
@end
