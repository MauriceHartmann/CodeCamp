//
//  AppDelegate.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "AppDelegate.h"
#import "Share.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
NSMutableDictionary *dict;
NSString *path;
NSFileManager *myManager;
Share* myShare;
int counter = 4; // remove later

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Create or find a file to write to or read from
    myShare = Share.sharedSingleton;
    dict = myShare.passedMutableDict;
    myManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"values.txt"]; // Name of file is vaues.txt

    if([myManager fileExistsAtPath:path]){
        dict = [NSMutableDictionary dictionaryWithContentsOfFile:path]; // Copy Values of file in our dictionary
        NSLog(@"Read");
        myShare.passedMutableDict = dict; // Copy files back into our singleton
    }else{
        NSLog(@"created");
        dict = [NSMutableDictionary dictionary];
        //Create dict using default values if no file was found
        [dict setObject: @100  forKey: @"hunger"];
        [dict setObject: @100  forKey: @"thirst"];
        [dict setObject: @10 forKey: @"fodder"];
        [dict setObject: @10 forKey: @"drinks"];
        for (NSString *key in dict)
            NSLog(@"%@: %@", key, [dict valueForKey:key]) ;
        myShare.passedMutableDict = dict; // Copy files back to singleton
    }
    // Override point for customization after application launch.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    
    tabBarItem1 = [tabBarItem1 initWithTitle:@"Home" image:[UIImage imageNamed:@"home_button.png"] selectedImage:[UIImage imageNamed:@"home_button.png"]];
    tabBarItem2 = [tabBarItem2 initWithTitle:@"Saloon" image:[UIImage imageNamed:@"saloon_button.png"] selectedImage:[UIImage imageNamed:@"saloon_button.png"]];
    tabBarItem3 = [tabBarItem3 initWithTitle:@"Mall" image:[UIImage imageNamed:@"mall_button.png"] selectedImage:[UIImage imageNamed:@"mall_button.png"]];
    
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    dict = myShare.passedMutableDict;
    NSNumber* z = [dict valueForKey:@"hunger"];
    NSNumber* u = [NSNumber numberWithInt:([z intValue] -2)];
    [dict setValue: u forKey:@"hunger"];
    [dict writeToFile:path atomically:YES]; // Write everything to file to save status
    NSLog(@"written");
    for (NSString *key in dict)
        NSLog(@"%@: %@", key, [dict valueForKey:key]) ;
    myShare.passedMutableDict = dict;
    counter --;
    if(counter == 0){
        [AppDelegate deleteFile];
    }
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

+ (NSNumber*)intToNS:(int) val{ // HelpMethod
    NSNumber *t = [NSNumber numberWithInt:(val)];
    return t;
}

+(void)deleteFile{
    [myManager removeItemAtPath: path error: nil];
    NSLog(@"delete");
}


@end
