//
//  AppDelegate.m
//  Tag
//
//  Created by Billy Irwin on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Task.h"
#import "TaskStore.h"
@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"ipad-menubar-left.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    // Override point for customization after application launch.
   /* NSString *tag1 = [NSString stringWithFormat:@"tag1"];
    NSString *tag2 = [NSString stringWithFormat:@"tag2"];
    NSString *tag3 = [NSString stringWithFormat:@"tag3"];
    NSString *tag4 = [NSString stringWithFormat:@"tag4"];
    NSString *tag5 = [NSString stringWithFormat:@"tag5"];
    NSString *tag6 = [NSString stringWithFormat:@"tag6"];
    NSString *task1 = [NSString stringWithFormat:@"Trying out #"];
    NSString *task2 = [NSString stringWithFormat:@"another #"];
    NSString *task3 = [NSString stringWithFormat:@"This is a longer string to render #"];
    NSString *task4 = [NSString stringWithFormat:@"Testing testing testing #"];
    NSString *task5 = [NSString stringWithFormat:@"Quick and Simple #"];
    NSString *task6 = [NSString stringWithFormat:@"#"];
    NSString *task7 = [NSString stringWithFormat:@"Hope this works #"];
    NSString *task8 = [NSString stringWithFormat:@"Yet another #"];
    NSArray *tags = [NSArray arrayWithObjects:tag1, tag2, tag3, tag4, tag5, tag6, nil];
    NSArray *tasks = [NSArray arrayWithObjects:task1, task2, task3, task4, task5, task6, task7, task8, nil];
    srand(time(NULL));
    for (int i=0; i<100; i++) {
        int random = rand() % 6;
        int random2 = rand() % 8;
        NSLog(@"%i", random);
        NSString *tag = [tags objectAtIndex:random];
        NSString *task = [tasks objectAtIndex:random2];
        [[TaskStore singleton] addTaskWithContent:[NSString stringWithFormat:@"%@%@", task, tag]];
    }*/
    
    //[[TaskStore singleton] clearData];
    //[[TaskStore singleton] saveChanges];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[TaskStore singleton] saveChanges];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
