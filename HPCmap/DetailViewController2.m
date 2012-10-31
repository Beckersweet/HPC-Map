//
//  DetailViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "DetailViewController2.h"
//#import "Favorites.h"
//#import "RootViewController2.h"

//@class HPCMapViewController;

@implementation DetailViewController2

@synthesize myimage,imageview,author,caption,imageData;
@synthesize bannerView,bannerIsVisible;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   
    
    if (self) {
        
         self.imageview.image = self.myimage;
        
        // Custom initialization
    }
    return self;
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

- (void)dealloc
{
    [bannerView release];
    [myimage release];
    [imageview release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (UIImage*)imageWithBorderFromImage:(UIImage*)source;
{
    CGSize size = [source size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 1.0, 1.0); 
    CGContextStrokeRect(context, rect);
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return testImg;
}

#pragma mark - Share pictures

// ANT: Generic Send button handler for email, FB, etc.
-(void)sendPicture:(id)sender
{
	// Typical iPhone solution is to show an action sheet
	UIActionSheet *sendSheet= [[UIActionSheet alloc] initWithTitle:@""
														  delegate:self
												 cancelButtonTitle:@"Cancel"
											destructiveButtonTitle:nil
												 otherButtonTitles:@"Email A Friend", @"Post to facebook", nil];
	
	[sendSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
			DebugLog(@"Emailing picture");
			[self sendEmail:nil];
			break;
		case 1:
			DebugLog(@"Posting picture to facebook");
			[self postToFacebook];
		default:
			break;
	}
}

- (void)postToFacebook
{
	FBHandler *fbHandler= [[FBHandler alloc] init];
	if (fbHandler)
	{
		fbHandler.attachedViewController= (id)self;
		[fbHandler postImage:myimage
				 withMessage:[NSString stringWithFormat:@"%@ from %@\n (Flickr Group Supercomputers)",self.caption,self.author]];
	}
	[fbHandler release];
}


-(void) sendEmail:(id)sender {
    
    MFMailComposeViewController *mailComposer;
    // NSArray *emailAddresses;
    // emailAddresses=[[NSArray alloc] initWithObjects:@"david@pimpgloves.com",nil];
    
    mailComposer=[[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate=self;
    //  mailComposer.title=@"HPC News";
    [mailComposer setMessageBody:[NSString stringWithFormat:@"%@ from %@\n (Flickr Group Supercomputers)\n",self.caption,self.author] isHTML:NO];
    [mailComposer setSubject:@"Picture from HPC Map"];
    [mailComposer addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"attachment.jpg"];
    // [mailComposer setToRecipients:emailAddresses];
    [self presentModalViewController:mailComposer animated:YES];
    // [self resignFirstResponder] ;
    // [emailAddresses release];
    [mailComposer release];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissModalViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    
    self.navigationItem.title = self.title ;

    imageview.contentMode  = UIViewContentModeScaleAspectFit;
    [imageview.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageview.layer setBorderWidth: 7.0];
          
    self.myimage = [self imageWithBorderFromImage:self.myimage];  
       
    self.imageview.image = self.myimage;
 
   //  NSLog(@"MyImage x size:%4.4f",self.imageview.image.size.width);
   //  NSLog(@"MyImage y size:%4.4f",self.imageview.image.size.height);
    
	
	if (StoredPayLevel == 0)
	{
		
		if (self.imageview.image.size.height != 240.0) {
			
		bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
		bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
		bannerView.delegate= self;
		if (bannerView !=nil) {
				[self.view addSubview:bannerView];
		}
		[bannerView release];
		
		self.bannerIsVisible = YES;
				
		}
	}
    
	// ANT: Change to email button to "Send" if FB is an option
    UIBarButtonItem *emailbutton= [UIBarButtonItem alloc];
	if ([FBHandler isSocialFrameworkAvailable])
		[emailbutton initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(sendPicture:)];
	else
		[emailbutton initWithTitle:@"Email A Friend" style:UIBarButtonItemStylePlain target:self action:@selector(sendEmail:)];
    
    //  self.navigationItem.rightBarButtonItem=favbutton;
    NSArray *rightButtonsArray = [[NSArray alloc] initWithObjects:emailbutton, nil];
    self.navigationItem.rightBarButtonItems = rightButtonsArray ;

    [rightButtonsArray release];
    [emailbutton release] ;
    
    /*
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData* imageData = [prefs objectForKey:@"myfavimage"];
    UIImage* myimagehere = [UIImage imageWithData:imageData];
   
    if(myimagehere != nil) {
    
     self.myimage = myimagehere ;
     self.imageview.image = self.myimage;
    
    } 
    */
        
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.myimage = nil ;
    self.imageview = nil ;
    
    
    
   // [Favorites nil];
    
   
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
