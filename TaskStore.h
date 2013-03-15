//
//  TaskStore.h
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskStore : NSObject

@property (strong, nonatomic) NSMutableArray *tasks;

+ (TaskStore *)singleton; 

@end
