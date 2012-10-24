//
//  HPCMapAppDelegate.h
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCHandler.h"

@class HPCMapViewController;

@interface HPCMapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
  //  UIViewController *viewController;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet UIViewController *viewController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

