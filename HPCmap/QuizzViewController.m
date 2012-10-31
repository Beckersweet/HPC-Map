//
//  ViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 1/12/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "QuizzViewController.h"

@implementation QuizzViewController

@synthesize QuestionLabel,AnswerA,AnswerB,AnswerC,AnswerD;
@synthesize buttonA,buttonB,buttonC,buttonD;
@synthesize xofy,score,result, elapsed;
@synthesize next,startover,ask;
@synthesize toolbar;

@synthesize questions, nextQuestionIndex, quizClass, quizLevel, startTime;
@synthesize currentQuestion, currentQuizClass, randomized, quizRunning, gcHandler;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	// Init Gamecenter stuff
	[[GCHandler sharedInstance] authenticateLocalUser];
	
    iquizz=0;
    iscore=0;
    
//    self.xofy.text= [NSString stringWithFormat:@"%d of 50",iquizz+1];
//    self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    
    UIFont *locationFont = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:18];
    //UIFont *locationFont2 = [UIFont fontWithName:@"Arial" size:8];
    
    QuestionLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 38, 320, 100)];
    //tweetLabel.font=[UIFont systemFontSize:14];
    QuestionLabel.font=locationFont;
    QuestionLabel.numberOfLines=6;
    QuestionLabel.textAlignment=UITextAlignmentCenter;
    QuestionLabel.backgroundColor=[UIColor clearColor];
       
    AnswerA=[[UILabel alloc] initWithFrame:CGRectMake(113, 183, 320, 21)];
    AnswerB=[[UILabel alloc] initWithFrame:CGRectMake(113, 228, 320, 21)];
    AnswerC=[[UILabel alloc] initWithFrame:CGRectMake(113, 273, 320, 21)];
    AnswerD=[[UILabel alloc] initWithFrame:CGRectMake(113, 317, 320, 21)];
    
    AnswerA.backgroundColor=[UIColor clearColor];
    AnswerB.backgroundColor=[UIColor clearColor];
    AnswerC.backgroundColor=[UIColor clearColor];
    AnswerD.backgroundColor=[UIColor clearColor];
    
    AnswerA.font=locationFont;
    AnswerB.font=locationFont;
    AnswerC.font=locationFont;
    AnswerD.font=locationFont;

	// ANT: We'll read questions from a file now
//    Question.text=@"What was the name of the first supercomputer ?";
//    AnswerA.text=@"CDC 6600";
//    AnswerB.text=@"Bull";
//    AnswerC.text=@"Univac";
//    AnswerD.text=@"DataPlex";

	// Quiz defaults
	self.nextQuestionIndex= 0;
	self.quizClass= kQuizClass1;
	self.quizLevel= kQuizLevelEasy;

    [self.view addSubview:QuestionLabel];
    [self.view addSubview:AnswerA];
    [self.view addSubview:AnswerB];
    [self.view addSubview:AnswerC];
    [self.view addSubview:AnswerD];
    
  //  score = [[UILabel alloc] init];
   //Question = [[UILabel alloc] init];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self fillQuestionForm];
	[self askForLevel];
	
}

- (void)fillQuestionForm
{
//	DebugLog(@"Questions data:\n%@", [Question describeClassInstance:self.questions classType:[Question class]]);

	self.xofy.text= [NSString stringWithFormat:@"%d of %d",iquizz+1, [Question questionCount:self.quizClass inQuestions:self.questions]];
    self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];

	self.currentQuestion= [Question getNextQuestion:self.questions index:nextQuestionIndex class:self.quizClass];
	DebugLog(@"Asking Q%d:%@",self.nextQuestionIndex, self.currentQuestion.question);
	if (self.currentQuestion != nil)
	{
		QuestionLabel.text=self.currentQuestion.question;
		
		self.AnswerA.textColor=[UIColor blackColor];
		self.AnswerB.textColor=[UIColor blackColor];
		self.AnswerC.textColor=[UIColor blackColor];
		self.AnswerD.textColor=[UIColor blackColor];
		
		self.AnswerA.text=self.currentQuestion.answers[0];
		self.AnswerB.text=self.currentQuestion.answers[1];
		self.AnswerC.text=self.currentQuestion.answers[2];
		self.AnswerD.text=self.currentQuestion.answers[3];

		self.buttonA.enabled= YES;
		self.buttonB.enabled= YES;
		self.buttonC.enabled= YES;
		self.buttonD.enabled= YES;
		
		[self.next setTitle:@"Next"];
	}
	
	if (iquizz == [Question questionCount:self.quizClass inQuestions:self.questions]-1)
	{
		[self.next setTitle:@"Finish"];
	}
}

