//
//  TaskStore.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaskStore.h"
#import "Task.h"
#import "UtilityFunctions.h"
#import <CoreData/CoreData.h>

@implementation TaskStore
@synthesize allTasks;
@synthesize model;
@synthesize context;
@synthesize tags;

static TaskStore *ts = nil;

+ (TaskStore *)singleton
{
    if (!ts) {
        ts = [[TaskStore alloc] init];
    }
    
    return ts;
}

-(id)init
{
    
    
    self = [super init];
    if (self) {
        
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        tags = [[NSMutableArray alloc] init];
        
        NSPersistentStoreCoordinator *psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSString *path = pathInDocumentDirectory(@"store.data");
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        
        [context setUndoManager:nil];
    }
    
    return self;
}

- (void)fetchTasksIfNecessary
{
    // fetch Task data from Core Data
    if (!allTasks) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Task"];
        [request setEntity:e];
        
        // Load Tasks in alphabetical order
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allTasks = [[NSMutableArray alloc] initWithArray:result];
        
        [self compileTags];
    }
    
    //NSLog(@"all task count: %i", [allTasks count]);
}

- (void)compileTags
{
    NSLog(@"getting all tags");
    
    for (Task *t in self.allTasks) {
        [t loadTags];
        for (NSString *tag in t.tagsArray) {
            if (![tags containsObject:tag]) {
                [tags addObject:tag];
            }
        }
    }
    
   /* NSLog(@"displaying all tags");
    NSLog(@"--------------------------------------------------");
    for (NSString *t in tags) {
        NSLog(@"%@", t);
    }
    NSLog(@"--------------------------------------------------"); */
}

- (BOOL)saveChanges
{
    NSError *err = nil;
    
    for (Task *t in allTasks) {        
        [t save];
    }
    
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    } else {
        NSLog(@"save successful");
    }
    return successful;
}

- (void)removeTask:(Task *)task
{
    [context deleteObject:task];
    [allTasks removeObjectIdenticalTo:task];
}

-(NSArray *)allTasks
{
    // return and load the array if necessary
    [self fetchTasksIfNecessary];
    return allTasks;
}

-(void)addTaskWithContent:(NSString *)content
{
    // check to see if array is loaded then add new Task ready for decryption
    [self fetchTasksIfNecessary];
    Task *t = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
                                               inManagedObjectContext:context];
    t.tagsArray = [[NSMutableArray alloc] init];
    t.stringArray = [[NSMutableArray alloc] init];
    t.framesArray = [[NSMutableArray alloc] init];
    t.content = content;
    t.date = [NSDate date];
    [t findAllTags];
    
    for (NSString *tag in t.tagsArray) {
        if (![tags containsObject:tag]) {
            [tags addObject:tag];
        }
    }
    
    [allTasks insertObject:t atIndex:0];
}

- (void)clearData
{
    [self fetchTasksIfNecessary];
    for (Task *t in allTasks) {
        [context deleteObject:t];
    }
    [self fetchTasksIfNecessary];
}


@end
