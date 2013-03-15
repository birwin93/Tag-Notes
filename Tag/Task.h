//
//  Task.h
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject
@property (nonatomic, retain) NSString *htmlContent;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSData * tags;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) UIImage *picture;
@property (nonatomic, retain) NSData * pictureData;
@property (nonatomic, retain) NSMutableArray *tagsArray;
@property (nonatomic, retain) NSMutableArray *stringArray;
@property (nonatomic, retain) NSData *strings;
@property (nonatomic, retain) NSData *labelFrames;
@property (nonatomic, retain) NSMutableArray *framesArray;
- (void)findAllTags;
- (void)save;
- (void)loadTags;
- (BOOL)isTag;

@end