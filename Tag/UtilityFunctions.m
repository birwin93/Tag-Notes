//
//  UtilityFunctions.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UtilityFunctions.h"

// create source path to save contact data
NSString *pathInDocumentDirectory(NSString *fileName)
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:fileName];
}

NSString *createHTMLString(NSString *text)
{
    NSString* htmlString = [NSString stringWithFormat:
                            @"<html>"
                            "<style type=\"text/css\">"
                            "body { background-color: transparent; font-family:Helvetica Neue; font-size:20; color:white;}"
                            ".blue {color:#11b0f4;}"
                            "</style>"
                            "<body>"
                            "<p>%@</p>"
                            "</body></html>", text];
    return htmlString;
}