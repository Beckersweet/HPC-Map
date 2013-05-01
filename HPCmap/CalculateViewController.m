//
//  CalculateViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 3/22/13.
//
//

#import "CalculateViewController.h"
#import "CalculateModalView.h"

@interface CalculateViewController ()

@end

@implementation CalculateViewController

@synthesize bannerIsVisible, bannerView ;
@synthesize  hub, source, team, compute, monitor ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)showBackView:(id)sender{
    
    CalculateModalView *myModalView = [[CalculateModalView alloc] init];
    //myModalView.delegate = (id)self ;
    
    UINavigationController *mynavig = [[UINavigationController alloc] initWithRootViewController:myModalView];
    
    [self presentViewController:mynavig animated:YES completion: nil];
    
    //[self presentViewController:myModalView animated:YES completion: nil];
    [myModalView release];
    [mynavig release];
    
    
}

-(IBAction)showBackView2:(id)sender{
    
    CalculateModalView *myModalView = [[CalculateModalView alloc] init];
    //myModalView.delegate = (id)self ;
    
    UINavigationController *mynavig = [[UINavigationController alloc] initWithRootViewController:myModalView];
    
    [self presentViewController:mynavig animated:YES completion: nil];
    
    //[self presentViewController:myModalView animated:YES completion: nil];
    [myModalView release];
    [mynavig release];
    
}

-(IBAction)showBackView3:(id)sender{
    
    CalculateModalView *myModalView = [[CalculateModalView alloc] init];
    //myModalView.delegate = (id)self ;
    
    UINavigationController *mynavig = [[UINavigationController alloc] initWithRootViewController:myModalView];
    
    [self presentViewController:mynavig animated:YES completion: nil];
    
    //[self presentViewController:myModalView animated:YES completion: nil];
    [myModalView release];
    [mynavig release];
    
}

-(IBAction)showBackView4:(id)sender{
    
    CalculateModalView *myModalView = [[CalculateModalView alloc] init];
    //myModalView.delegate = (id)self ;
    
    UINavigationController *mynavig = [[UINavigationController alloc] initWithRootViewController:myModalView];
    
    [self presentViewController:mynavig animated:YES completion: nil];
    
    //[self presentViewController:myModalView animated:YES completion: nil];
    [myModalView release];
    [mynavig release];
    
}

-(IBAction)showBackView5:(id)sender{
    
    CalculateModalView *myModalView = [[CalculateModalView alloc] init];
    //myModalView.delegate = (id)self ;
    
    UINavigationController *mynavig = [[UINavigationController alloc] initWithRootViewController:myModalView];
    
    [self presentViewController:mynavig animated:YES completion: nil];
    
    //[self presentViewController:myModalView animated:YES completion: nil];
    [myModalView release];
    [mynavig release];
    
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



 
- (void)viewDidLoad
{
    [super viewDidLoad];
 //   self.detailURL= [[[NSURL alloc] initWithString:@"http://www.beckersweet.com"] autorelease] ;
  //  [detailWebView loadRequest:[NSURLRequest requestWithURL:self.detailURL]];

 // detailWebView.delegate = self ;

    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
   CGPoint bottomOffset = CGPointMake(0,webView.scrollView.contentSize.height - webView.scrollView.bounds.size.height);
    
  //  CGPoint bottomOffset = CGPointMake(30,300);
    [webView.scrollView setContentOffset:bottomOffset animated:NO];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)dealloc{
    
 //   [detailWebView release];
  //  [detailURL release];
    [bannerView release];
    [super dealloc];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
