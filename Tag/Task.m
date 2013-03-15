//
//  Task.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Task.h"


@implementation Task

@dynamic content;
@dynamic tags;
@dynamic date;
@dynamic picture;
@dynamic pictureData;
@dynamic htmlContent;
@synthesize tagsArray;
@synthesize stringArray;
@dynamic strings;
@dynamic labelFrames;
@synthesize framesArray;

#define START_X 10
#define START_Y 10
#define END_X 300

- (void)findAllTags
{
     NSError *error = nil;
     NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:&error];
     NSArray *matches = [regex matchesInString:self.content options:0 range:NSMakeRange(0, self.content.length)];

     for (NSTextCheckingResult *match in matches) {
     
         NSRange wordRange = [match rangeAtIndex:1];
         NSString* word = [self.content substringWithRange:wordRange];
         [self.tagsArray addObject:word];
         
         NSMutableString *substring = (NSMutableString *)[self.content substringToIndex:wordRange.location+wordRange.length];
         
         CGSize constraint = CGSizeMake(300, 400000);
         CGSize substringSize = [substring sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                         constrainedToSize:constraint
                                           lineBreakMode:UILineBreakModeWordWrap];
         
         CGSize wordSize = [[NSString stringWithFormat:@"#%@", word] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                          constrainedToSize:constraint
                                     lineBreakMode:UILineBreakModeWordWrap];
         
         float width = wordSize.width;
         float height = wordSize.height;
         
         float newHeight = substringSize.height;
         
         NSMutableString *targetLine = [[NSMutableString alloc] init];
         NSMutableArray *substringWords = [NSMutableArray arrayWithArray:[substring componentsSeparatedByString:@" "]];
         NSLog(@"substrings: %@", substringWords);
         
         while (newHeight == substringSize.height) {
             NSString *removedWord = [substringWords objectAtIndex:[substringWords count]-1];
             NSLog(@"removedWord: %@", removedWord);
             if ([targetLine length] == 0) {
                 [targetLine appendString:removedWord];
             } else {
                 [targetLine appendString:[NSString stringWithFormat:@"%@ ", removedWord]];
             }
             
             [substringWords removeLastObject];
             
             NSString *newString = [substringWords componentsJoinedByString:@" "];
             newHeight = [newString sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                                               constrainedToSize:constraint
                                                          lineBreakMode:UILineBreakModeWordWrap].height;
             
             NSLog(@"newString: %@, height: %f, oldHeight: %f", newString, newHeight, substringSize.height);
         }
         
    
         CGSize targetLineSize = [targetLine sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:20]
                                                 forWidth:300 
                                            lineBreakMode:UILineBreakModeWordWrap];
         
         NSLog(@"target line: %@, %f", targetLine, targetLineSize.width);
         float origin_y = newHeight;
         float origin_x = targetLineSize.width - width;
         
         NSLog(@"%@ %f %f %f %f", word, origin_x, origin_y, width, height);
         
         CGRect wordFrame = CGRectMake(origin_x+10, origin_y+10, width, height);
         NSValue *val = [NSValue valueWithCGRect:wordFrame];
         [self.framesArray addObject:val];
     }
}


-(void)loadTags
{
    if ([self.tags length] > 0) {
        self.tagsArray = [NSKeyedUnarchiver unarchiveObjectWithData:self.tags];
        self.stringArray = [NSKeyedUnarchiver unarchiveObjectWithData:self.strings];
        self.framesArray = [NSKeyedUnarchiver unarchiveObjectWithData:self.labelFrames];
    }
}

-(void)save
{
    self.tags = [NSKeyedArchiver archivedDataWithRootObject:self.tagsArray];
    self.strings = [NSKeyedArchiver archivedDataWithRootObject:self.stringArray];
    self.labelFrames = [NSKeyedArchiver archivedDataWithRootObject:self.framesArray];
}


@end
