//
//  Task.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Task.h"

@implementation Task
@synthesize tags;
@synthesize content;
@synthesize date_created;

- (id)init 
{
    self = [super init];
    if (self) {
        tags = [[NSMutableArray alloc] init];
        content = [[NSString alloc] init];
        date_created = [NSDate date];
    }
    
    return self;
}

- (void)findAllTags
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:&error];
    NSArray *matches = [regex matchesInString:self.content options:0 range:NSMakeRange(0, self.content.length)];
    for (NSTextCheckingResult *match in matches) {
        NSRange wordRange = [match rangeAtIndex:1];
        NSString* word = [self.content substringWithRange:wordRange];
        [self.tags addObject:word];
    }
}


@end
