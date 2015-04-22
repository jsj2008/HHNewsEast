//
//  HHSearchViewController.h
//  MoblieCity
//
//  Created by Luigi on 14-8-7.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import "BaseViewController.h"

@protocol HHSearchControllerDelegate <NSObject>

-(void)searchControllerShouldSearchWithKeyWords:(NSString *)keywords;

@end

@interface HHSearchViewController : BaseViewController
/**
 *  SearchaBar里边显示的 plachoder
 */
@property(nonatomic,copy)NSString *searchPlaceholder;

/**
 *  SearchaBar是否可用
 */
@property(nonatomic,assign)BOOL searchEnable;


@property(nonatomic,weak)id<HHSearchControllerDelegate>delegate;
@end
