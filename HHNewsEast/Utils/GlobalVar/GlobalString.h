//
//  GlobalString.h
//  MoblieCity
//
//  Created by d gl on 14-6-30.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#ifndef MoblieCity_GlobalString_h
#define MoblieCity_GlobalString_h

float       __gOffY;                    //向下偏移量 ， ios 7以前的版本是 0。ios 7 以后的版本的是20
float       __gTopViewHeight;           //导航栏的高度 ios 7以上是 64；ios7以下 是44.
float       __gScreenHeight;            //屏幕的高度
float       __gScreenWidth;             //屏幕的宽度
NSString *  __gDocumentPath;            //沙盒路径
#define HHBackgorundColor   [UIColor red:237.0 green:237.0 blue:237.0 alpha:1.0]//背景颜色

#define HHPageSize 30

/**
 *  appstore 下载地址
 */
#define APPStoreDownloadUrl         @"https://itunes.apple.com/cn/app/zai-han-bao-dian/id863932824?mt=8"
#define APPStoreAPPLEID                     547203809//appleID


#endif
