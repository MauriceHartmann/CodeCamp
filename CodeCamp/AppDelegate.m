//
//  AppDelegate.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "AppDelegate.h"
#import "Share.h"
#import "Creature.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
NSMutableDictionary *dict;
NSString *path;
NSFileManager *myManager;
Share* myShare;
Creature* pet;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    myShare = Share.sharedSingleton;
    [myShare initDict];
    
    pet = [[Creature alloc] init];
    [pet initCreature];
    
    [AppDelegate setupFile]; //Prepares File and Dictionary
    // Override point for customization after application launch.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1 = [tabBarItem1 initWithTitle:@"Home" image:[UIImage imageNamed:@"home_button.png"] selectedImage:[UIImage imageNamed:@"home_button.png"]];
    tabBarItem2 = [tabBarItem2 initWithTitle:@"Saloon" image:[UIImage imageNamed:@"saloon_button.png"] selectedImage:[UIImage imageNamed:@"saloon_button.png"]];
    tabBarItem3 = [tabBarItem3 initWithTitle:@"Mall" image:[UIImage imageNamed:@"mall_button.png"] selectedImage:[UIImage imageNamed:@"mall_button.png"]];
    tabBarItem5 = [tabBarItem5 initWithTitle:@"Games" image:[UIImage imageNamed:@"arcade_button.png"] selectedImage:[UIImage imageNamed:@"arcade_button.png"]];
    
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [myShare dictToTxt:path]; // Write everything to file to save status
    [myShare createKeyWith:@"time" :[NSDate date]];
    NSLog(@"written");
    [myShare printAll];
    [pet prepareBackgroundNotification];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [Creature updateAfterReturn];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [myShare dictToTxt:path]; // Write everything to file to save status
    [myShare createKeyWith:@"time" :[NSDate date]];
    [pet prepareBackgroundNotification];
}

// deletes File and resets all values
+(void)deleteFile{
    myManager = [NSFileManager defaultManager]; // create New Manager when called from another class
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"values.txt"]; 
    [myManager removeItemAtPath: path error: nil];
    NSLog(@"delete");
    [AppDelegate setupFile];
}

+(void) setupFile{
    //Create or find a file to write to or read from
    myManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"values.txt"]; // Name of file is vaues.txt
    
    if([myManager fileExistsAtPath:path]){
        [myShare createFromFile:path]; // Copy Values of file in our dictionary
        NSLog(@"Read");
        [myShare printAll];
    }else{
        NSLog(@"created");
        [AppDelegate initDict];
    }}

//Create dict using default values if no file was found
+(void) initDict{
    NSLog(@"init");
    [myShare createKeyWith:@"hunger" : @100];
    
    [myShare changeValueOfKey:@"thirst" :@100];
    [myShare changeValueOfKey:@"dirt" :@100];
    [myShare changeValueOfKey:@"fodder" :@10];
    [myShare changeValueOfKey:@"drinks" :@10];
    [myShare createKeyWith:@"shampoo" :@10];
    [myShare createKeyWith:@"time" :[NSDate date]];
    [myShare changeValueOfKey:@"life" :@1];
    [myShare changeValueOfKey:@"money" :@1000];
    
    [myShare createKeyWith:@"awake" :@50];
    [myShare createKeyWith:@"sleep" :@1];
    [myShare createKeyWith:@"sleepTime" :@2100];
    [myShare createKeyWith:@"awakeTime" :@730];
    [myShare createKeyWith:@"midnight" :@2359];
    
    [myShare printAll];
    
    
}

@end
