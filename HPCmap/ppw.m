//
//  ppw.m
//  HPCmap
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "ppw.h"
#import "superppw.h"

@implementation ppw

@synthesize value1,value2;
@synthesize myppw;

-(void) dealloc{
    
    [value1 release];
    [value2 release];
    [myppw release];
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
    
    UIAlertView *alertDialog;
    
    float x = [value1.text floatValue];
    float y = [value2.text floatValue];
    //  float z = [wearyrs.text floatValue];
    
    myppw.text = [[[NSString alloc] initWithFormat:@"%4.1f %s",(x*1000/y),"MFlops/W"] autorelease];
    
    alertDialog = [[UIAlertView alloc] initWithTitle:@"Performance Per Watt" message:myppw.text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertDialog show];
    //[myppw release];
    [alertDialog release];
}


- (IBAction) hideKeyBoard1:(id)sender {
    [value1 resignFirstResponder];
   
}

- (IBAction) hideKeyBoard2:(id)sender {
    [value2 resignFirstResponder];
    
}

- (IBAction) clear {
    
    value1.text=nil;
    value2.text=nil;
 
}

- (void)calculatemod:(id)sender {
         
    superppw *mymodalview = [[superppw alloc] init];
         
    UINavigationController *cntrol = [[[UINavigationController alloc] initWithRootViewController:mymodalview] autorelease]; 
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:cntrol animated:YES];
    // [cntrol release]; 
    [mymodalview release];            
    
    
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
  /*
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
									 initWithTitle:@"Back" 
									 style:UIBarButtonItemStylePlain 
									 target:self 
									 action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
 	[cancelButton release];
  */ 
    
    UIBarButtonItem *calcButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Wiki" 
                                   style:UIBarButtonItemStylePlain 
                                   target:self 
                                   action:@selector(calculatemod:)];
	self.navigationItem.rightBarButtonItem = calcButton;
    self.navigationItem.title=@"PPW";
    //   self.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
    //   [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    //[self.navigationController dismissModalViewControllerAnimated:YES]; 
	[calcButton release];
    

    
    /*
  
     
     mytextview = [[UITextView alloc] initWithFrame:CGRectZero];
    mytextview.scrollEnabled = YES;
    mytextview.userInteractionEnabled = YES;
    mytextview.text = @"In computing, performance per watt is a measure of the energy efficiency of a particular computer architecture or computer hardware. Literally, it measures the rate of computation that can be delivered by a computer for every watt of power consumed." ;
    [mytextview setFrame:CGRectMake(0.0, 260.00, 320.0,288.00)];
    [mytextview setBackgroundColor:[UIColor colorWithRed:152.00 green:225.00 blue:254.00 alpha:1.0]];
    [self.view addSubview:mytextview];
    [mytextview release];
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
