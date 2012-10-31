//
//  ViewController.h
//  HPCmap
//
//  Created by Barbara Collignon on 1/12/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CommonDefines.h"
#import "Question.h"
#import "QuizClass.h"
#import "FBHandler.h"
#import "GCHandler.h"
#import "QuizLevelSelectViewController.h"
#import "InAppPurManager.h"
#import "MyStoreObserver.h"

@interface QuizzViewController : UIViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate, GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>
{
    UILabel *QuestionLabel ;
    UILabel *AnswerA ;
    UILabel *AnswerB ;
    UILabel *AnswerC ;
    UILabel *AnswerD ;
    UIButton *buttonA ;
    UIButton *buttonB ;
    UIButton *buttonC ;
    UIButton *buttonD ;
    UILabel *score ;
    UILabel *elapsed;
    UILabel *xofy ;
    UILabel *result ;
    UIToolbar *toolbar;
    UIBarButtonItem *next ;
    UIBarButtonItem *startover ;
    UIBarButtonItem *ask ;
    int iquizz;
    int iscore;
	
	NSArray *questions;
	NSInteger nextQuestionIndex;
	NSInteger quizClass;
	NSInteger quizLevel;
	NSDate *startTime;
	Question *currentQuestion;
	QuizClass *currentQuizClass;
	BOOL randomized;
	BOOL quizRunning;
	
	GCHandler *gcHandler;
	
}

@property (nonatomic,retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic,retain) IBOutlet UILabel *QuestionLabel ;
@property (nonatomic,retain) IBOutlet UILabel *result ;
@property (nonatomic,retain) IBOutlet UILabel *xofy;
@property (nonatomic,retain) IBOutlet UILabel *score;
@property (nonatomic,retain) IBOutlet UILabel *elapsed;
@property (nonatomic,retain) IBOutlet UILabel *AnswerA ;
@property (nonatomic,retain) IBOutlet UILabel *AnswerB ; 
@property (nonatomic,retain) IBOutlet UILabel *AnswerC ; 
@property (nonatomic,retain) IBOutlet UILabel *AnswerD ; 
@property (nonatomic,retain) IBOutlet UIButton *buttonA ;
@property (nonatomic,retain) IBOutlet UIButton *buttonB ;
@property (nonatomic,retain) IBOutlet UIButton *buttonC ;
@property (nonatomic,retain) IBOutlet UIButton *buttonD ;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *next;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *startover;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *ask;

@property (nonatomic, retain) NSArray *questions;
@property (nonatomic, assign) NSInteger nextQuestionIndex;
@property (nonatomic, assign) NSInteger quizClass;
@property (nonatomic, assign) NSInteger quizLevel;
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) Question *currentQuestion;
@property (nonatomic, retain) QuizClass *currentQuizClass;
@property (nonatomic, assign) BOOL randomized;
@property (nonatomic, assign) BOOL quizRunning;

@property (nonatomic, retain) GCHandler *gcHandler;

- (IBAction)answerButton:(id)sender;
- (void)askForLevel;
- (void)updateTime;


@end
