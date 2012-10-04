//
//  FBHandler.h
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-03.
//
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import "CommonDefines.h"

@interface FBHandler : NSObject
{
	UIViewController *attachedViewController;

}

@property (retain, nonatomic) UIViewController *attachedViewController;

+(BOOL)isSocialFrameworkAvailable;
- (void)postImage:(UIImage *)image withMessage:(NSString *)message;

@end
