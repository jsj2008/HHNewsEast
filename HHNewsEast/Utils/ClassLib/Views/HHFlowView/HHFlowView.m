//
//  HHFlowView.m
//  HomeTown
//
//  Created by d gl on 14-6-9.
//  Copyright (c) 2014年 luigi. All rights reserved.
//
/**
 *  显示的imageview ,可以根据自己的需求对这个view进行修改;也可以自定义这个view ,
 */
#import "HHFlowView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"


typedef void(^HHFlowImageDidSelectedBlock)(HHFlowModel *flowModel);
@interface FlowImageView : UIImageView
@property(nonatomic,strong)HHFlowModel *flowModel;
@property(nonatomic,copy)HHFlowImageDidSelectedBlock flowImageViewDidSelectBlock;
@end

@implementation FlowImageView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *imageViewTapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewTapGrTouch:)];
        imageViewTapGr.cancelsTouchesInView = NO;
        [self addGestureRecognizer:imageViewTapGr];
    }
    return self;
}

-(void)setFlowModel:(HHFlowModel *)flowModel{
    _flowModel=flowModel;
    if (_flowModel.flowImageUrl&&([_flowModel.flowImageUrl hasPrefix:@"http://"]||[_flowModel.flowImageUrl hasPrefix:@"www."])) {
        [self sd_setImageWithURL:[NSURL URLWithString:_flowModel.flowImageUrl] placeholderImage:HHLoadingWaitImage];
    }else if ([_flowModel.flowImageUrl hasPrefix:NSHomeDirectory()]){
        UIImage *image=[UIImage imageWithContentsOfFile:_flowModel.flowImageUrl];
        self.image=image;
    }else{
        self.image=HHLoadingWaitImage ;
    }
}
-(void)imgViewTapGrTouch:(UITapGestureRecognizer *)tap{
    if (self.flowImageViewDidSelectBlock) {
        self.flowImageViewDidSelectBlock(self.flowModel);
    }
}
@end




@interface FlowScrollView : UIScrollView
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)FlowImageView *imageView0,*imageView1,*imageView2;

@property(nonatomic,copy)HHFlowViewDidSelectedBlock flowScrollViewDidSelectedBlock;
@end

