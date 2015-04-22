//
//  HHTabBarController.h
//  CosmeticsBuy
//
//  Created by d gl on 13-12-30.
//  Copyright (c) 2013年 d gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTabBarController : UITabBarController
+(HHTabBarController *)sharedTarBarController;
/**
 *  加载ViewControllers
 */
-(void)onInitRootViewControllers;
@end
