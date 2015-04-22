//
//  HHScrollMenuView.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-3.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHScrollMenuView.h"
#import "HHScrollMenuModel.h"
#define HHScrollMenuItemWidth       40

@implementation HHScrollMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame menuArray:(NSArray *)arry{
    self=[super initWithFrame:frame];
    if (self) {
        _menuArry=arry;
        
    }
    return self;
}
-(void)onInitDataWithArray:(NSArray *)array{
    for (NSInteger i=0; i<array.count; i++) {
        UIButton *menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame=CGRectMake(0, i*HHScrollMenuItemWidth, HHScrollMenuItemWidth, HHScrollMenuItemWidth);
        HHScrollMenuModel *menuModel=[array objectAtIndex:i];
        [menuButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchDragInside];
        menuButton.tag=5000+menuModel.menuType;
       [ menuButton setBackgroundImage:menuModel.menuImage forState:UIControlStateNormal];
    }
}
-(void)menuButtonPressed:(UIButton *)sender{
    HHScrollMenuType type=HHScrollMenuNone;
    type=sender.tag-5000;
    if (_delegate&&[_delegate respondsToSelector:@selector(hhScrollMenuViewDidSelectItemType:)]) {
        [_delegate hhScrollMenuViewDidSelectItemType:type];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextBeginPath(context);
    for (NSInteger i=0; i<_menuArry.count; i++) {
        if (_menuArry.count>1) {
            
        }
            CGContextMoveToPoint(context, 0, 0);
    }


}


@end
