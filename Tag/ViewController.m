//
//  ViewController.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"
#import "UtilityFunctions.h"
@interface ViewController () 
@end

@implementation ViewController


@synthesize taskTableView;
@synthesize ts;
@synthesize tagsHidden;
@synthesize validTasks;
@synthesize selectedTags;
@synthesize tagView;
@synthesize tagScrollView;
@synthesize textView;
@synthesize createTaskView;

#define TAGSVISIBLE CGRectMake(160, 0, 160, 380)
#define TAGSHIDDEN CGRectMake(320, 0, 160, 380)

- (void)viewDidLoad
{
    [super viewDidLoad];
    ts = [TaskStore singleton];
    selectedTags = [[NSMutableArray alloc] init];
    tagsHidden = YES;

    // create button to add new contacts
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newTask:)];
    [self.navigationItem setRightBarButtonItem:bbi];
    
    [self.navigationItem setTitle:@"Tasks"];
    
    // set an edit button to delete contacts
    [self.navigationItem setLeftBarButtonItem:self.editButtonItem];
    
    validTasks = [[NSMutableArray alloc] initWithArray:ts.allTasks];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //NSLog(@"fetching table data");
    [taskTableView reloadData];
}

- (void)viewDidUnload
{
    [self setTaskTableView:nil];
 
    [self setTagView:nil];
    [self setTagScrollView:nil];
    [self setTextView:nil];
    [self setCreateTaskView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)queryTasks 
{
    NSDate *start = [NSDate date];
    [validTasks removeAllObjects];
    
    if ([selectedTags count]==0) {
        validTasks = [[NSMutableArray alloc] initWithArray:ts.allTasks];
        [taskTableView reloadData];
        return;

    }
    
    for (Task *t in ts.allTasks) {
        BOOL valid = YES;
        for (NSString *tag in selectedTags) {
            if (![t.tagsArray containsObject:tag]) {
                valid = NO;
                break;
            }
        }
        if (valid) {
            [validTasks addObject:t];
        }
    }
    
    [taskTableView reloadData];
    
    NSDate *end = [NSDate date];
    
    double time = [end timeIntervalSinceDate:start];
    NSLog(@"time taken: %f", time);
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    //NSLog(@"task count: %i", [ts.tasks count]);
    if (tableView.tag == 1) {
     //   NSLog(@"finding amount of rows: %i", [validTasks count]);
        return [validTasks count];
    } else {
        return [ts.tags count];
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // adjust height of each cell based on the size of the message contained in that given cell
    if (tableView.tag == 1) {
        NSString *text = [[ts.allTasks objectAtIndex:indexPath.row] content];
        
        CGSize constraint = CGSizeMake(300.0f, 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height + 20, 60);
        
     //   NSLog(@"cell height %f", height);
        
        return height;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell"];
        
        
        //remove all previous labels on cell
        [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        
        Task *task = [validTasks objectAtIndex:indexPath.row];
        CGSize constraint = CGSizeMake(300, 400000);
        CGSize fullFrame = [task.content sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                             constrainedToSize:constraint
                                        lineBreakMode:UILineBreakModeWordWrap];
        
        
        UIImageView *contentBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, MAX(fullFrame.height+20, 60))];
        float initialIncr = 80.0;
        int totalCells = [validTasks count];
        float greenVal = 100 + initialIncr * 0.8 * indexPath.row/totalCells;
        NSLog(@"greenVal: %f", greenVal);
        contentBackground.backgroundColor = [UIColor colorWithRed:1 green:greenVal/255 blue:0 alpha:1];
        //contentBackground.backgroundColor = [UIColor orangeColor];
        [cell addSubview:contentBackground];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, fullFrame.width, fullFrame.height)];
        contentLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
        contentLabel.text = task.content;
        contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        contentLabel.minimumFontSize = 20;
        contentLabel.numberOfLines = 0;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor whiteColor];
        [cell addSubview:contentLabel];

        
        for (int i = 0; i<[task.tagsArray count]; i++) {
            CGRect tagFrame = [[task.framesArray objectAtIndex:i] CGRectValue];
            UIButton *tagButton = [[UIButton alloc] initWithFrame:tagFrame];
            [tagButton setTitle:[NSString stringWithFormat:@"#%@", [task.tagsArray objectAtIndex:i]] forState:UIControlStateNormal];
            tagButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
            [tagButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [tagButton addTarget:self action:@selector(tagTouched:) forControlEvents:UIControlEventTouchUpInside];
            tagButton.backgroundColor = [UIColor colorWithRed:1 green:greenVal/255 blue:0 alpha:1];
            //tagButton.backgroundColor = [UIColor orangeColor];
            [cell addSubview:tagButton];
        }
        
        return cell;
        
    
}

