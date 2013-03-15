//
//  NewTaskViewController.h
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewTaskDelegate <NSObject>
- (void)finishedCreatingNewTask;
@end

@interface NewTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) id delegate;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@end
