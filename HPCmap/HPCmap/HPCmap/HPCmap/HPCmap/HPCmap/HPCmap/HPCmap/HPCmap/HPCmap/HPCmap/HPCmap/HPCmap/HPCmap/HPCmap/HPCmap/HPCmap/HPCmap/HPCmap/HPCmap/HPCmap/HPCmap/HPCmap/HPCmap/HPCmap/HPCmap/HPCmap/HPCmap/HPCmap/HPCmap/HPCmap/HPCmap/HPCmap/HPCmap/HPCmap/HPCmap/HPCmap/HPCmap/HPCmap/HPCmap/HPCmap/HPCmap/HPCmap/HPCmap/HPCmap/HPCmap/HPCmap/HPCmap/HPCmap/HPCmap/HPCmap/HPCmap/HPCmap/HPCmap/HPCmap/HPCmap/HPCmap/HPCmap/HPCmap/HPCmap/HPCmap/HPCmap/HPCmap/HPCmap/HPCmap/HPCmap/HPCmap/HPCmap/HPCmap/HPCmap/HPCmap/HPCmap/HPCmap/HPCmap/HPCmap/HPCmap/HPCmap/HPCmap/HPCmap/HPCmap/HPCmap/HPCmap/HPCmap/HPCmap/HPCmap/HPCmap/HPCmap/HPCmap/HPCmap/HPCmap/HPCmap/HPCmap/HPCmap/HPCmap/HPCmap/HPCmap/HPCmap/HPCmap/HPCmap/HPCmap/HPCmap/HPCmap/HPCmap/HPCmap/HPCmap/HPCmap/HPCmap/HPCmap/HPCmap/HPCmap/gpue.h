//
//  gpue.h
//  GloveCatalogue
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gpue : UIViewController {

UITextView *mytextview;
UITextField *value1;
UITextField *value2;
UITextField *value3;
UITextField *value4;
UILabel *mygpue;
UILabel *myg;
UILabel *mygpue2;

}

//@property (nonatomic,retain) IBOutlet UITextView *mytextview;
@property (nonatomic,retain) IBOutlet UITextField *value1;
@property (nonatomic,retain) IBOutlet UITextField *value2;
@property (nonatomic,retain) IBOutlet UITextField *value3;
@property (nonatomic,retain) IBOutlet UITextField *value4;
@property (nonatomic,retain) IBOutlet UILabel *mygpue;
@property (nonatomic,retain) IBOutlet UILabel *mygpue2;
@property (nonatomic,retain) IBOutlet UILabel *myg;

@end