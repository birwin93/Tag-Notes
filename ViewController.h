//
//  ViewController.h
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskStore.h"
#import "NewTaskViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NewTaskDelegate>

@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
@property (strong, nonatomic) TaskStore *ts;

- (IBAction)newTask:(id)sender;
@end
