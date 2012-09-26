//
//  pue.h
//  HPCmap
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pue : UIViewController {
    
    UITextField *value1;
    UITextField *value2;
    UILabel *mypue;
      
}

//@property (nonatomic,retain) IBOutlet UITextView *mytextview;
@property (nonatomic,retain) IBOutlet UITextField *value1;
@property (nonatomic,retain) IBOutlet UITextField *value2;
@property (nonatomic,retain) IBOutlet UILabel *mypue;

@end

