//
//  QuizClass.h
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-23.
//
//

#import <Foundation/Foundation.h>
#import "CommonDefines.h"

@interface QuizClass : NSObject
{
	NSString *name;
	NSString *difficulties;
	NSString *payLevels;
	NSString *leaderboard;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *difficulties;
@property (nonatomic, strong) NSString *payLevels;
@property (nonatomic, strong) NSString *leaderboard;

- (id)initWithData:(NSDictionary *)classEntry;

@end
