//
//  Question.h
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-15.
//
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
{
	NSString *question;
	NSArray *answers;
	NSString *correctAnswers;
	NSInteger questionClass;
	BOOL active;

}

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, strong) NSString *correctAnswers;
@property (nonatomic, assign) NSInteger questionClass;
@property (nonatomic, assign) BOOL active;


+ (Question *)getNextQuestion:(NSArray *)questions index:(NSInteger)qIndex class:(NSInteger)class;
+ (NSInteger)questionCount:(NSInteger)quizClass inQuestions:(NSArray *)questions;

@end
