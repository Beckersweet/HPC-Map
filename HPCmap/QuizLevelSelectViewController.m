//
//  QuizLevelSelectViewController.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-22.
//
//

#import "QuizLevelSelectViewController.h"

@interface QuizLevelSelectViewController ()

@end

@implementation QuizLevelSelectViewController
@synthesize level0Button, level1Button, level2Button, difficultyView, difficultySlider, startButton, scoreButton;
@synthesize delegate, quizClass, quizLevel, purchasedLevel, quizClasses;
@synthesize payEasyLabel, payHardLabel, payMediumLabel;
@synthesize askEasyLabel, askHardLabel, askMediumLabel;
@synthesize waiting, waitView;

#pragma mark - Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self loadQuizClassData];
	[self loadPurchaseHistory];
	self.difficultyView.hidden= YES;
	
	[self.level0Button setTitle:((QuizClass *)quizClasses[0]).name forState:UIControlStateNormal];
	[self.level0Button setTitle:((QuizClass *)quizClasses[0]).name forState:UIControlStateHighlighted];
	[self.level1Button setTitle:((QuizClass *)quizClasses[1]).name forState:UIControlStateNormal];
	[self.level1Button setTitle:((QuizClass *)quizClasses[1]).name forState:UIControlStateHighlighted];
	[self.level2Button setTitle:((QuizClass *)quizClasses[2]).name forState:UIControlStateNormal];
	[self.level2Button setTitle:((QuizClass *)quizClasses[2]).name forState:UIControlStateHighlighted];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data
- (void)loadQuizClassData
{
	NSArray *allClasses= [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuizClasses" ofType:@"plist"]];
	self.quizClasses= [[NSMutableArray alloc] init];
	
	for (int i= 0; i<([allClasses count]); i++)
	{
		QuizClass *q= [[QuizClass alloc] initWithData:allClasses[i]];
		[self.quizClasses addObject:q];
	}
}

- (void)loadPurchaseHistory
{
	NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
	
	// TODO: Maybe we should do something special for first time run
	self.purchasedLevel= [prefs integerForKey:kPurchasedLevelKey];
}

- (void)savePurchaseHistory
{
	NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
	[prefs setInteger:self.purchasedLevel forKey:kPurchasedLevelKey];
	[prefs synchronize];
}

#pragma mark - Actions
- (IBAction)levelButton:(UIButton *)sender
{
	self.quizClass= sender.tag;
	self.quizLevel= 0;		// defaulting to easy
	
	// Clear other buttons
	[self.level0Button setImage:nil forState:UIControlStateNormal];
	[self.level0Button setImage:nil forState:UIControlStateHighlighted];
	[self.level1Button setImage:nil forState:UIControlStateNormal];
	[self.level1Button setImage:nil forState:UIControlStateHighlighted];
	[self.level2Button setImage:nil forState:UIControlStateNormal];
	[self.level2Button setImage:nil forState:UIControlStateHighlighted];

	// Set checkmark
	[sender setImage:[UIImage imageNamed:@"117-todo.png"] forState:UIControlStateNormal];
	[sender setImage:[UIImage imageNamed:@"117-todo.png"] forState:UIControlStateHighlighted];	

	[self showDifficultyView];
}

- (IBAction)difficultySlider:(UISlider *)sender
{
	self.quizLevel= lrintf(sender.value);
	sender.value= self.quizLevel;
	
	NSString *payLevels= ((QuizClass *)self.quizClasses[self.quizClass]).payLevels;
	if ([payLevels length] > 0 && self.purchasedLevel < requiredPayLevel(self.quizLevel))
	{
		// Asked for a paid level quiz
		// Reset selected level to easy/free
		self.quizLevel= 0;
		sender.value= 0;
		
		// See if they would like to purchase
		UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"Level Purchase Required"
													   message:@"You have selected a paid level quiz\nYou need to purchase this level to continue"
													  delegate:self
											 cancelButtonTitle:@"Never mind"
											 otherButtonTitles:@"Purchase now", @"Restore my purchase", nil];
		alert.tag= kTagAlertViewPurchaseRestore;
		[alert show];
	}
}

- (IBAction)start
{
	[self.delegate quizLevelSelectViewControllerDidFinish:self];
}

- (IBAction)scores
{
	[self.delegate showGameCenterLeaderboards:self];
}

#pragma mark - Delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (alertView.tag)
	{
		case kTagAlertViewPurchaseRestore:
			DebugLog(@"Purchase button %d:%@",buttonIndex, [alertView buttonTitleAtIndex:buttonIndex]);
			// We're here, so there is a good chance that we will need in-app
			[[InAppPurManager sharedInstance] setCallingController:self];
			switch (buttonIndex)
			{
				case 0:	// Cancel
					
					break;
				case 1:	// Purchase
					// Init in-app purchase stuff. Our init procedure automatically buys if there is only one item to buy
					[self showWaiting:YES];
					[[InAppPurManager sharedInstance] requestProductData];
					break;
				case 2:	// Restore
					[self showWaiting:YES];
					[[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
					break;
				default:
					break;
			}
			break;
			
		default:
			break;
	}
}

- (void)purchaseCompleted
{
	[self loadPurchaseHistory];
	[self hideWaiting];
	[self showDifficultyView];
}

#pragma mark - Visuals
- (void)showDifficultyView
{
	// Difficulty view
	self.difficultyView.hidden= NO;
	
	// show pay levels if they haven't purchased
	NSString *payLevels= ((QuizClass *)self.quizClasses[self.quizClass]).payLevels;

	// First clear the labels that might change
	self.payEasyLabel.text=   @"   ";
	self.payMediumLabel.text= @"   ";
	self.payHardLabel.text=   @"   ";
	
	if ([payLevels length] > 0 && self.purchasedLevel < requiredPayLevel(0))
		self.payEasyLabel.text=		[@"$$$" substringWithRange:NSMakeRange(0, requiredPayLevel(0))];
	if ([payLevels length] > 1 && self.purchasedLevel < requiredPayLevel(1))
		self.payMediumLabel.text=	[@"$$$" substringWithRange:NSMakeRange(0, requiredPayLevel(1))];
	if ([payLevels length] > 2 && self.purchasedLevel < requiredPayLevel(2))
		self.payHardLabel.text=		[@"$$$" substringWithRange:NSMakeRange(0, requiredPayLevel(2))];
	
	// set difficulty levels
	NSString *difficultyLevels= ((QuizClass *)self.quizClasses[self.quizClass]).difficulties;
	
	self.difficultySlider.maximumValue= [difficultyLevels length]-1;
	self.difficultySlider.value= 0;
	
	// NOTE: only handling 01 and 012 conditions. Assuming we won't have 111, 210, 222, etc.
	if ([difficultyLevels length] == 2)
	{
		// Assuming 01
		self.askMediumLabel.text= kDifficultyLevelTextBlank;
		self.askHardLabel.text= kDifficultyLevelTextMedium;
	}
	else
	{
		// Assuming 012
		self.askMediumLabel.text= kDifficultyLevelTextMedium;
		self.askHardLabel.text= kDifficultyLevelTextHard;
	}
	
	// Simulate slider action
	[self difficultySlider:self.difficultySlider];
}

- (void)showWaiting:(BOOL)show;
{
	self.waitView.hidden= !show;
	if (show)
		[self.waiting startAnimating];
	else
		[self.waiting stopAnimating];
}

- (void)showWaiting
{
	[self showWaiting:YES];
}

- (void)hideWaiting
{
	[self showWaiting:NO];
}

@end
