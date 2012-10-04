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
#import <MessageUI/MessageUI.h>
#import "FBHandler.h"

//@class Favorites;
 
@interface DetailViewController2 : UIViewController <ADBannerViewDelegate,MFMailComposeViewControllerDelegate, UIActionSheetDelegate> {
 
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

// ANT: Declare methods to use directly
-(void)sendPicture:(id)sender;
- (void)postToFacebook;
-(void) sendEmail:(id)sender;


@end
