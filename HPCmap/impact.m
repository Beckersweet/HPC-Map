//
//  impact.m
//  HPCmap
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "impact.h"
#import "superimpact.h"

@implementation impact

@synthesize myimpact1,myimpact2,myimpact3,myimpact4;
@synthesize value1;

-(void) dealloc{
    
    [myimpact1 release];
    [myimpact2 release];
    [myimpact3 release];
    [myimpact4 release];
    [value1 release];
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction) calculate {
    
   // UIAlertView *alertDialog;
    
    float x = [value1.text floatValue];
    float trees=16.00000000;
    float cars=1.000000000;
    float co2=4747.000000;
    
    // float y = [value2.text floatValue];
    // float z = [wearyrs.text floatValue];
    
    myimpact1.text = [[[NSString alloc] initWithFormat:@"%4.1f",(x*trees)] autorelease] ;
 // result1.text = [[[NSString alloc] initWithFormat:@"%4.1f",(x*trees)] autorelease] ;
    myimpact2.text = [[[NSString alloc] initWithFormat:@"%4.1f",(x*cars)] autorelease];
 
    myimpact3.text = [[[NSString alloc] initWithFormat:@"%4.1f",(x*co2)] autorelease];

}

- (IBAction) hideKeyBoard:(id)sender {
    [value1 resignFirstResponder];
}

- (IBAction) clear {
    
    value1.text=nil;
    myimpact1.text=nil;
    myimpact2.text=nil;
    myimpact3.text=nil;
    myimpact4.text=nil;
    
}

- (void)cancel:(id)sender {
	//self.selectedImage = nil;
    //	CustomImagePickerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}


#pragma mark - View lifecycle

- (void)calculatemod:(id)sender {
    
    
    
    //  thebutton=sender;
    
    
    superimpact *mymodalview = [[superimpact alloc] init];
    
    //  [modalView.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    
    UINavigationController *cntrol = [[[UINavigationController alloc] initWithRootViewController:mymodalview] autorelease]; 
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:cntrol animated:YES];
    // [cntrol release]; 
    [mymodalview release];            
      
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.value1.userInteractionEnabled=YES;
   
    /*
    UIBarButtonItem *calcButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Wiki" 
                                   style:UIBarButtonItemStylePlain 
                                   target:self 
                                   action:@selector(calculatemod:)];
	self.navigationItem.rightBarButtonItem = calcButton;
     
     */
    self.navigationItem.title=@"Environmental Impact";
    //   self.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
    //   [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    //[self.navigationController dismissModalViewControllerAnimated:YES]; 
	//[calcButton release];

  /*
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
									 initWithTitle:@"Back" 
									 style:UIBarButtonItemStylePlain 
									 target:self 
									 action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
 	[cancelButton release];
   */
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
    
