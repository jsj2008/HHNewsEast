//
//  LeftPanelView.m
//  HHNewsEast
//
//  Created by Luigi on 14-8-5.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "LeftPanelView.h"
#import "HHPanelModel.h"

#define lHHLeftPanelViewTag     4000

@implementation LeftPanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame panelItems:(NSMutableArray *)items{
    self=[self initWithFrame:frame];
    if (self) {
        _panelArray=items;
        [self onInitDataWithArray:_panelArray];
    }
    return self;
}
-(void)onInitDataWithArray:(NSMutableArray *)array{
        // float magrinX=30.0f;
    float width=  35.0;
    for (NSInteger i=0; i<array.count; i++) {
        UIButton *menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame=CGRectMake((i%2)*(35+width)+30, (i/2)*(30+35)+width, width, width);
        HHPanelModel *model=[array objectAtIndex:i];
        [menuButton setBackgroundImage:model.panelImage forState:UIControlStateNormal];
        menuButton.tag=lHHLeftPanelViewTag+i;
        [menuButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        
        HHLable *lable=[[HHLable alloc] initWithFrame:CGRectMake(menuButton.frame.origin.x-10, menuButton.frame.size.height+menuButton.frame.origin.y+5, width+20, 15) fontSize:12 text:model.panndlTitle textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:1];
        lable.tag=lHHLeftPanelViewTag +100+i;
        [self addSubview:lable];
    }
}
-(void)menuButtonPressed:(UIButton *)sender{
    NSInteger tag=sender.tag-lHHLeftPanelViewTag;
    if (_delegate&&[_delegate respondsToSelector:@selector(leftPanelViewDidSelectedPanelItem:)]) {
         HHPanelModel *model=[_panelArray objectAtIndex:tag];
        [_delegate leftPanelViewDidSelectedPanelItem:model];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
