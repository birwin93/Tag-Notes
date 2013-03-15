//
//  TaskStore.h
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskStore : NSObject

@property (strong, nonatomic) NSMutableArray *allTasks;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectModel *model;
@property (strong, nonatomic) NSMutableArray *tags;

+ (TaskStore *)singleton; 

-(void)addTaskWithContent:(NSString *)content;
-(NSArray *)allTasks;
- (void)removeTask:(Task *)task;
- (BOOL)saveChanges;
- (void)compileTags;
- (void)clearData;
@end
