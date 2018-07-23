//
//  AppDelegate.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
NSMutableDictionary *dict;
NSString *path;
NSFileManager *myManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    dict = [NSMutableDictionary dictionary];
    myManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"values.txt"];

    if([myManager fileExistsAtPath:path]){
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        NSLog(@"Read");
    }else{
        //create dict using default values
        [dict setObject: @100  forKey: @"hunger"];
        [dict setObject: @100  forKey: @"thirst"];
    }
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSNumber* z = [dict valueForKey:@"hunger"];
    NSNumber* u = [NSNumber numberWithInt:([z intValue] -2)];
    [dict setValue: u forKey:@"hunger"];
    [dict writeToFile:path atomically:YES];
    for (NSString *key in dict)
        NSLog(@"%@: %@", key, [dict valueForKey:key]) ;
    
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (NSNumber*)intToNS:(int) val{
    NSNumber *t = [NSNumber numberWithInt:(val)];
    return t;
}

@end
