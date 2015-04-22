//
//  BaseViewController.m
//  DdmBuy
//
//  Created by Luigi on 13-10-7.
//  Copyright (c) 2013年 Luigi. All rights reserved.
//

#import "BaseViewController.h"
#define LeftButtonLeftMargin 10.0f
#define LeftButtonTopMargin 6.0f
#define LeftButtonWidth 40.0f
#define LeftButtonHeight 30.0f

typedef NS_ENUM(NSInteger, BaseScrollDiretion) {
    BaseScrollDiretionNone      =100,
    BaseScrollDiretionUP       ,
    BaseScrollDiretionDown      ,
    BaseScrollDiretionLeft  ,
    BaseScrollDiretionRight ,
};


@interface BaseViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UILabel *topTitleLabel;
@property (nonatomic,strong) UIButton *leftButton,*shareButton,*collentButton,*commentButton;
@property (nonatomic,strong) UIImageView *leftImgView;
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,assign)BaseScrollDiretion scrollDirection;
@property(nonatomic,assign)CGFloat lastPotionY;
@end

@implementation BaseViewController

-(void)dealloc{
    DLog(@"\n controller is dealloced----%@ is dealloc",self);
    [self.op cancel];
    self.op=nil;
    [[SDImageCache sharedImageCache] clearMemory];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _hideType=HHControllerHideTypePop;
    }
    return self;
}
-(id)init{
    self=[super init];
    if (self) {
        _scrollDirection=BaseScrollDiretionNone;
        _enableShare=YES;
        _enableComment=YES;
        _enableCollect=YES;
        _hideType=HHControllerHideTypePop;
    }
    return self;
}
-(void)viewDidDisappear:(BOOL)animated
{
    if (self.op) {
        [self.op cancel];
        self.op=nil;
    }
    [[SDImageCache sharedImageCache] clearMemory];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}
-(void)viewDidUnload{
    [super viewDidUnload];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self onPerformInit];
}

-(void)onPerformInit{
    self.view.backgroundColor=[UIColor red:237.0 green:237.0 blue:237.0 alpha:1.0];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        self.edgesForExtendedLayout=NO;
    }
}
-(void)enablSwipGestureOnView:(UIView *)view{
/*
    view.userInteractionEnabled=YES;
    UISwipeGestureRecognizer *upSwipgesture=[[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(swipGestureUp:)];
    upSwipgesture.direction=UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *downSwipgesture=[[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(swipGestureDown:)];
    downSwipgesture.direction=UISwipeGestureRecognizerDirectionDown;
//    [view addGestureRecognizer:upSwipgesture];
//    [view addGestureRecognizer:downSwipgesture];
    if ([view isKindOfClass:[UIWebView class]]) {
        UIWebView *webView=(UIWebView *)view;
        [webView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:downSwipgesture];
        [webView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:upSwipgesture];

    }
 */
}

