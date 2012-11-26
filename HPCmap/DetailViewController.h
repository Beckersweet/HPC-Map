//
//  DetailViewController.h
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <QuartzCore/QuartzCore.h>
#import "CommonDefines.h"

//@class Favorites;

@interface DetailViewController : UIViewController <ADBannerViewDelegate, UIWebViewDelegate> {
 
 //   Favorites *myfavorites;
    UIWebView *detailWebView;
    NSURL *detailURL;
    UIToolbar *bottomBar;
    UIBarButtonItem *item;
    UIImage *myimage;
    Boolean yourBOOL;
    NSString *myname;
    
}

@property (nonatomic,assign) Boolean yourBOOL;
@property (nonatomic,retain) NSURL *detailURL;
@property (nonatomic,retain) NSString *myname;
@property (nonatomic,retain) UIImage *myimage;
@property (nonatomic, retain) IBOutlet UIWebView *detailWebView;
@property (nonatomic, retain) IBOutlet UIToolbar *bottomBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *item;
@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic,assign) BOOL bannerIsVisible;


-(IBAction)AddtoFavorites;

@end
