 //
//  HHAppDelegate.m
//  HHNewsEast
//
//  Created by Luigi on 14-7-27.
//  Copyright (c) 2014年 Luigi. All rights reserved.
//

#import "HHAppDelegate.h"
#import "XHDrawerController.h"
#import "LeftPanelViewController.h"
#import "NewsListViewController.h"
#import "HHNavigationController.h"
#import "HHShaeTool.h"

@implementation HHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.\
        __gColor=[UIColor red:240.0 green:240.0 blue:240.0 alpha:1];
    [self onInitRootViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)onInitRootViewController{
    __gScreenWidth=self.window.bounds.size.width;
    if (CURRENT_SYS_VERSION>=7.0) {//IOS 7 之后
        __gTopViewHeight=64.0;
        __gScreenHeight=self.window.bounds.size.height;
        __gOffY=20.0;
    }else{//ios 7 之前
        __gTopViewHeight=44.0;
        __gScreenHeight=self.window.bounds.size.height-20.0;
        __gOffY=0.0;
    }
    __gDocumentPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [[HHNetWorkEngine sharedHHNetWorkEngine] setHostName:[HHGlobalVarTool domianName]];

    
    XHDrawerController *drawerController = [[XHDrawerController alloc] init];
    drawerController.springAnimationOn = YES;
    
    LeftPanelViewController *leftPanelController=[[LeftPanelViewController alloc]  init];
    
    NewsListViewController *newsListController=[[NewsListViewController alloc]  init];
//    drawerController.leftViewController=[[HHNavigationController alloc]  initWithRootViewController:leftPanelController];
//    drawerController.centerViewController=[[HHNavigationController alloc]  initWithRootViewController:newsListController];
    drawerController.leftViewController=leftPanelController;
    drawerController.centerViewController=newsListController;
    HHNavigationController *rootNavController=[[HHNavigationController alloc]  initWithRootViewController:drawerController];
    rootNavController.navigationBarHidden=YES;
    self.window.rootViewController=rootNavController;
    [HHShaeTool setSharePlatform];
    [self setNavigationBar];
}
-(void)setNavigationBar{
    [[UINavigationBar appearance]  setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:31/255.0 green:71/255.0 blue:113/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    
}
@end
