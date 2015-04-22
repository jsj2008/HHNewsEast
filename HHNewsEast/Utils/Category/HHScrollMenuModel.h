//
//  HHScrollMenuModel.h
//  HHNewsEast
//
//  Created by Luigi on 14-8-3.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HHScrollMenuType) {
    HHScrollMenuNone    ,
    HHScrollMenuBack    ,
    HHScrollMenuShare   ,
    HHScrollMenuCollect ,
    HHScrollMenuComment ,
};

@interface HHScrollMenuModel : NSObject
@property(nonatomic,assign)HHScrollMenuType menuType;
@property(nonatomic,strong)UIImage *menuImage;


-(id)initWithMenuType:(HHScrollMenuType )type menuImage:(UIImage *)menuImage;

@end
