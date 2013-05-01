//
//  CalculateViewController.h
//  HPCmap
//
//  Created by Barbara Collignon on 3/22/13.
//
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface CalculateViewController : UIViewController <ADBannerViewDelegate,UIWebViewDelegate> {

// UIWebView *detailWebView;
// NSURL *detailURL;
    
}

//@property (nonatomic,retain) NSURL *detailURL;
//@property (nonatomic, retain) IBOutlet UIWebView *detailWebView;
@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic,assign) BOOL bannerIsVisible;

@property(nonatomic,retain) IBOutlet UIButton *hub ;
@property(nonatomic,retain) IBOutlet UIButton *team ;
@property(nonatomic,retain) IBOutlet UIButton *source ;
@property(nonatomic,retain) IBOutlet UIButton *compute ;
@property(nonatomic,retain) IBOutlet UIButton *monitor ;



-(IBAction)showBackView:(id)sender ;
-(IBAction)showBackView2:(id)sender ;
-(IBAction)showBackView3:(id)sender ;
-(IBAction)showBackView4:(id)sender ;
-(IBAction)showBackView5:(id)sender ;

@end
