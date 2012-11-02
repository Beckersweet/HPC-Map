//
//  GCHandler.h
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-18.
//
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "CommonDefines.h"

@protocol GCHandlerDelegate
- (void)matchStarted;
- (void)matchEnded;
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID;
@end

@interface GCHandler : NSObject <GKMatchmakerViewControllerDelegate, GKMatchDelegate>
{
	id <GCHandlerDelegate> delegate;

	BOOL gameCenterAvailable;
    BOOL userAuthenticated;
	
	UIViewController *presentingViewController;
	GKMatch *match;
	BOOL matchStarted;
	
	NSDate *gcTimingStart;
	NSInteger gcQuickFailCount;

}

@property (strong) id <GCHandlerDelegate> delegate;
@property (assign, readonly) BOOL gameCenterAvailable;
@property (strong) UIViewController *presentingViewController;
@property (strong) GKMatch *match;
@property (nonatomic, strong) NSDate *gcTimingStart;
@property (nonatomic, assign) NSInteger gcQuickFailCount;

+ (GCHandler *)sharedInstance;
- (void)authenticateLocalUser;
- (void)findMatchWithMinPlayers:(int)minPlayers
					 maxPlayers:(int)maxPlayers
				 viewController:(UIViewController *)viewController
					   delegate:(id<GCHandlerDelegate>)theDelegate;
- (void) reportScore:(int64_t)score forCategory:(NSString *)category;

@end
