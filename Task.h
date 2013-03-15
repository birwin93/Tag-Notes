//
//  Task.h
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *date_created;
@property (strong, nonatomic) NSMutableArray *tags;

- (void)findAllTags;

@end
