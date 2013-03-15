//
//  ViewController.h
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskStore.h"


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
@property (strong, nonatomic) TaskStore *ts;
@property (nonatomic) BOOL tagsHidden;
@property (strong, nonatomic) NSMutableArray *validTasks;
@property (strong, nonatomic) NSMutableArray *selectedTags;
@property (strong, nonatomic) IBOutlet UIView *tagView;
@property (strong, nonatomic) IBOutlet UIScrollView *tagScrollView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *createTaskView;

- (IBAction)clearTags:(id)sender;
- (IBAction)newTask:(id)sender;
- (IBAction)showHideTags:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)hashTag:(id)sender;

@end
