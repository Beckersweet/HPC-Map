//
//  QuizLevelSelectViewController.h
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-22.
//
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuizClass.h"
#import "GCHandler.h"
#import "CommonDefines.h"

@protocol QuizLevelSelectViewControllerDelegate;

@interface QuizLevelSelectViewController : UIViewController
{
	id <QuizLevelSelectViewControllerDelegate> delegate;
	
	UIButton *level0Button;
	UIButton *level1Button;
	UIButton *level2Button;
	UISlider *difficultySlider;
	UIButton *startButton;
	UIButton *scoreButton;
	UIView *difficultyView;

	NSInteger quizClass;
	NSInteger quizLevel;
	
	NSMutableArray *quizClasses;
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, strong) IBOutlet UIButton *level0Button;
@property (nonatomic, strong) IBOutlet UIButton *level1Button;
@property (nonatomic, strong) IBOutlet UIButton *level2Button;
@property (nonatomic, strong) IBOutlet UISlider *difficultySlider;
@property (nonatomic, strong) IBOutlet UIButton *startButton;
@property (nonatomic, strong) IBOutlet UIButton *scoreButton;
@property (nonatomic, strong) IBOutlet UIView *difficultyView;

@property (nonatomic, strong) NSMutableArray *quizClasses;
@property (nonatomic, assign) NSInteger quizClass;
@property (nonatomic, assign) NSInteger quizLevel;

- (IBAction)levelButton:(UIButton *)sender;
- (IBAction)difficultySlider:(UISlider *)sender;
- (IBAction)start;
- (IBAction)scores;

@end

@protocol QuizLevelSelectViewControllerDelegate
- (void)quizLevelSelectViewControllerDidFinish:(QuizLevelSelectViewController *)controller;
@end