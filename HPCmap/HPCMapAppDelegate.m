//
//  HPCMapAppDelegate.m
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "HPCMapAppDelegate.h"
#import "HPCMapViewController.h"
#import "RootViewController.h"
#import "RootViewController2.h"
#import "QuizzViewController.h"
#import "FBNewsViewController.h"
#import	"InAppPurManager.h"

@implementation HPCMapAppDelegate

@synthesize window;
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   // sleep(10) ;
    
	[InAppPurManager sharedInstance];
	
    HPCMapViewController *mymap = [[HPCMapViewController alloc]init];
    RootViewController *myroot = [[RootViewController alloc] init];
    RootViewController2 *myroot2 = [[RootViewController2 alloc] init]; 
    QuizzViewController *myquizz = [[QuizzViewController alloc] init];
    FBNewsViewController *fbnews = [[FBNewsViewController alloc] init];
      
    UINavigationController *navig1 = [[UINavigationController alloc] initWithRootViewController:myroot];
    UINavigationController *navig2 = [[UINavigationController alloc] initWithRootViewController:myroot2];
    UINavigationController *navig3 = [[UINavigationController alloc] initWithRootViewController:mymap];
    
    
    NSArray* controllers = [NSArray arrayWithObjects:navig3,navig2,fbnews,navig1,myquizz,nil];
    
   // NSArray* controllers = [NSArray arrayWithObjects:myquizz,nil];
          
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"HPC Map" image:[UIImage imageNamed:@"07-map-marker.png"] tag:0];
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Calculate" image:[UIImage imageNamed:@"161-calculator.png"] tag:0];
    UITabBarItem *tabBarItem3 =  [[UITabBarItem alloc] initWithTitle:@"Explore" image:[UIImage imageNamed:@"42-photos.png"] tag:0]; 
    UITabBarItem *tabBarItem4 =  [[UITabBarItem alloc] initWithTitle:@"Play Smart" image:[UIImage imageNamed:@"84-lightbulb.png"] tag:0];
     UITabBarItem *tabBarItem5 =  [[UITabBarItem alloc] initWithTitle:@"News" image:[UIImage imageNamed:@"09-chat-2.png"] tag:0];
    
   
    navig3.tabBarItem=tabBarItem;
    navig1.tabBarItem=tabBarItem2;
    navig2.tabBarItem=tabBarItem3;
    myquizz.tabBarItem=tabBarItem4;
    fbnews.tabBarItem=tabBarItem5;
       
    [tabBarItem release];
    [tabBarItem2 release];
    [tabBarItem3 release];
    [tabBarItem4 release];
    [tabBarItem5 release];
    
    tabBarController.viewControllers = controllers;
    
    //navig1.navigationItem.title=@"Green HPC";
    
    //navig2.navigationItem.title=@"Supercomputers";
    navig1.navigationBar.barStyle=UIBarStyleBlackTranslucent;
    navig2.navigationBar.barStyle=UIBarStyleBlack;
    navig3.navigationBar.barStyle=UIBarStyleBlack;
      
    
    //  self.window.rootViewController = self.navigationController;
    self.window.rootViewController = self.tabBarController;
    
   // [window addSubview: viewController.view];
    [window makeKeyAndVisible];
    
    [myquizz release];
    [mymap release];
    [myroot release];
    [myroot2 release];
    [navig1 release];
    [navig2 release];
    [navig3 release];
    [fbnews release];

    return YES;

}

- (void)dealloc {
  //  [viewController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

#pragma mark - App backgrounding
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	DebugLog(@"Entered background");
	
	UIApplication  *app = [UIApplication sharedApplication];
	UIBackgroundTaskIdentifier bgTask;
	
	bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
	}];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	DebugLog(@"Entered active state");
}


@end