#pragma mark - Ask A Friend
- (IBAction)askAFriend:(id)sender
{
	if ([FBHandler isSocialFrameworkAvailable])
	{
		// Typical iPhone solution is to show an action sheet
		UIActionSheet *sendSheet= [[UIActionSheet alloc] initWithTitle:@""
															  delegate:self
													 cancelButtonTitle:@"Cancel"
												destructiveButtonTitle:nil
													 otherButtonTitles:@"Ask via email", @"Ask via facebook", nil];
		
		[sendSheet showFromTabBar:self.tabBarController.tabBar];
		[sendSheet release];
	}
	else
		[self sendEmail:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
			DebugLog(@"Emailing question");
			[self sendEmail:nil];
			break;
		case 1:
			DebugLog(@"Posting question to facebook");
			[self postToFacebook];
		default:
			break;
	}
}

- (void)sendEmail:(id)sender
{
    
    MFMailComposeViewController *mailComposer;
    // NSArray *emailAddresses;
    // emailAddresses=[[NSArray alloc] initWithObjects:@"david@pimpgloves.com",nil];
    
    mailComposer=[[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate=self;
    //  mailComposer.title=@"HPC News";
    [mailComposer setMessageBody:[NSString stringWithFormat:@"%@\n\nA:%@\nB:%@\nC:%@\nD:%@\n",QuestionLabel.text,AnswerA.text,AnswerB.text,AnswerC.text,AnswerD.text] isHTML:NO];
    [mailComposer setSubject:@"Question from HPC Map"];
    
    // [mailComposer setToRecipients:emailAddresses];
    [self presentModalViewController:mailComposer animated:YES];
    // [self resignFirstResponder] ;
    // [emailAddresses release];
    [mailComposer release];
    
}

- (void)postToFacebook
{
	FBHandler *fbHandler= [[FBHandler alloc] init];
	if (fbHandler)
	{
		fbHandler.attachedViewController= (id)self;
		[fbHandler postMessage:[NSString stringWithFormat:@"Question from HPC Map\n\n%@\n\nA:%@\nB:%@\nC:%@\nD:%@\n",QuestionLabel.text,AnswerA.text,AnswerB.text,AnswerC.text,AnswerD.text]];
	}
	[fbHandler release];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - GameCenter
- (void)showLeaderboard
{
	GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
	if (leaderboardController != NULL)
	{
		leaderboardController.category= self.currentQuizClass.leaderboard;
		leaderboardController.timeScope= GKLeaderboardTimeScopeAllTime;
		leaderboardController.leaderboardDelegate= (id)self;
		[self presentModalViewController:leaderboardController animated:YES];
	}
	return;
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated: YES];
    [viewController release];
}

- (IBAction)showAchievements
{
    GKAchievementViewController *achievements= [[GKAchievementViewController alloc] init];
    if (achievements != NULL)
    {
        achievements.achievementDelegate= self;
        [self presentModalViewController:achievements animated:YES];
    }
}
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController;
{
    [self dismissModalViewControllerAnimated: YES];
    [viewController release];
}

- (void)submitScore
{
    if(iscore > 0)
    {
        [[GCHandler sharedInstance] reportScore:[self fullScore] forCategory:self.currentQuizClass.leaderboard];
    }
}

#pragma mark - Scoring
- (int64_t)fullScore
{
	int64_t fScore= (iscore*1000000.0*(self.quizLevel+1))/[Question questionCount:self.quizClass inQuestions:self.questions]/[[NSDate date] timeIntervalSinceDate:self.startTime];
	
	return fScore;
}

- (void)updateTime
{
	NSTimeInterval eTime= [[NSDate date] timeIntervalSinceDate:self.startTime];
	self.elapsed.text= [NSString stringWithFormat:@"Elapsed: %.2f", eTime];

	if (self.quizRunning)
	{
		self.elapsed.hidden= NO;
		[self performSelector:@selector(updateTime) withObject:nil afterDelay:0.10];
	}
	else
		self.elapsed.hidden= YES;

}

#pragma mark - Quiz control
- (void)askForLevel
{
	// Ask for level
	QuizLevelSelectViewController *qLevel= [[QuizLevelSelectViewController alloc] initWithNibName:@"QuizLevelSelectViewController" bundle:nil];
	qLevel.view.opaque= NO;
	qLevel.view.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:0.5f];
	qLevel.delegate= self;
	qLevel.quizClass= self.quizClass;
	qLevel.quizLevel= self.quizLevel;
	
	[self.view addSubview:qLevel.view];
}

-(IBAction)startover:(id)sender
{
	self.nextQuestionIndex= 0;
	
	iquizz=0;
	iscore=0;
	self.startTime= [NSDate date];
	

	if (sender == nil)
	{
		self.questions= [Question loadQuestionsOfClass:self.quizClass level:self.quizLevel];
		[self fillQuestionForm];
		
		self.next.enabled=NO;
		self.quizRunning= YES;
		[self performSelector:@selector(updateTime) withObject:nil afterDelay:0.10];
	}
	else
	{
		self.quizRunning= NO;
		[self askForLevel];
	}
}

-(IBAction)newQuestion
{
	if ([self.next.title isEqualToString:@"Finish"])
	{
		// End of questions
		self.next.enabled= NO;
		self.quizRunning= NO;
		[self submitScore];
		return;
	}
	
	iquizz++;
	self.next.enabled= NO;
	self.nextQuestionIndex++;

	[self fillQuestionForm];
	
}

- (BOOL)containsAnswer:(NSString *)answer
{
    NSRange range= [self.currentQuestion.correctAnswers rangeOfString:answer];
    return (range.location != NSNotFound);
}

- (IBAction)answerButton:(UIButton *)sender
{
	// Only allow one answer once
	sender.enabled= NO;
	
	switch ([sender tag])
	{
		case 0:
			// Answer A
			if ([self containsAnswer:@"A"])
			{
				AnswerA.textColor=[UIColor greenColor];
				self.next.enabled=YES;
				iscore++;
			}
			else
			{
				AnswerA.textColor=[UIColor redColor];
				iscore--;
			}
			break;
			
		case 1:
			// Answer B
			if ([self containsAnswer:@"B"])
			{
				AnswerB.textColor=[UIColor greenColor];
				self.next.enabled=YES;
				iscore++;
			}
			else
			{
				AnswerB.textColor=[UIColor redColor];
				iscore--;
			}
			break;
			
		case 2:
			// Answer C
			if ([self containsAnswer:@"C"])
			{
				AnswerC.textColor=[UIColor greenColor];
				self.next.enabled=YES;
				iscore++;
			}
			else
			{
				AnswerC.textColor=[UIColor redColor];
				iscore--;
			}
			break;
			
		case 3:
			// Answer D
			if ([self containsAnswer:@"D"])
			{
				AnswerD.textColor=[UIColor greenColor];
				self.next.enabled=YES;
				iscore++;
			}
			else
			{
				AnswerD.textColor=[UIColor redColor];
				iscore--;
			}
			break;
			
		default:
			break;
	}
	
	self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
	
}

#ifdef oldway
-(IBAction)startover:(id)sender{
    
    iquizz=0;
    iscore=0;
    
    self.xofy.text= [NSString stringWithFormat:@"%d of 50",iquizz];
    self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    
    self.AnswerA.textColor=[UIColor blackColor];
    self.AnswerB.textColor=[UIColor blackColor];
    self.AnswerC.textColor=[UIColor blackColor];
    self.AnswerD.textColor=[UIColor blackColor];
	
    QuestionLabel.text=@"What was the name of the first supercomputer ?";
    AnswerA.text=@"CDC 6600";
    AnswerB.text=@"Bull";
    AnswerC.text=@"Univac";
    AnswerD.text=@"DataPlex";
    
	
    self.next.enabled=NO;
	
}
-(IBAction)newQuestion{
    
    iquizz++;
    
    self.xofy.text= [NSString stringWithFormat:@"%d of 50",iquizz+1];
       
    self.next.enabled=NO;
    AnswerA.textColor=[UIColor blackColor];
    AnswerB.textColor=[UIColor blackColor];
    AnswerC.textColor=[UIColor blackColor];
    AnswerD.textColor=[UIColor blackColor];
    
    if (iquizz == 1) {
        
        QuestionLabel.text=@"When was the first supercomputer released ?";
        AnswerA.text=@"1956";
        AnswerB.text=@"1964";
        AnswerC.text=@"1976";
        AnswerD.text=@"1981";
        
    } else if (iquizz == 2) {
       
        QuestionLabel.text=@"Where was the first supercomputer built ?";
        AnswerA.text=@"France";
        AnswerB.text=@"Spain";
        AnswerC.text=@"USA";
        AnswerD.text=@"Japan";
   
    } else if (iquizz == 3) {
            
        
        QuestionLabel.text=@"Who designed the first supercomputer ?";
        AnswerA.text=@"Seymour IBM";
        AnswerB.text=@"Seymour Cray";
        AnswerC.text=@"Seymour Bull";
        AnswerD.text=@"Seymour Intel";
        
    } else if (iquizz == 4) {
        
         QuestionLabel.text=@"Serial vs parallel calculations: How much power per operation may a CPU consume compared to a GPU (latest technologies) ?";
        AnswerA.text=@"7 times more";
        AnswerB.text=@"7 times less";
        AnswerC.text=@"70 times more";
        AnswerD.text=@"70 times less";
    
    }  else if (iquizz == 5) {
        
        QuestionLabel.text=@"Which company marketed \"the world's first GPU\" in 1999 ?";
        AnswerA.text=@"Intel";
        AnswerB.text=@"IBM";
        AnswerC.text=@"MVIDIA";
        AnswerD.text=@"AMD";
               
        
    } else if (iquizz == 6) {
        
        QuestionLabel.text=@"The name of the new Intel chip built to leverage parallel computing is:";
        AnswerA.text=@"Intel CPU";
        AnswerB.text=@"Intel GPU";
        AnswerC.text=@"Intel GIT";
        AnswerD.text=@"Intel MIC";
             
    } else if (iquizz == 7) {
        
        QuestionLabel.text=@"Which one of the following supercomputers uses GPUs ?";
        AnswerA.text=@"Jaguar, USA";
        AnswerB.text=@"K Computer, Japan";
        AnswerC.text=@"Tianhe-1A, China";
        AnswerD.text=@"Kraken, USA";
             
    }  else if (iquizz == 8) {
        
        QuestionLabel.text=@"What kind of chips does the second most powerful supercomputer in the world (K computer) contain ?";
        AnswerA.text=@"CPUs+GPUs";
        AnswerB.text=@"CPUs+MICs";
        AnswerC.text=@"CPUs only";
        AnswerD.text=@"GPUs only";
            
    } else if (iquizz == 9) {
        
        QuestionLabel.text=@"By 2012-2013, which supercomputer is going to be upgraded with GPUs ?";
        AnswerB.text=@"K Computer, Japan";
        AnswerA.text=@"Jaguar, USA";
        AnswerC.text=@"Kraken, USA";
        AnswerD.text=@"Tianhe-1A, China";
        
    } else if (iquizz == 10) {
        
        QuestionLabel.text=@"In Spain, the Barcelona supercomputing center recently developped a hybrid architecture: GPU + ..";
        AnswerA.text=@"Smartphone chip";
        AnswerB.text=@"CPU";
        AnswerC.text=@"MIC";
        AnswerD.text=@"GPU";
        
        /*
        Question.text=@"By 2018, supercomputers are expected to be able to process information on a level similar to a ..";
        AnswerA.text=@"human brain";
        AnswerB.text=@"dog brain";
        AnswerC.text=@"cat brain";
        AnswerD.text=@"wale brain";
        */
         
    } else if (iquizz == 11) {
        
        QuestionLabel.text=@"Researchers have recently built computer chips that use .. instead of electricity (electrons) to transmit the information.";
        AnswerA.text=@"Light";
        AnswerB.text=@"Photons";
        AnswerC.text=@"Water";
        AnswerD.text=@"Air";
        
        /*
        Question.text=@"Which projects use distributed Desktops & Laptops that communicate through the network to resolve scientific questions ?";
        AnswerA.text=@"SETI@HOME";
        AnswerB.text=@"Folding@HOME";
        AnswerC.text=@"Docking@HOME";
        AnswerD.text=@"Africa@HOME";
         */
          
    
    } else if (iquizz == 12) {
        
        
        QuestionLabel.text=@"Which country recently developed its first own computer chip ? ";
        AnswerA.text=@"Japan";
        AnswerB.text=@"Australia";
        AnswerC.text=@"China";
        AnswerD.text=@"Brazil";

        
        /*
        Question.text=@"Grid computing is a distributed system from multiple and .. administrative domains to achieve a common goal (i.e., scientific research).";
        AnswerA.text=@"interactive";
        AnswerB.text=@"dependent";
        AnswerC.text=@"independent";
        AnswerD.text=@"communicating";
         */
        
        
    } else if (iquizz == 13) {
        
        
        QuestionLabel.text=@"Which language(s) can be used to develop on GPUs ? ";
        AnswerA.text=@"CUDA";
        AnswerB.text=@"OpenACC";
        AnswerC.text=@"C/C++";
        AnswerD.text=@"Fortran";
        
        /*
        Question.text=@"Recent findings says that biogas-powered cells would allow to pump up to .. into the grid.";
        AnswerA.text=@"5 MW";
        AnswerB.text=@"10 MW";
        AnswerC.text=@"50 MW";
        AnswerD.text=@"150 MW";
          */    
        
    } else if (iquizz == 14) {
             
        QuestionLabel.text=@"In which journal appeared this quote : \"The processor is going through a bit of a schizophrenic mid-life crisis\" ?";
        AnswerA.text=@"EE times";
        AnswerB.text=@"NY times";
        AnswerC.text=@"LA times";
        AnswerD.text=@"Vancouver Sun";
        
        /*
        Question.text=@"The annual International Consumer Electronics Show (CES) in Las Vegas is a major technology-related ..";
        AnswerA.text=@"Trade show";
        AnswerB.text=@"Design show";
        AnswerC.text=@"Mum show";
        AnswerD.text=@"Academic show";
         */
            
    } else if (iquizz == 15) {
        
        QuestionLabel.text=@"In what year the world's first hacker ruined a public demonstration of a wireless telegraph by sending Morse code insults via wire ?";
        
        AnswerA.text=@"1789";
        AnswerB.text=@"1804";
        AnswerC.text=@"1903";
        AnswerD.text=@"1945";
        
        
        /*
        Question.text=@"What happened at CES 2012 ?";
        AnswerA.text=@"iPhone 5 unveiled";
        AnswerB.text=@"Eminem was there";
        AnswerC.text=@"50 Cents was there";
        AnswerD.text=@"Obama was there";
        */
        
                
    } else if (iquizz == 16) {
        
        QuestionLabel.text=@"The telegraph hacker was known as a ..";
        
        AnswerA.text=@"civil engineer";
        AnswerB.text=@"cook";
        AnswerC.text=@"school teacher";
        AnswerD.text=@"magician";        
        
    } else if (iquizz == 17) {
        
        QuestionLabel.text=@"The Koomey’s Law says that the amount of power needed to perform a computing task falls by half every ..";
        AnswerA.text=@"1.5 months";
        AnswerB.text=@"1.5 years";
        AnswerC.text=@"2.5 months";
        AnswerD.text=@"2.5 years";
        
    } else if (iquizz == 18) {
        
        QuestionLabel.text=@"By 2023, supercomputers are expected to be able to simulate a complete ..";
        AnswerA.text=@"rat brain";
        AnswerB.text=@"dog brain";
        AnswerC.text=@"human brain";
        AnswerD.text=@"ET brain";
        
        /*
        Question.text=@"In Spain, the Barcelona supercomputing center recently developped a hybrid chip architecture: GPU + ..";
        AnswerA.text=@"MIC";
        AnswerB.text=@"CPU";
        AnswerC.text=@"Smartphone chip";
        AnswerD.text=@"GPU";
         */
       
        
    } else if (iquizz == 19) {
        
        QuestionLabel.text=@"The power that a supercomputer needs is similar to the power needed by a ..";
        AnswerA.text=@"high-speed train";
        AnswerB.text=@"plane";
        AnswerC.text=@"ship";
        AnswerD.text=@"car";
        
    } else if (iquizz == 20) {
        
        QuestionLabel.text=@"How much power does that (roughly) correspond to ?";
        AnswerA.text=@"7 MW";
        AnswerB.text=@"14 MW";
        AnswerC.text=@"21 MW";
        AnswerD.text=@"28 MW";
        
    } else if (iquizz == 21) {
        
        QuestionLabel.text=@"Which one of the following locations is ideal to build green computing centers and save cooling energy ?";
        AnswerA.text=@"Tennessee";
        AnswerB.text=@"Iceland";
        AnswerC.text=@"France";
        AnswerD.text=@"Brazil";
        
    } else if (iquizz == 22) {
        
        QuestionLabel.text=@"Which is the #1 most greenest supercomputer in the world?";
        AnswerA.text=@"Tianhe-1A, China";
        AnswerB.text=@"K Computer, Japan";
        AnswerC.text=@"rzuseq, BG/Q, USA";
        AnswerD.text=@"Jaguar, USA";
        
       
        
    } else if (iquizz == 23) {
        
        QuestionLabel.text=@"Which is the #1 most powerful supercomputer in the world?";
        AnswerA.text=@"Jaguar, USA";
        AnswerD.text=@"K Computer, Japan";
        AnswerC.text=@"Tsanhe-1A, China";
        AnswerB.text=@"Sequoia, BG/Q, USA";
        
    } else if (iquizz == 24) {
        
        QuestionLabel.text=@"Which is the #2 most powerful supercomputer in the world?";
        AnswerB.text=@"Tianhe-1A, China";
        AnswerA.text=@"K Computer, Japan";
        AnswerC.text=@"Jaguar, USA";
        AnswerD.text=@"IBM BlueGene/Q, USA";
        
    } else if (iquizz == 25) {
        
        QuestionLabel.text=@"Which is the #3 most powerful supercomputer in the world?";
        AnswerA.text=@"Tianhe-1A, China";
        AnswerB.text=@"K Computer, Japan";
        AnswerC.text=@"Mira, BG/Q, USA";
        AnswerD.text=@"Jaguar, USA";
        
    } else if (iquizz == 26) {
        
        QuestionLabel.text=@"Which \"measures\" can be used to assess how green is a computing center ? ";
        
        AnswerA.text=@"Perf. Per Watt";
        AnswerB.text=@"GPUE";
        AnswerC.text=@"Hardware cost";
        AnswerD.text=@"Energy cost";
        
    } else if (iquizz == 27) {
        
              
        QuestionLabel.text=@"Which of the following energy sources could be used to power the battery of your cell phones ?";
        AnswerA.text=@"Solar panels";
        AnswerB.text=@"Human movements";
        AnswerC.text=@"Hydrogen cells";
        AnswerD.text=@"Biogas cells";
        
    }  else if (iquizz == 28) {
        
        QuestionLabel.text=@"Which projects use distributed computers that communicate through the network to resolve scientific questions ?";
        AnswerA.text=@"SETI@HOME";
        AnswerB.text=@"Folding@HOME";
        AnswerC.text=@"Docking@HOME";
        AnswerD.text=@"Africa@HOME";
               
        /*
        Question.text=@"Researchers have recently built computer chips that use light (photons) instead of electricity (electrons) to transmit the information.";
        AnswerA.text=@"";
        AnswerB.text=@"NO";
        AnswerC.text=@"YES";
        AnswerD.text=@"";
         */
               
    } else if (iquizz == 29) {
        
        QuestionLabel.text=@"Which platform is known as the social supecomputing platform for providing ready-to-use programs that would answer a single question ?";
        
        AnswerA.text=@"Opani";
        AnswerB.text=@"CharityEngine";
        AnswerC.text=@"Amazing EC2";
        AnswerD.text=@"Jaguar";
        
        /*
        Question.text=@"Which country recently developed its first own computer chip ? ";
        AnswerA.text=@"China";
        AnswerB.text=@"Australia";
        AnswerC.text=@"Japan";  
        AnswerD.text=@"Brazil";
         */
        
        
    } else if (iquizz == 30) {
        
        QuestionLabel.text=@"Supercomputing simulations can be used to predict the impact of a marine power generation installation on the environment.";
        AnswerA.text=@"YES";
        AnswerB.text=@"NO";
        AnswerC.text=@"";
        AnswerD.text=@"";
        
    }  else if (iquizz == 31) {
        
        QuestionLabel.text=@"In 2012, how many IBM data centers have been honored by  the European Commission for their energy efficiency ?";
        AnswerA.text=@"21";
        AnswerB.text=@"27";
        AnswerC.text=@"35";
        AnswerD.text=@"42";
        
    } else if (iquizz == 32) {
        
        QuestionLabel.text=@"Individuals can pay for using computing resources from .. platforms in order to launch their own computer simulations. ";
        AnswerA.text=@"Amazon EC2 Cluster";
        AnswerB.text=@"Opani";
        AnswerC.text=@"CharityEngine";
        AnswerD.text=@"Jaguar";
        
    } else if (iquizz == 33) {
        
        QuestionLabel.text=@"In 2012, which country might become the world's #1 cloud computing market.";
        AnswerA.text=@"Japan";
        AnswerB.text=@"China";
        AnswerC.text=@"USA";
        AnswerD.text=@"France";
        
    } else if (iquizz == 34) {
        
        QuestionLabel.text=@"By 2020, U.S. organizations could save $12.3 billion in energy cost by moving to the Cloud: this corresponds to .. million barrels of oil";
        AnswerA.text=@"200";
        AnswerB.text=@"150";
        AnswerC.text=@"100";
        AnswerD.text=@"50";
              
    } else if (iquizz == 35) {
       
        QuestionLabel.text=@"Which of the following techniques are used to reduce energy costs and hardware failures ?";
        AnswerA.text=@"Umbrella cooling";
        AnswerB.text=@"Water cooling";
        AnswerC.text=@"Air cooling";
        AnswerD.text=@"Quantum cooling";
              
    } else if (iquizz == 36) {
        
        QuestionLabel.text=@"The K Computer, second most powerful supercomputer in the world uses ..";
        AnswerA.text=@"Water cooling";
        AnswerB.text=@"Air cooling";
        AnswerC.text=@"Water & air cooling";
        AnswerD.text=@"Nitrogen cooling";
        
    } else if (iquizz == 37) {
        
        QuestionLabel.text=@"Recent findings says that biogas-powered cells would allow to pump up to .. into a system of distributed computational resources.";
        AnswerA.text=@"5 MW";
        AnswerB.text=@"10 MW";
        AnswerC.text=@"50 MW";
        AnswerD.text=@"150 MW";
        
        /*
        Question.text=@"Which language(s) can be used to develop on GPUs ? ";
        AnswerA.text=@"CUDA";
        AnswerB.text=@"OpenACC";
        AnswerC.text=@"C/C++";
        AnswerD.text=@"Fortran";
        */
    
    } else if (iquizz == 38) {
        
        /*
        Question.text=@"The annual International Consumer Electronics Show (CES) in Las Vegas is a major technology-related ..";
        AnswerA.text=@"Trade show";
        AnswerB.text=@"Design show";
        AnswerC.text=@"Mum show";
        AnswerD.text=@"Academic show";
         */
        
    
         QuestionLabel.text=@"What happened at the annual International Consumer Electronics Show (CES 2012) ?";
         AnswerC.text=@"50 Cent was there";
         AnswerB.text=@"Eminem was there";
         AnswerA.text=@"iPhone5 unveiled"; 
         AnswerD.text=@"Obama was there";
                
        /*
        Question.text=@"Which journal this quote is attributed to: \"The processor is going through a bit of a schizophrenic mid-life crisis\"";
        AnswerA.text=@"LA times";
        AnswerB.text=@"NY times";
        AnswerC.text=@"EE times";
        AnswerD.text=@"Vancouver Sun";
         */
        
    } else if (iquizz == 39) {
        
        QuestionLabel.text=@"Whos this quote is attributed to: \"Try not to become a man of success but a man of value.\"";
        AnswerA.text=@"Albert Einstein";
        AnswerB.text=@"Barack Obama";
        AnswerC.text=@"Nicolas Sarkozy";
        AnswerD.text=@"Angela Merkel";
        
    } else if (iquizz == 40) {
        
        QuestionLabel.text=@"By 2020, we are going to reach the era of supercomputing at the .. ";
         AnswerA.text=@"Exascale";
         AnswerB.text=@"Petascale";
        AnswerC.text=@"Terascale";
         AnswerD.text=@"Bugscale";
        
    } else if (iquizz == 41) {
        
        QuestionLabel.text=@"In Spain, the e-learning platform for virtual classrooms in the supercomputing center of Galicia has .. users.";
        AnswerA.text=@"10,000";
        AnswerB.text=@"20,000";
        AnswerC.text=@"30,000";
        AnswerD.text=@"50,000";
        
    } else if (iquizz == 42) {
        
        QuestionLabel.text=@"The official list that ranks the world's most powerful supercomputers according to their performance (flop) is named:";
        AnswerA.text=@"T0P10";
        AnswerB.text=@"TOP100";
        AnswerC.text=@"TOP500";
        AnswerD.text=@"TOP1000";
        
    } else if (iquizz == 43) {
        
        QuestionLabel.text=@"The official list that ranks the world's most powerful supercomputers according to their energy consumption per flop is named:";
        AnswerA.text=@"GREEN1000";
        AnswerB.text=@"GREEN500";
        AnswerC.text=@"GREEN100";
        AnswerD.text=@"GREEN50";
        
    } else if (iquizz == 44) {
        
        QuestionLabel.text=@"The name of logarithmic scale that combines Green500+Top500 to look at \"performance vs energy efficiency\" through a single scalar:";
        AnswerA.text=@"Exascalar";
        AnswerB.text=@"Petascalar";
        AnswerC.text=@"Terascalar";
        AnswerD.text=@"Bugscalar";
        
    } else if (iquizz == 45) {
        
        QuestionLabel.text=@"The name of the NVIDIA exascale supercomputer that should be released by 2018 is .. ";
        AnswerA.text=@"Achille";
        AnswerB.text=@"Echelle";
        AnswerC.text=@"Echelon";
        AnswerD.text=@"Achete";
        
    } else if (iquizz == 46) {
        
        QuestionLabel.text=@"Intel’s 2018 Exascale Goal is: delivering one Exaflops in a power envelope of .. ";
        AnswerA.text=@"1 MW";
        AnswerB.text=@"5 MW";
        AnswerC.text=@"10 MW";
        AnswerD.text=@"20 MW";
        
        /*
        Question.text=@"In January 2012, what new technology for the developing world was unveiled by a Cambridge nonprofit organization ? ";
        AnswerA.text=@"10$ smartphone";
        AnswerB.text=@"100$ smartphone";
        AnswerC.text=@"10$ tablet";
        AnswerD.text=@"100$ tablet";
         */
        
    } else if (iquizz == 47) {
                    
        QuestionLabel.text=@"In January 2012, which company announced the creation of the world's smallest storage device (12-atom size) ?";
        AnswerA.text=@"Cray";
        AnswerB.text=@"IBM";
        AnswerC.text=@"Intel";
        AnswerD.text=@"Nvidia";
        
        /*
        Question.text=@"How many barrels of oil per year equals to the excess consumption of water & fossil fuels due to food waste ? ";
        AnswerA.text=@"30 million";
        AnswerB.text=@"300 million";
        AnswerC.text=@"30 billion";
        AnswerD.text=@"300 billion";
         */

        
    } else if (iquizz == 48) {
        
        QuestionLabel.text=@"Which countries are leading the supercomputing race ?";
        AnswerA.text=@"China & USA";
        AnswerC.text=@"Japan & USA";
        AnswerB.text=@"China & Japan";
        AnswerD.text=@"France & Germany";
        
    } else if (iquizz == 49) {
        
        QuestionLabel.text=@"Which country is leading the green supercomputing race ?";
        AnswerA.text=@"USA";
        AnswerB.text=@"China";
        AnswerC.text=@"Japan";
        AnswerD.text=@"France";
                
        
    } else if (iquizz == 50) {
        
        QuestionLabel.text=@"Which company is leading the green supercomputing race ?";
        AnswerA.text=@"IBM";
        AnswerB.text=@"Cray";
        AnswerC.text=@"Intel";
        AnswerD.text=@"Bull";   
        
    }  
    
    
     /*
       The European Commission has honored 27 IBM data centers for 
      their energy efficiency
     */

}
-(IBAction)buttonA:(id)sender{
    
    if (iquizz == 0 || iquizz == 10 || iquizz == 20 || iquizz == 30 || iquizz == 40 || iquizz == 50 || iquizz == 27 || iquizz==32 || iquizz==26 || iquizz==28 || iquizz==13) {
		
        AnswerA.textColor=[UIColor greenColor];
        self.next.enabled=YES;
		
		
    } else if (iquizz == 4 || iquizz == 14 || iquizz == 24 || iquizz == 34 || iquizz == 44 || iquizz== 11 || iquizz==28) {
        
		// iscore++;
		//   result.text=@"You are right";
        AnswerA.textColor=[UIColor greenColor];
		;
        self.next.enabled=YES;
		//[self newQuestion];
		
        
    } else if (iquizz == 9 || iquizz == 19 || iquizz == 29 || iquizz == 39 || iquizz == 49 ) {
        
		
		AnswerA.textColor=[UIColor greenColor];
		//  iquizz++;
        self.next.enabled=YES;
		//  [self newQuestion];
		
    } else {
		//    iscore--;
		//   result.text=@"Try again";
        AnswerA.textColor=[UIColor redColor];
		/// self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
        
    }
    
    
    if(AnswerA.textColor == [UIColor redColor]){
        iscore--;
		self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
		self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		
        
    }
    
}
-(IBAction)buttonB:(id)sender{
    
    
    if (iquizz == 1 || iquizz == 11 || iquizz == 21 || iquizz == 31 || iquizz == 41 || iquizz==32 || iquizz==35 || iquizz==26 || iquizz==28) {
        
		//  iscore++;
		//   result.text=@"You are right";
		//  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		AnswerB.textColor=[UIColor greenColor];
		//  iquizz++;
        self.next.enabled=YES;
		// [self newQuestion];
        
        
    } else if (iquizz == 3 || iquizz == 23 || iquizz == 33 || iquizz == 43 || iquizz==13) {
        
		//  iscore++;
		//   result.text=@"You are right";
		//  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		AnswerB.textColor=[UIColor greenColor];
		//  iquizz++;
        self.next.enabled=YES;
		//  [self newQuestion];
        
        
    } else if (iquizz == 17 || iquizz == 27 || iquizz == 47 ) {
        
		//   iscore++;
		//  result.text=@"You are right";
		//  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		AnswerB.textColor=[UIColor greenColor];
		//  iquizz++;
        self.next.enabled=YES;
		//   [self newQuestion];
        
        
    } else {
        
		//  result.text=@"Try again";
        AnswerB.textColor=[UIColor redColor];
		// self.score.text= [NSString stringWithFormat:@"Score: %d",iscore-1];
        
    }
	
    if(AnswerB.textColor == [UIColor redColor]){
        iscore--;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
        
        
    }
    
    
}
-(IBAction)buttonC:(id)sender{
    
    if (iquizz == 2 || iquizz == 12 || iquizz == 22 || iquizz == 32 || iquizz == 42 || iquizz==7 || iquizz==26 || iquizz==36 || iquizz==37) {
        
		
		AnswerC.textColor=[UIColor greenColor];
		//   iquizz++;
        self.next.enabled=YES;
		//  [self newQuestion];
        
        
    } else if (iquizz == 5 || iquizz == 15 || iquizz == 25 || iquizz == 35 || iquizz == 45 ) {
        
		//  iscore++;
		//  result.text=@"You are right";
		//  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		AnswerC.textColor=[UIColor greenColor];
		//    iquizz++;
        self.next.enabled=YES;
		//     [self newQuestion];
        
        
    } else if (iquizz == 8 || iquizz == 18 || iquizz == 28 || iquizz == 38 || iquizz == 48 || iquizz==27) {
        
		//   iscore++;
		//   result.text=@"You are right";
		//   self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		AnswerC.textColor=[UIColor greenColor];
		//   iquizz++;
        self.next.enabled=YES;
		//  [self newQuestion];
        
        
    } else {
        
		//  result.text=@"Try again";
        AnswerC.textColor=[UIColor redColor];
		//  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore-1];
        
    }
    
    if(AnswerC.textColor == [UIColor redColor]){
        iscore--;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		
    }
	
}
-(IBAction)buttonD:(id)sender{
    
    
    if (iquizz == 6 || iquizz == 16 || iquizz == 26 || iquizz == 46 || iquizz==27 || iquizz==28) {
        
		//   iscore++;
		//   result.text=@"You are right";
		//   self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
		AnswerD.textColor=[UIColor greenColor];
		//   iquizz++;
        self.next.enabled=YES;
        
		//  [self newQuestion];
        
        
    } else {
        
		//  result.text=@"Try again";
        AnswerD.textColor=[UIColor redColor];
		//  self.score.text= [NSString stringWithFormat:@"Score: %d",iscore-1];
        
    }
    
    if(AnswerD.textColor == [UIColor redColor]){
        iscore--;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
    } else {
        iscore++;
        self.score.text= [NSString stringWithFormat:@"Score: %d",iscore];
        
        
    }
}
#endif

#pragma mark - Delegate functions
- (void)quizLevelSelectViewControllerDidFinish:(QuizLevelSelectViewController *)controller
{
	self.quizClass= controller.quizClass;
	self.quizLevel= controller.quizLevel;
	self.currentQuizClass= ((QuizClass *)controller.quizClasses[self.quizClass]);
	
	[controller.view removeFromSuperview];
	[self startover:nil];
	
	[controller release];
}

- (void)showGameCenterLeaderboards:(QuizLevelSelectViewController *)controller
{
	self.quizClass= controller.quizClass;
	self.quizLevel= controller.quizLevel;
	self.currentQuizClass= ((QuizClass *)controller.quizClasses[self.quizClass]);
	
//	[controller.view removeFromSuperview];
//	[controller release];
	
	[self showLeaderboard];
}

#pragma mark - Life cycle
-(void) dealloc
{
    [QuestionLabel release];
    [AnswerA release];
    [AnswerB release];
    [AnswerC release];
    [AnswerD release];
    [buttonA release];
    [buttonB release];
    [buttonC release];
    [buttonD release];
    [xofy release];
    [score release];
    [result release];
    [toolbar release];
    [result release];
    [next release];
    [startover release];
	
	[questions release];
	
    [super dealloc];
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
