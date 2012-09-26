//
//  DetailViewController.h
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

//@class Favorites;
 
@interface DetailViewController2 : UIViewController <ADBannerViewDelegate,MFMailComposeViewControllerDelegate> {
 
 // Favorites *myfavorites;
    UIImage *myimage;
    UIImageView *imageview;
   

}

@property (nonatomic, retain) IBOutlet UIImageView *imageview;
@property (nonatomic, retain)  UIImage *myimage ;
@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic,assign) BOOL bannerIsVisible;
@property (nonatomic,retain) NSString *author;
@property (nonatomic,retain) NSString *caption;
@property (nonatomic,retain) NSData *imageData ;

@end
