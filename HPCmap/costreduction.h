//
//  costreduction.h
//  HPCmap 
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface costreduction : UIViewController {

 // UITextView *mytextview;
    UITextField *value1;
 
    UILabel *mysavings;
    UITextField *hardware;
    UITextField *energy;
    
}

//@property (nonatomic,retain) IBOutlet UITextView *mytextview;
@property (nonatomic,retain) IBOutlet UITextField *value1;
@property (nonatomic,retain) IBOutlet UILabel *mysavings;
@property (nonatomic,retain) IBOutlet UITextField *hardware;
@property (nonatomic,retain) IBOutlet UITextField *energy;

@end

