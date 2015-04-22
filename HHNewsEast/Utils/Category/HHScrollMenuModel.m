//
//  HHScrollMenuModel.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-3.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHScrollMenuModel.h"

@implementation HHScrollMenuModel
-(id)initWithMenuType:(HHScrollMenuType )type menuImage:(UIImage *)menuImage{
    self=[super init];
    if (self) {
        _menuType=type;
        _menuImage=menuImage;
    }
    return self;
}
@end
