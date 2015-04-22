//
//  GlobalMacro.h
//  MoblieCity
//
//  Created by d gl on 14-6-30.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#ifndef MoblieCity_GlobalMacro_h
#define MoblieCity_GlobalMacro_h
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

    // block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

    // device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

    // iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

    // image STRETCH
#define HH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])


    //加载请等待的图片
#define HHLoadingWaitImage   [UIImage imageNamed:@"loadingDefault"]
    //图片前缀路径
#define HHUploadImageDir    @"http://103.31.72.11:8080/App"
/**
 *  网络连接错误的提示信息
 */
#define  HHLoadFailedMessage        @"网络连接失败,触摸屏幕重新加载"

/**
 *  正在努力加载的提示信息
 */
#define  HHLoadWaitMessage          @"正在努力加载,请稍后..."
/**
 *  暂时没有数据提示信息
 */
#define  HHLoadFinishedNoMessage          @"暂时还没有数据,看看其他的吧"
/**
 *  网络错误的时候  需要加载的显示错误的图片
 */
#define HHLoadFailedImage    [UIImage imageNamed:@""]
#define HHLoadNoDataImage     [UIImage imageNamed:@""]
#define HHLoadWaitAnimationImages    [NSArray arrayWithObjects:[UIImage imageNamed:@""], nil]
#define HHLoadWaitAnimationDuration   0.3




#endif
