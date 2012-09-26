//
//  impact.h
//  HPCmap
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NumberKeypadDecimalPoint.h"

@interface impact : UIViewController  {

 //   NumberKeypadDecimalPoint *numberKeyPad;

 //   UITextView *mytextview;
    UITextField *value1;
 //   UITextField *result1;
    UITextField *myimpact1;
    UITextField *myimpact2;
    UITextField *myimpact3;
    UILabel *myimpact4;
  //  NumberKeypadDecimalPoint *numberKeyPad;
	
}

//@property (nonatomic, retain) NumberKeypadDecimalPoint *numberKeyPad;

//@property (nonatomic,retain) IBOutlet UITextView *mytextview;
@property (nonatomic,retain) IBOutlet UITextField *value1;
//@property (nonatomic,retain) IBOutlet UITextField *result1;
@property (nonatomic,retain) IBOutlet UITextField *myimpact1;
@property (nonatomic,retain) IBOutlet UITextField *myimpact2;
@property (nonatomic,retain) IBOutlet UITextField *myimpact3;
@property (nonatomic,retain) IBOutlet UILabel *myimpact4;


@end
