//
//  DetailViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "DetailViewController.h"
//#import "Favorites.h"
//#import "RootViewController.h"

@class HPCMapViewController;

@implementation DetailViewController

@synthesize bannerView, bannerIsVisible, detailURL,detailWebView,bottomBar,item,yourBOOL,myimage,myname;

-(IBAction)AddtoFavorites {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:self.title forKey:@"myfavname"];
    [prefs setObject:self.myimage forKey:@"myfavimage"];
    [prefs synchronize];
    
    UIAlertView *alertDialogue;
    
    alertDialogue = [[UIAlertView alloc] initWithTitle:@"Go to Favorites" message:@"Push the Add button" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alertDialogue show];
    [alertDialogue release];
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [detailWebView release];
    [detailURL release];
    [bottomBar release];
    [item release];
    [bannerView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
/*
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    CGRect frame = detailWebView.frame;
   
    frame.size.height = 1;
    detailWebView.frame = frame;
    CGSize fittingSize = [detailWebView sizeThatFits:CGSizeMake(600, 600)];
    frame.size = fittingSize;
    
    detailWebView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
        
}
 */

- (void)viewDidLoad
{
	if (StoredPayLevel == 0)
	{
		bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];

		bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
		self.bannerView.delegate= self;
		if (bannerView !=nil) {
			[self.view addSubview:bannerView];
		}
		[bannerView release];
		
		self.bannerIsVisible = YES;
	}
   

    detailWebView.delegate= self;
	detailWebView.opaque= NO;
	
    //set ourselves as the frame load delegate so we know when the window loads
  // [detailWebView setFrameLoadDelegate:self];
    
   // detailWebView= [[UIWebView alloc] init];
    
   // detailWebView.delegate = nil;
//    detailWebView.scrollView.scrollEnabled = NO;
//    detailWebView.scalesPageToFit = YES;
//    detailWebView.contentMode = UIViewContentModeScaleAspectFit ;
    //load the page
    [detailWebView loadRequest:[NSURLRequest requestWithURL:self.detailURL]];
     self.navigationItem.title = self.title ;
  //  self.item.title=@"Add To Favorites";

  //  UIBarButtonItem *favbutton = [[UIBarButtonItem alloc] initWithTitle:@"Favorite" style:UIBarButtonItemStylePlain target:self action:@selector(AddtoFavorites)];
    
  //  self.navigationItem.rightBarButtonItem=favbutton;
   // [favbutton release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   // [Favorites nil];
    
    self.item=nil;
    self.bottomBar =nil;
    self.detailURL=nil;
    self.detailWebView=nil;
    self.bannerView = nil;
    self.bannerView.delegate=nil;
    self.detailWebView.delegate=nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - webView delegates
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	CGSize contentSize= webView.scrollView.contentSize;
	CGSize viewSize= self.view.bounds.size;
	
	float rw= viewSize.width / contentSize.width;
	
	webView.scrollView.minimumZoomScale= rw;
	webView.scrollView.maximumZoomScale= rw;
	webView.scrollView.zoomScale= rw;
}

@end
