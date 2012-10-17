//
//  FBHandler.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-03.
//
//

// **NOTE** This module is using ARC

#import "FBHandler.h"

@implementation FBHandler
@synthesize attachedViewController;

+(BOOL)isSocialFrameworkAvailable
{
	// whether the iOS6 Social framework is available?
    return NSClassFromString(@"SLComposeViewController") != nil;
}

- (id)init
{
	if (self = [super init])
	{
//		if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//		{
// // Solve the problem at class init if we want to fail silently or solve the issue ourselves.
// // It is unclear whether trying to open Settings from an app explicitly causes rejections post 5.0
//			return nil;
//		}
	}
	
	return self;

}

- (void)postMessage:(NSString *)message
{
	SLComposeViewController *controller= [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
	[controller setInitialText:message];
//	[controller addURL:[NSURL URLWithString:HPCFacebookURL]];
	
	SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
	{
		switch (result)
		{
			case SLComposeViewControllerResultCancelled:
				DebugLog(@"facebook post cancelled");
				break;
			case SLComposeViewControllerResultDone:
			{
				DebugLog(@"facebook post sent");
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Question posted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
			}
				break;
			default:
				DebugLog(@"Mystery button");
				break;
		}
		[controller dismissViewControllerAnimated:YES completion:Nil];
	};
	controller.completionHandler =myBlock;
	
	[attachedViewController presentViewController:controller animated:YES completion:nil];

}

- (void)postImage:(UIImage *)image withMessage:(NSString *)message
{
//	if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//	{
//		DebugLog(@"No facebook. Something went wrong. We shouldn't be here!");
//		return;
//	}

	SLComposeViewController *controller= [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
	[controller setInitialText:message];
//	[controller addURL:[NSURL URLWithString:HPCFacebookURL]];
	[controller addImage:image];
	
	SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
	{
		switch (result)
		{
			case SLComposeViewControllerResultCancelled:
				DebugLog(@"facebook post cancelled");
				break;
			case SLComposeViewControllerResultDone:
			{
				DebugLog(@"facebook post sent");
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Image posted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
			}
				break;
			default:
				DebugLog(@"Mystery button");
				break;
		}
		[controller dismissViewControllerAnimated:YES completion:Nil];
	};
	controller.completionHandler =myBlock;

	[attachedViewController presentViewController:controller animated:YES completion:nil];
}

@end
