//
//  HHNavigationController.h
//  SeaMallSell
//
//  Created by d gl on 14-3-19.
//  Copyright (c) 2014年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>



    // 背景视图起始frame.x
#define startX -200;
@interface HHNavigationController : UINavigationController
{
 CGFloat startBackViewX;
}
    // 默认为特效开启
@property (nonatomic, assign) BOOL canDragBack;
@end
