//
//  Question.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-15.
//
//

#import "Question.h"

@implementation Question
@synthesize question, answers, correctAnswers, questionClass, questionLevel, questionPoints, payLevel, active;

+ (NSString *)describeClassInstance:(id)instance classType:(Class)classType
{
    NSUInteger count;
    objc_property_t *propertyList= class_copyPropertyList(classType, &count);
    NSMutableString *propertyPrintout= [NSMutableString string];
	
	[propertyPrintout appendString:[NSString stringWithFormat:@"<======= REFLECTION VALUES ======>\n"]];
	
    for ( int i = 0; i < count; i++ )
    {
        objc_property_t property= propertyList[i];
		
        const char *propertyName= property_getName(property);
        NSString *propertyNameString =[NSString stringWithCString:propertyName encoding:NSASCIIStringEncoding];
		
        if(propertyName)
        {
			@try
			{
				id value= [instance valueForKey:propertyNameString];
				[propertyPrintout appendString:[NSString stringWithFormat:@"%@=%@\n", propertyNameString, value]];
			}
			@catch (NSException *exception)
			{
				[propertyPrintout appendString:[NSString stringWithFormat:@"Can't get value for property %@ through KVO\n", propertyNameString]];
			}
        }
    }
    free(propertyList);
	
	
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass( classType );
    if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
    {
		[propertyPrintout appendString:[NSString stringWithFormat:@"<============= SUPERCLASS REFLECTION ======>\n"]];
		
        NSString *superString= [self describeClassInstance:instance classType:superClass];
        [propertyPrintout appendString:superString];
		
		[propertyPrintout appendString:[NSString stringWithFormat:@"<============= END SUPERCLASS REFLECTION ======>\n"]];
    }
	
	[propertyPrintout appendString:[NSString stringWithFormat:@"<======= END REFLECTION VALUES ======>\n"]];
	
    return propertyPrintout;
}

+ (Question *)getNextQuestion:(NSArray *)questions index:(NSInteger)qIndex class:(NSInteger)class
{
	for (int i= qIndex; i<([questions count]); i++)
	{
		Question *q= questions[i];
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
		Question *q= questions[i];
		if (q.active && q.questionClass == quizClass)
			count++;
	}
	return count;
}

+ (NSArray *)loadQuestionsOfClass:(NSInteger)quizClass level:(NSInteger)quizLevel
{
	NSArray *allQuestions= [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuizQA" ofType:@"plist"]];
	NSMutableArray *questions= [[NSMutableArray alloc] init];
	
	for (int i= 0; i<([allQuestions count]); i++)
	{
		Question *q= [[Question alloc] initWithData:allQuestions[i]];
		if (q.active && q.questionClass == quizClass && q.questionLevel == quizLevel)
			[questions addObject:q];
	}
	return (NSArray *)questions;
}


- (id)initWithData:(NSDictionary *)questionEntry
{
	if (self= [super init])
	{
		question=		[questionEntry objectForKey:@"Question"];
		answers=		[questionEntry objectForKey:@"Answers"];
		correctAnswers= [questionEntry objectForKey:@"Correct"];
		questionClass=	[(NSNumber *)[questionEntry objectForKey:@"Class"] integerValue];
		questionLevel=	[(NSNumber *)[questionEntry objectForKey:@"Level"] integerValue];
		questionPoints=	[(NSNumber *)[questionEntry objectForKey:@"Points"] integerValue];
		payLevel=		[(NSNumber *)[questionEntry objectForKey:@"Pay"] integerValue];
		active=			[(NSNumber *)[questionEntry objectForKey:@"Active"] boolValue];
	}
	return self;
}

@end
