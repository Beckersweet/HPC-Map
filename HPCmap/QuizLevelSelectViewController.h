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
#import "InAppPurManager.h"
#import "MyStoreObserver.h"

#define kTagAlertViewPurchaseRestore	1001

@protocol QuizLevelSelectViewControllerDelegate;

@interface QuizLevelSelectViewController : UIViewController <UIAlertViewDelegate>
{
	id <QuizLevelSelectViewControllerDelegate> delegate;
	
	UIButton *level0Button;
	UIButton *level1Button;
	UIButton *level2Button;
	UISlider *difficultySlider;
	UIButton *startButton;
	UIButton *scoreButton;
	UIView *difficultyView;
	UILabel *askEasyLabel;
	UILabel *askMediumLabel;
	UILabel *askHardLabel;
	UILabel *payEasyLabel;
	UILabel *payMediumLabel;
	UILabel *payHardLabel;
	UIView *waitView;
	UIActivityIndicatorView *waiting;
	
	NSInteger quizClass;
	NSInteger quizLevel;
	NSInteger purchasedLevel;
	
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
@property (nonatomic, strong) IBOutlet UILabel *askEasyLabel;
@property (nonatomic, strong) IBOutlet UILabel *askMediumLabel;
@property (nonatomic, strong) IBOutlet UILabel *askHardLabel;
@property (nonatomic, strong) IBOutlet UILabel *payEasyLabel;
@property (nonatomic, strong) IBOutlet UILabel *payMediumLabel;
@property (nonatomic, strong) IBOutlet UILabel *payHardLabel;
@property (nonatomic, strong) IBOutlet UIView *waitView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *waiting;

@property (nonatomic, strong) NSMutableArray *quizClasses;
@property (nonatomic, assign) NSInteger quizClass;
@property (nonatomic, assign) NSInteger quizLevel;
@property (nonatomic, assign) NSInteger purchasedLevel;

- (IBAction)levelButton:(UIButton *)sender;
- (IBAction)difficultySlider:(UISlider *)sender;
- (IBAction)start;
- (IBAction)scores;

- (void)loadPurchaseHistory;
- (void)savePurchaseHistory;
- (void)showDifficultyView;

@end

@protocol QuizLevelSelectViewControllerDelegate
- (void)quizLevelSelectViewControllerDidFinish:(QuizLevelSelectViewController *)controller;
- (void)showGameCenterLeaderboards:(QuizLevelSelectViewController *)controller;
@end