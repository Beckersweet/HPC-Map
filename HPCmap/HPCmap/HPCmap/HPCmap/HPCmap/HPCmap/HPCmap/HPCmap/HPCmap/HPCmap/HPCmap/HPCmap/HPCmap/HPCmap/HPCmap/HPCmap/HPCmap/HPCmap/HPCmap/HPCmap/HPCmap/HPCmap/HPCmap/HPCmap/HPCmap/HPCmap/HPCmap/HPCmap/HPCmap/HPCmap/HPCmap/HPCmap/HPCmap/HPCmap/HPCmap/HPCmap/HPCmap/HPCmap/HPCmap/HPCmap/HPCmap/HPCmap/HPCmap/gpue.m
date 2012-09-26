//
//  gpue.m
//  GloveCatalogue
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "gpue.h"
#import "supergpue.h"

@implementation gpue

@synthesize value1,value2,value3,value4;
@synthesize mygpue,myg,mygpue2;

-(void)dealloc{
    
    [myg release];
    [mygpue release];
    [mygpue2 release];
    [value1 release];
    [value2 release];
    [value3 release];
    [value4 release];
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
    float y = [value2.text floatValue];
    float z = [value3.text floatValue];
    float t = [value4.text floatValue];
    
    myg.text=[[[NSString alloc] initWithFormat:@"%4.2f",(y/100*(1+1.050) + (z/100*(1+0.013)) + (t/100*(1+1.050)))]autorelease];
    float g = [myg.text floatValue];
    mygpue.text = [[[NSString alloc] initWithFormat:@"%4.2f",(g*x)]autorelease];
    
    mygpue2.text = [[[NSString alloc] initWithFormat:@"%4.2f",((g-1)*x)]autorelease];
    
    /*
    alertDialog = [[UIAlertView alloc] initWithTitle:@"GPUE" message:mygpue.text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertDialog show];
    //[mygpue release];
    [alertDialog release];
     */
}

- (void)calculatemod:(id)sender {
           
    supergpue *mymodalview = [[supergpue alloc] init];
    
       
    UINavigationController *cntrol = [[[UINavigationController alloc] initWithRootViewController:mymodalview] autorelease]; 
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:cntrol animated:YES];
    // [cntrol release]; 
    [mymodalview release];            
      
}

- (IBAction) hideKeyBoard1:(id)sender {
    
    [value1 resignFirstResponder];
}

- (IBAction) hideKeyBoard2:(id)sender {
    
    [value2 resignFirstResponder];
}

- (IBAction) hideKeyBoard3:(id)sender {
    
    [value3 resignFirstResponder];
}

- (IBAction) hideKeyBoard4:(id)sender {
    
    [value4 resignFirstResponder];
}

- (IBAction) clear {
    
    value1.text=nil;
    value2.text=nil;
    value3.text=nil;
    value4.text=nil;
    mygpue.text=nil;
    myg.text=nil;
    mygpue2.text=nil;
}

- (void)cancel:(id)sender {
	//self.selectedImage = nil;
    //	CustomImagePickerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
   
    UIBarButtonItem *calcButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Wiki" 
                                   style:UIBarButtonItemStylePlain 
                                   target:self 
                                   action:@selector(calculatemod:)];
	self.navigationItem.rightBarButtonItem = calcButton;
    self.navigationItem.title=@"GPUE";
    
	[calcButton release];

    
    /*
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
									 initWithTitle:@"Back" 
									 style:UIBarButtonItemStylePlain 
									 target:self 
									 action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
 	[cancelButton release];
    */
    
    /*
    mytextview = [[UITextView alloc] initWithFrame:CGRectZero];
    mytextview.scrollEnabled = YES;
    mytextview.userInteractionEnabled = YES;
    mytextview.text = @"Green Power usage effectiveness (GPUE) is a proposed measurement of both how much sustainable energy a computer data center uses, its carbon footprint per usable Kwh and how efficiently it uses its power; specifically, how much of the power is actually used by the computing equipment (in contrast to cooling and other overhead). It is an addition to the PUE definition and was first proposed by Greenqloud.[1]      GPUE is a way to “weigh” the PUE to better see which data centers are truly green in the sense that they indirectly cause the least amount of CO2 to be emitted by their use of sustainable or unsustainable energy sources." ;
    [mytextview setFrame:CGRectMake(0.0, 172.00, 320.0,288.00)];
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