-(void)swipGestureUp:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction==UISwipeGestureRecognizerDirectionUp) {
        if (_scrollDirection!=BaseScrollDiretionUP) {
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame=  _leftButton.frame;
                frame.origin.x=0;
                _leftButton.frame=frame;
                
                CGRect righFrame=_rightView.frame;
                righFrame.origin.x=righFrame.origin.x-righFrame.size.width;
                _rightView.frame=righFrame;
                
            } completion:^(BOOL finished) {
                
            }];
        }
        _scrollDirection=BaseScrollDiretionUP;

    }
}
-(void)swipGestureDown:(UISwipeGestureRecognizer *)gesrure{
    if (gesrure.direction==UISwipeGestureRecognizerDirectionDown) {
    if (_scrollDirection!=BaseScrollDiretionDown) {
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame=  _leftButton.frame;
            frame.origin.x=-frame.size.width;
            _leftButton.frame=frame;
            
            CGRect righFrame=_rightView.frame;
            righFrame.origin.x=righFrame.origin.x+righFrame.size.width;
            _rightView.frame=righFrame;
        } completion:^(BOOL finished) {
            
        }];
    }
    _scrollDirection=BaseScrollDiretionDown;
    }
}
-(UIButton *)leftButton{
    if (nil==_leftButton) {
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame=CGRectMake(0, CGRectGetHeight(self.view.bounds)-150, 48, 48);
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"btn_leftButtonBack"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftBackButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.hidden=YES;
        
    }
    return _leftButton;
}
-(UIButton *)shareButton{
    if (nil==_shareButton) {
        _shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame=CGRectMake(0,0, 48, 49);
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(didShareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}
-(UIButton *)collentButton{
    if (nil==_collentButton) {
        _collentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _collentButton.frame=CGRectMake(0,50, 48, 49);
        [_collentButton setBackgroundImage:[UIImage imageNamed:@"btn_collect"] forState:UIControlStateNormal];
        [_collentButton addTarget:self action:@selector(didCollectButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collentButton;
    
}
-(UIButton *)commentButton{
    if (nil==_commentButton) {
        _commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame=CGRectMake(0,100, 48, 49);
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"btn_comment"] forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(didCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}
-(UIView *)rightView{
    if (nil==_rightView) {
        _rightView=[[UIView alloc]  initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)-48, CGRectGetHeight(self.view.bounds)-231, 48, 150)];
        
        //   _rightView.opaque=YES;
        _rightView.backgroundColor=[UIColor clearColor];
        if (_enableCollect) {
            [_rightView addSubview:self.collentButton];
        }
        if (_enableComment) {
            [_rightView addSubview:self.commentButton];
        }
        if (_enableShare) {
            [_rightView addSubview:self.shareButton];
        }
    }
    return _rightView;
}
-(void)setIsBackButtonShow:(BOOL)isBackButtonShow{
    _isBackButtonShow=isBackButtonShow;
    if (_isBackButtonShow) {
        // self.leftButton.window.windowLevel=UIWindowLevelAlert+1;
        self.leftButton.hidden=NO;
        [self.view addSubview:self.leftButton];
        [self.view bringSubviewToFront:_leftButton];
    }else{
        _leftButton.hidden=YES;
        [_leftButton removeFromSuperview];
    }
}
-(void)setEnableCollect:(BOOL)enableCollect{
    _enableCollect=enableCollect;
    if (enableCollect) {
        [self.rightView bringSubviewToFront:self.collentButton];
    }else{
        [self.collentButton removeFromSuperview];
        self.collentButton=nil;
    }
}
-(void)setEnableComment:(BOOL)enableComment{
    _enableComment=enableComment;
    if (enableComment) {
        [self.rightView addSubview:self.commentButton];
        [self.rightView bringSubviewToFront:self.commentButton];
    }else{
        [self.commentButton removeFromSuperview];
        self.commentButton=nil;
    }
}
-(void)setEnableShare:(BOOL)enableShare{
    _enableShare=enableShare;
    if (_enableShare) {
        [self.rightView bringSubviewToFront:self.shareButton];
    }else{
        [self.shareButton removeFromSuperview];
        [self.shareButton removeFromSuperview];
    }
}
-(void)setEnableRightView:(BOOL)enableRightView{
    _enableRightView=enableRightView;
    if (_enableRightView) {
        [self.view addSubview:self.rightView];
    }else{
        [self.rightView removeFromSuperview];
        self.rightView=nil;
    }
}
-(void)didCollectButtonPressed{
}
-(void)didShareButtonPressed{
}
-(void)didCommentButtonPressed{
}
#pragma mark -顶部左侧按钮点击
-(void)leftBackButtonPressed
{
    [self backButtonPressedHiddenController:_hideType];
}
#pragma mark  - setter 方法
-(void)setHideType:(HHControllerHideType)hideType{
    _hideType=hideType;
}
#pragma mark 隐藏viewcontroller
-(void)backButtonPressedHiddenController:(HHControllerHideType)hideType{
    [[SDImageCache sharedImageCache] clearMemory];
    switch (hideType) {
        case HHControllerHideTypePop:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case HHControllerHideTypeDismiss:
        {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }
        default:
            break;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y>0&&scrollView.contentOffset.y<scrollView.contentSize.height) {
    if (scrollView.contentOffset.y-_lastPotionY>0) {
        if (_scrollDirection!=BaseScrollDiretionUP) {
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame=  _leftButton.frame;
                frame.origin.x=-frame.size.width;
                _leftButton.frame=frame;
                
                CGRect righFrame=_rightView.frame;
                righFrame.origin.x=righFrame.origin.x+righFrame.size.width;
                _rightView.frame=righFrame;
                
            } completion:^(BOOL finished) {
                
            }];
        }
        _scrollDirection=BaseScrollDiretionUP;
    }else if (scrollView.contentOffset.y-_lastPotionY<0){
        if (_scrollDirection!=BaseScrollDiretionDown) {
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame=  _leftButton.frame;
                frame.origin.x=0;
                _leftButton.frame=frame;
                
                CGRect righFrame=_rightView.frame;
                righFrame.origin.x=righFrame.origin.x-righFrame.size.width;
                _rightView.frame=righFrame;
            } completion:^(BOOL finished) {
                
            }];
        }
        _scrollDirection=BaseScrollDiretionDown;

    }
    _lastPotionY=scrollView.contentOffset.y;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *myTouch =[touches anyObject];
    [myTouch locationInView:self.view];
}
@end