- (IBAction)tagTouched:(UIButton *)sender 
{
    NSString *tag = [sender.titleLabel.text substringFromIndex:1];
    if ([selectedTags containsObject:tag]) {
        [selectedTags removeObject:tag];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [selectedTags addObject:tag];
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    
    [self queryTasks];
    [self organizeTags];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2) {
        [self queryTasks];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2) {
        [self queryTasks];
    }
}
- (IBAction)clearTags:(id)sender {
    [selectedTags removeAllObjects];
    [self queryTasks];
}

- (IBAction)newTask:(id)sender 
{
    [UIView animateWithDuration:0.4 animations:^{
        taskTableView.frame = CGRectMake(0, 245, 320, 460);
        createTaskView.frame = CGRectMake(0, 0, 320, 245);
    }];
}

- (IBAction)showHideTags:(id)sender 
{
     
    if (tagsHidden) {
        [self organizeTags];
        [UIView animateWithDuration:0.4 animations:^{
            taskTableView.frame = CGRectMake(0, 0, 320, 260);
            tagView.frame = CGRectMake(0, 260, 320, 200);
        }];
    } else {
        [UIView animateWithDuration:0.4 animations:^{
             tagView.frame = CGRectMake(0, 480, 320, 200);
             taskTableView.frame = CGRectMake(0, 0, 320, 460);
        }];
    }
    
    tagsHidden = !tagsHidden;
  
}



- (void)finishedCreatingNewTask
{
    [UIView animateWithDuration:0.4 animations:^{
        taskTableView.frame = CGRectMake(0, 0, 320, 460);
        createTaskView.frame = CGRectMake(0, -245, 320, 245);
    }];
    [self.view endEditing:YES];
    textView.text = @"";
    validTasks = [[NSMutableArray alloc] initWithArray:ts.allTasks];
    [ts compileTags];
    [self.taskTableView reloadData];
}

- (IBAction)toggleEditingMode:(id)sender 
{
    if ([self isEditing]) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES];
    }
}

- (void)setEditing:(BOOL)isEditing animated:(BOOL)animated {
    [super setEditing:isEditing animated:animated]; 
    [self.taskTableView setEditing:isEditing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            NSLog(@"validTasks count: %i", [validTasks count]);
            Task *t = [validTasks objectAtIndex:indexPath.row];
            NSLog(@"deleting task from store");
            [validTasks removeObject:t];
            [ts removeTask:t];
            [self.taskTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
            [ts compileTags];
        }
    }
    
}

- (void)organizeTags
{
    [[tagScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int x_coord = 0;
    int y_coord = 0;
    
    for (NSString *tag in ts.tags) {
        NSString *hashTagged = [NSString stringWithFormat:@"#%@", tag];
        CGSize constraint = CGSizeMake(300, 400000);
        CGSize wordSize = [hashTagged sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                                               constrainedToSize:constraint
                                                                   lineBreakMode:UILineBreakModeWordWrap];
        if (x_coord + wordSize.width > 320) {
            x_coord = 0;
            y_coord += 30;
        } 

        UIButton *tagButton = [[UIButton alloc] initWithFrame:CGRectMake(x_coord, y_coord, wordSize.width, wordSize.height)];
        [tagScrollView addSubview:tagButton];
        [tagButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
        [tagButton setTitle:hashTagged forState:UIControlStateNormal];
        if ([selectedTags containsObject:tag]) {
            [tagButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        } else {
            [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        [tagButton addTarget:self action:@selector(tagTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        x_coord += wordSize.width + 20;
    }
    
    tagScrollView.contentSize = CGSizeMake(320, y_coord + 40);
}

- (IBAction)save:(id)sender 
{
    NSString *trimmedText = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (![trimmedText isEqualToString:@""]) {
        [[TaskStore singleton] addTaskWithContent:trimmedText];
        [self finishedCreatingNewTask];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter text to save a task" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
        [alert show];
        
    }
    
}

- (IBAction)cancel:(id)sender {
    [self finishedCreatingNewTask];
}

- (IBAction)hashTag:(id)sender 
{
    textView.text = [NSString stringWithFormat:@"%@#", textView.text];
}
@end
