//
//  TaskStore.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaskStore.h"

@implementation TaskStore
@synthesize tasks;

static TaskStore *ts = nil;

- (id)init
{
    self = [super init];
    if (self) {
        tasks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (TaskStore *)singleton
{
    if (!ts) {
        ts = [[TaskStore alloc] init];
    }
    
    return ts;
}



@end
