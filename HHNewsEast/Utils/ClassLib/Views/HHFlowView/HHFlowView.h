//
//  HHFlowView.h
//  HomeTown
//
//  Created by d gl on 14-6-9.
//  Copyright (c) 2014年 luigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHFlowModel.h"

@protocol HHFlowViewDelegate <NSObject>
@optional
//广告
-(void)flowViewADTouchSuccessWithIndex:(NSInteger)index;
@end

typedef void(^HHFlowViewDidSelectedBlock)(HHFlowModel *flowModel,NSInteger index);
@interface HHFlowView : UIView

/**
 *  显示图片的数组，数组里边存放的是图片的路径
 */
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,weak)id<HHFlowViewDelegate>delegate;
@property(nonatomic,copy)HHFlowViewDidSelectedBlock flowViewDidSelectedBlock;
/**
 *  初始化 方法，初始化的时候调用此方法
 *
 *  @param frame frame
 *
 *  @return HHFlowView
 */
- (id)initWithFrame:(CGRect)frame;

/**
 *  是否显示大图 默认为 NO
 */
@property(nonatomic,assign,setter = setIsShowBigImage:) BOOL isShowBigImage;
-(void)setIsShowBigImage:(BOOL)isShowBigImage;
@end
