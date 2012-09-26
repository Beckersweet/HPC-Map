//
//  pue.m
//  HPCmap
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "pue.h"
#import "modalView.h"

@implementation pue
@synthesize value1,value2,mypue;


-(void) dealloc{
    
    [value1 release];
    [value2 release];
    [mypue release];
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



- (void)calculatemod:(id)sender {
    
    
    
  //  thebutton=sender;
   
    
     modalView *mymodalview = [[modalView alloc] init];
   
  //  [modalView.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
       
                   
    UINavigationController *cntrol = [[[UINavigationController alloc] initWithRootViewController:mymodalview] autorelease]; 
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:cntrol animated:YES];
   // [cntrol release]; 
    [mymodalview release];            
              
                
}
 

- (IBAction) calculate {
    
    UIAlertView *alertDialog;
    
    float x = [value1.text floatValue];
    float y = [value2.text floatValue];
    //  float z = [wearyrs.text floatValue];
    
    mypue.text = [[[NSString alloc] initWithFormat:@"%4.1f %s",(x/y),""] autorelease];
    
    alertDialog = [[UIAlertView alloc] initWithTitle:@"PUE" message:mypue.text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertDialog show];
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
    mypue.textColor=nil;
   // value3.text=nil;
    //  pue=nil;
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
    self.navigationItem.title=@"PUE";
 //   self.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
 //   [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    //[self.navigationController dismissModalViewControllerAnimated:YES]; 
	[calcButton release];

   /*
    mytextview = [[UITextView alloc] initWithFrame:CGRectZero];
    mytextview.scrollEnabled = YES;
    mytextview.userInteractionEnabled = YES;
    mytextview.text = @"Power usage effectiveness (PUE) is a measure of how efficiently a computer data center uses its power; specifically, how much of the power is actually used by the computing equipment (in contrast to cooling and other overhead). PUE is the ratio of total amount of power used by a computer data center facility to the power delivered to computing equipment. PUE was developed by a consortium called The Green Grid. PUE is the inverse of data center infrastructure efficiency (DCiE). An ideal PUE is 1.0. Anything that isn't considered a computing device in a data center (i.e. lighting, cooling, etc.) falls into the category of facility power usage." ;
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
