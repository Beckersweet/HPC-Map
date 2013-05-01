//
//  CalculateModalView.h
//  HPCmap
//
//  Created by Barbara Collignon on 4/18/13.
//
//

#import <UIKit/UIKit.h>

@interface CalculateModalView : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *subscribe;

@property (nonatomic,retain) NSURL *detailURL;
@property (nonatomic, retain) IBOutlet UIWebView *detailWebView;

- (void)dismissView ;
-(IBAction)subscribe:(id)sender;

@end
