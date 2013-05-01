//
//  CalculateModalView.m
//  HPCmap
//
//  Created by Barbara Collignon on 4/18/13.
//
//

#import "CalculateModalView.h"

@interface CalculateModalView ()

@end

@implementation CalculateModalView

@synthesize detailWebView, subscribe ;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissView {
    
    [self dismissModalViewControllerAnimated:YES];

    
}

-(IBAction)subscribe:(id)sender{
    
    self.detailURL= [[[NSURL alloc] initWithString:@"http://www.beckersweet.com/wp/?page_id=41"] autorelease] ;
    [detailWebView loadRequest:[NSURLRequest requestWithURL:self.detailURL]];

    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain
                                                                    target:self action:@selector(dismissView)];
    self.navigationItem.rightBarButtonItem = cancelButton;
 
    [self.navigationItem setTitle:@"Coming soon...   "];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [super dealloc];
    [detailWebView release];
    [subscribe release];
   
    
}

@end
