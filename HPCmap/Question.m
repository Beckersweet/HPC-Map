//
//  Question.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-15.
//
//

#import "Question.h"

@implementation Question
@synthesize question, answers, correctAnswers, questionClass, active;

+ (Question *)getNextQuestion:(NSArray *)questions index:(NSInteger)qIndex class:(NSInteger)class
{
	for (int i= qIndex; i<([questions count]-1); i++)
	{
		Question *q= [[Question alloc] initWithData:questions[i]];
		if (q.active && q.questionClass == class)
			return q;
	}
	return nil;
}

+ (NSInteger)questionCount:(NSInteger)quizClass inQuestions:(NSArray *)questions
{
	NSInteger count= 0;
	for (int i= 0; i<([questions count]); i++)
	{
		Question *q= [[Question alloc] initWithData:questions[i]];
		if (q.active && q.questionClass == quizClass)
			count++;
	}
	return count;
}

- (id)initWithData:(NSDictionary *)questionEntry
{
	if (self = [super init])
	{
		question=		[questionEntry objectForKey:@"Question"];
		answers=		[questionEntry objectForKey:@"Answers"];
		correctAnswers= [questionEntry objectForKey:@"Correct"];
		questionClass=	[(NSNumber *)[questionEntry objectForKey:@"Class"] integerValue];
		active=			[(NSNumber *)[questionEntry objectForKey:@"Active"] boolValue];

	}
	return self;
}

@end
