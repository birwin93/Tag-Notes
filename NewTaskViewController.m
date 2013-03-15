//
//  NewTaskViewController.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewTaskViewController.h"
#import "Task.h"
#import "TaskStore.h"
@interface NewTaskViewController ()

@end

@implementation NewTaskViewController
@synthesize textView;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)save:(id)sender 
{
    Task *t = [[Task alloc] init];
    t.content = textView.text;
    [t findAllTags];
    [[[TaskStore singleton] tasks] addObject:t];
    [delegate finishedCreatingNewTask];
    
}

- (IBAction)cancel:(id)sender {
    [delegate finishedCreatingNewTask];
}
@end
