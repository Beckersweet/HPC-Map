//
//  Question.h
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-15.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CommonDefines.h"

#define kQuizClass0			0
#define kQuizClass1			1
#define kQuizClass2			2
#define kQuizLevelEasy		0
#define kQuizLevelMedium	1
#define kQuizLevelHard		2

@interface Question : NSObject
{
	NSString *question;
	NSArray *answers;
	NSString *correctAnswers;
	NSInteger questionClass;
	NSInteger questionLevel;
	NSInteger payLevel;
	BOOL active;

}

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, strong) NSString *correctAnswers;
@property (nonatomic, assign) NSInteger questionClass;
@property (nonatomic, assign) NSInteger questionLevel;
@property (nonatomic, assign) NSInteger payLevel;
@property (nonatomic, assign) BOOL active;


+ (Question *)getNextQuestion:(NSArray *)questions index:(NSInteger)qIndex class:(NSInteger)class;
+ (NSInteger)questionCount:(NSInteger)quizClass inQuestions:(NSArray *)questions;
+ (NSArray *)loadQuestionsOfClass:(NSInteger)quizClass level:(NSInteger)quizLevel;

+ (NSString *)describeClassInstance:(id)instance classType:(Class)classType;


@end
