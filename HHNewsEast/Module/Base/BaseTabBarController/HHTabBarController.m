//
//  HHTabBarController.m
//  CosmeticsBuy
//
//  Created by d gl on 13-12-30.
//  Copyright (c) 2013年 d gl. All rights reserved.
//

#import "HHTabBarController.h"
#import "HHNavigationController.h"

#import "HHAppDelegate.h"


@interface HHTabBarItem  : UITabBarItem;
@end
@implementation HHTabBarItem
- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag
{
        //   image=[UIImage scaleImage:image ToSize:CGSizeMake(28.0, 28.0)];
        //    selectedImage=[UIImage scaleImage:selectedImage ToSize:CGSizeMake(28.0, 28.0)];
    self = [super initWithTitle:title image:image tag:tag];
    if (CURRENT_SYS_VERSION>=7.0) {
        [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
    }else{
        [self setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
    }
    if (self) {
            // Custom initializatio
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
            [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],UITextAttributeFont,[UIColor colorWithRed:253/255.0 green:150/255.0 blue:44/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    return self;
}
@end


static HHTabBarController *__hhTabbarController;
@interface HHTabBarController ()

@end

@implementation HHTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bgview"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
+(HHTabBarController *)sharedTarBarController{
    @synchronized(self){
        if (nil==__hhTabbarController) {
            __hhTabbarController=[[HHTabBarController alloc] init];
        }
    }
    return __hhTabbarController;
}

-(void)onInitRootViewControllers{
}
@end