@implementation FlowScrollView
@synthesize dataArry        =_dataArry;
@synthesize imageView0      =_imageView0;
@synthesize imageView1      =_imageView1;
@synthesize imageView2      =_imageView2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        _imageView0=[[FlowImageView alloc] initWithFrame:CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height)];
        __weak FlowScrollView *weakSelf=self;
        _imageView0.flowImageViewDidSelectBlock=^(HHFlowModel *flowModel){
            NSInteger index=[weakSelf.dataArry indexOfObject:flowModel];
            weakSelf.flowScrollViewDidSelectedBlock(flowModel,index);
        };
        [self addSubview:_imageView0];
        
        _imageView1=[[FlowImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView1.flowImageViewDidSelectBlock=^(HHFlowModel *flowModel){
            NSInteger index=[weakSelf.dataArry indexOfObject:flowModel];
            weakSelf.flowScrollViewDidSelectedBlock(flowModel,index);
        };

        [self addSubview:_imageView1];
        
        _imageView2=[[FlowImageView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
        _imageView2.flowImageViewDidSelectBlock=^(HHFlowModel *flowModel){
            NSInteger index=[weakSelf.dataArry indexOfObject:flowModel];
            weakSelf.flowScrollViewDidSelectedBlock(flowModel,index);
        };

        [self addSubview:_imageView2];
    }
    return self;
}

@end





@interface HHFlowView ()<UIScrollViewDelegate>
@property(nonatomic,strong)FlowScrollView *myScrollView;
@property(nonatomic,strong)UIPageControl *myPageControl;
@property(nonatomic,assign)NSUInteger firsttage,currenttage,lasttage;
@property(nonatomic,strong)UILabel *pageLable;


@end

@implementation HHFlowView
@synthesize myScrollView        =_myScrollView;
@synthesize dataArry            =_dataArry;
@synthesize myPageControl       =_myPageControl;
@synthesize firsttage           =_firsttage,currenttage=_currenttage,lasttage=_lasttage;
@synthesize delegate            =_delegate;
-(void)dealloc{
    _myScrollView.delegate=nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _myScrollView=[[FlowScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _myScrollView.contentSize=CGSizeMake(frame.size.width*3, 0);
        _myScrollView.delegate=self;
        __weak HHFlowView *weakSelf=self;
        _myScrollView.flowScrollViewDidSelectedBlock=^(HHFlowModel *flowModel,NSInteger index){
            weakSelf.flowViewDidSelectedBlock(flowModel,index);
        };
       
        [self addSubview:_myScrollView];
        [_myScrollView setContentOffset:CGPointMake(0, 0)];
        _myScrollView.pagingEnabled=YES;
        _myPageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(100, frame.size.height-20, 120, 20)];
        _myPageControl.numberOfPages=0;
        _myPageControl.currentPage=0;
        
        [self addSubview:_myPageControl];
        self.isShowBigImage=NO;
        _pageLable=[[UILabel alloc]  initWithFrame:CGRectMake(20,  frame.size.height-40, 40, 20)];
        _pageLable.backgroundColor=[UIColor clearColor];
        _pageLable.textColor=[UIColor colorWithRed:25/255.0 green:54/255.0 blue:75/255.0 alpha:1] ;
        _pageLable.font=[UIFont systemFontOfSize:15];
        [self addSubview:_pageLable];
    }
    return self;
}
-(void)setDataArry:(NSMutableArray *)dataArry{
    _dataArry=dataArry;
    _myPageControl.numberOfPages=_dataArry.count;
    
    switch (_dataArry.count) {
        case 0:
            return;
            break;
        case 1:{
            _firsttage=0;
            _currenttage=0;
            _lasttage=0;
        }break;
        case 2:{
            _firsttage=1;
            _currenttage=0;
            _lasttage=1;
        }break;
        default:{
            _firsttage=(_dataArry.count-1);
            _currenttage=0;
            _lasttage=1;
        }
            break;
    }
    _pageLable.text=[NSString stringWithFormat:@"1/%d",_dataArry.count];
    _myScrollView.imageView0.flowModel=[_dataArry objectAtIndex:_firsttage];
    _myScrollView.imageView1.flowModel=[_dataArry objectAtIndex:_currenttage];
    _myScrollView.imageView2.flowModel=[_dataArry objectAtIndex:_lasttage];
}

-(void)setIsShowBigImage:(BOOL)isShowBigImage{
    _isShowBigImage=isShowBigImage;
}
#pragma mark - UIScrollViewDegegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{//当前滚动
    
        // NSLog(@"---End Scroll--%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x>=scrollView.frame.size.width) {//向右滑动了
        if (_lasttage==(_dataArry.count-1)) {
            _firsttage      =_currenttage;
            _currenttage    =_lasttage;
            _lasttage       =0;
        }else{
            _firsttage      =_currenttage;
            _currenttage    =_lasttage;
            _lasttage++;
        }
    }else if (scrollView.contentOffset.x<scrollView.frame.size.width){//向左滑动了
        if (_firsttage==0) {
            _lasttage       =_currenttage;
            _currenttage    =_firsttage;
            _firsttage      =(_dataArry.count-1);
        }else{
            _lasttage       =_currenttage;
            _currenttage    =_firsttage;
            _firsttage--;
        }
    }
    _myPageControl.currentPage=_currenttage;
     _pageLable.text=[NSString stringWithFormat:@"%d/%d",(_currenttage+1),_dataArry.count];
    _myScrollView.imageView0.flowModel=[_dataArry objectAtIndex:_firsttage];
    _myScrollView.imageView1.flowModel=[_dataArry objectAtIndex:_currenttage];
    _myScrollView.imageView2.flowModel=[_dataArry objectAtIndex:_lasttage];
    [_myScrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // NSLog(@"---scrollview did Scroll--%f",scrollView.contentOffset.x);
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
        // NSLog(@"scorllview did end scroll--");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)imageViewTouchSuccessWithImagePath:(NSString *)imgPath{
    if (_dataArry.count) {
        NSInteger index=[_dataArry indexOfObject:imgPath];
        if (_delegate && [_delegate respondsToSelector:@selector(flowViewADTouchSuccessWithIndex:)]) {
            [_delegate flowViewADTouchSuccessWithIndex:index];
        }
        if (_isShowBigImage) {
            NSMutableArray *photoArray=[[NSMutableArray alloc]  init];
            for (NSString *imgPath in _dataArry) {
                MJPhoto *photo=[[MJPhoto alloc]  init];
                photo.url=[NSURL URLWithString:[HHGlobalVarTool fullNewsImagePath:imgPath]];
                [photoArray addObject:photo];
            }
            MJPhotoBrowser *photoBroswer=[[MJPhotoBrowser alloc] init];
            photoBroswer.photos=photoArray;
            photoBroswer.currentPhotoIndex=index;
            [photoBroswer show];
        }
    }
}
@end
