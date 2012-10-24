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
@synthesize delegate, quizClass, quizLevel, quizClasses;

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

#pragma mark - Actions
- (IBAction)levelButton:(UIButton *)sender
{
	self.quizClass= sender.tag;
	self.difficultyView.hidden= NO;
	
	self.level0Button.backgroundColor= [UIColor clearColor];
	self.level1Button.backgroundColor= [UIColor clearColor];
	self.level2Button.backgroundColor= [UIColor clearColor];
	sender.backgroundColor= [UIColor greenColor];
}

- (IBAction)difficultySlider:(UISlider *)sender
{
	self.quizLevel= lrintf(sender.value);
	sender.value= self.quizLevel;
}

- (IBAction)start
{
	[self.delegate quizLevelSelectViewControllerDidFinish:self];
}

- (IBAction)scores
{
	[self showLeaderboard];
}

#pragma mark GameCenter View Controllers
- (void)showLeaderboard
{
	GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
	if (leaderboardController != NULL)
	{
		leaderboardController.category= ((QuizClass *)self.quizClasses[self.quizClass]).leaderboard;
		leaderboardController.timeScope= GKLeaderboardTimeScopeAllTime;
		leaderboardController.leaderboardDelegate= (id)self;
		[self presentModalViewController:leaderboardController animated:YES];
	}
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[self dismissModalViewControllerAnimated: YES];
	//[viewController release];
}

@end
